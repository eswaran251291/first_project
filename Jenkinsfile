pipeline {
    agent any
    
    triggers {
        // Schedule to run every 4 hours at the 15th minute (00:15, 04:15, 08:15, 12:15, 16:15, 20:15)
        cron('15 */4 * * *')
    }
    
    environment {
        PYTHONPATH = "${WORKSPACE}"
        VENV_DIR = "${WORKSPACE}/venv"
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout the latest code from GitHub
                git branch: 'master', url: 'https://github.com/eswaran251291/first_project.git'
                echo "Checked out code from GitHub repository"
            }
        }
        
        stage('Setup Environment') {
            steps {
                script {
                    // Create virtual environment if it doesn't exist
                    if (!fileExists("${env.VENV_DIR}")) {
                        bat 'python -m venv venv'
                        echo "Created virtual environment"
                    }
                    
                    // Activate virtual environment and install dependencies
                    bat '''
                        call venv\\Scripts\\activate.bat
                        python --version
                        pip install --upgrade pip
                    '''
                    echo "Python environment setup completed"
                }
            }
        }
        
        stage('Build') {
            steps {
                bat '''
                    call venv\\Scripts\\activate.bat
                    echo "Building Python application..."
                    python hello_world.py
                '''
                echo "Build completed successfully"
            }
        }
        
        stage('Test') {
            steps {
                bat '''
                    call venv\\Scripts\\activate.bat
                    echo "Running tests..."
                    python -c "import hello_world; print('Test passed: Module imported successfully')"
                '''
                echo "Tests completed successfully"
            }
        }
        
        stage('Package') {
            steps {
                bat '''
                    echo "Creating build artifact..."
                    mkdir dist
                    copy hello_world.py dist\\
                    echo "Build artifact created in dist/ directory"
                '''
            }
        }
    }
    
    post {
        always {
            // Clean up workspace
            cleanWs()
        }
        
        success {
            echo "✅ Build SUCCESSFUL - All stages completed successfully"
            
            // Send success notification (example with email)
            emailext (
                subject: "✅ SUCCESS: Jenkins Build ${env.BUILD_NUMBER} - ${env.JOB_NAME}",
                body: """The Jenkins build completed successfully!
                
                Build Details:
                - Job: ${env.JOB_NAME}
                - Build Number: ${env.BUILD_NUMBER}
                - Status: SUCCESS
                - Duration: ${currentBuild.durationString}
                - Timestamp: ${new Date().format('yyyy-MM-dd HH:mm:ss')}
                
                Repository: https://github.com/eswaran251291/first_project.git
                
                View build details: ${env.BUILD_URL}
                """,
                to: 'eswaran91@gmail.com'
            )
        }
        
        failure {
            echo "❌ Build FAILED - One or more stages failed"
            
            // Send failure notification
            emailext (
                subject: "❌ FAILED: Jenkins Build ${env.BUILD_NUMBER} - ${env.JOB_NAME}",
                body: """The Jenkins build failed!
                
                Build Details:
                - Job: ${env.JOB_NAME}
                - Build Number: ${env.BUILD_NUMBER}
                - Status: FAILED
                - Duration: ${currentBuild.durationString}
                - Timestamp: ${new Date().format('yyyy-MM-dd HH:mm:ss')}
                
                Repository: https://github.com/eswaran251291/first_project.git
                
                View build details: ${env.BUILD_URL}
                
                Please check the build logs for more details.
                """,
                to: 'eswaran91@gmail.com'
            )
        }
        
        unstable {
            echo "⚠️ Build UNSTABLE - Some issues detected"
        }
    }
}
