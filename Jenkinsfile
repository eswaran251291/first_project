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
                        bat 'py -m venv venv'
                        echo "Created virtual environment"
                    }
                    
                    // Activate virtual environment and install dependencies
                    bat '''
                        call venv\\Scripts\\activate.bat
                        py --version
                        py -m pip install --upgrade pip
                    '''
                    echo "Python environment setup completed"
                }
            }
        }
        
        stage('Build Hello World') {
            steps {
                bat '''
                    call venv\\Scripts\\activate.bat
                    echo "Building Hello World application..."
                    py hello_world.py
                '''
                echo "Hello World build completed successfully"
            }
        }
        
        stage('Build Hello Wipro') {
            steps {
                bat '''
                    call venv\\Scripts\\activate.bat
                    echo "Building Hello Wipro application..."
                    py hello_wipro.py
                '''
                echo "Hello Wipro build completed successfully"
            }
        }
        
        stage('Build Hello Jenkins') {
            steps {
                bat '''
                    call venv\\Scripts\\activate.bat
                    echo "Building Hello Jenkins application..."
                    py hello_jenkins.py
                '''
                echo "Hello Jenkins build completed successfully"
            }
        }
        
        stage('Test All Applications') {
            parallel {
                stage('Test Hello World') {
                    steps {
                        bat '''
                            call venv\\Scripts\\activate.bat
                            echo "Testing Hello World..."
                            py -c "import hello_world; print('Test passed: Hello World module imported successfully')"
                        '''
                    }
                }
                stage('Test Hello Wipro') {
                    steps {
                        bat '''
                            call venv\\Scripts\\activate.bat
                            echo "Testing Hello Wipro..."
                            py -c "import hello_wipro; print('Test passed: Hello Wipro module imported successfully')"
                        '''
                    }
                }
                stage('Test Hello Jenkins') {
                    steps {
                        bat '''
                            call venv\\Scripts\\activate.bat
                            echo "Testing Hello Jenkins..."
                            py -c "import hello_jenkins; print('Test passed: Hello Jenkins module imported successfully')"
                        '''
                    }
                }
            }
        }
        
        stage('Package All Applications') {
            steps {
                bat '''
                    echo "Creating build artifacts for all applications..."
                    mkdir dist
                    copy hello_world.py dist\\
                    copy hello_wipro.py dist\\
                    copy hello_jenkins.py dist\\
                    echo "All build artifacts created in dist/ directory"
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
            
            // Archive build artifacts
            archiveArtifacts artifacts: 'dist/*', fingerprint: true
            
            // Publish HTML report for build pipeline viewer
            publishHTML ( 
                target : [ 
                    allowMissing : false, 
                    alwaysLinkToLastBuild : true, 
                    keepAll : true, 
                    reportDir : 'dist', 
                    reportFiles : 'hello_*.py', 
                    reportName : 'Build Pipeline Report'
                ])
            
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
                
                Applications Built:
                - Hello World: ✅ SUCCESS
                - Hello Wipro: ✅ SUCCESS  
                - Hello Jenkins: ✅ SUCCESS
                
                Repository: https://github.com/eswaran251291/first_project.git
                
                View build details: ${env.BUILD_URL}
                View pipeline report: ${env.BUILD_URL}pipeline/
                """,
                to: 'eswaran91@gmail.com'
            )
        }
        
        failure {
            echo "❌ Build FAILED - One or more stages failed"
            
            // Archive any artifacts that were created before failure
            archiveArtifacts artifacts: 'dist/*', fingerprint: true, allowEmptyArchive: true
            
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
                View pipeline logs: ${env.BUILD_URL}console
                
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
