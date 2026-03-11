# Python Not Found in Jenkins - Fix Guide

## Error: "Python was not found"

## Solutions:

### Solution 1: Update Jenkinsfile with Full Python Path
Replace the Python commands in your Jenkinsfile with full paths:

```groovy
pipeline {
    agent any
    
    environment {
        PYTHON_PATH = 'C:\\Python39\\python.exe'  // Update to your Python installation path
        VENV_DIR = "${WORKSPACE}\\venv"
    }
    
    stages {
        stage('Setup Environment') {
            steps {
                script {
                    // Create virtual environment with full Python path
                    bat '''"%PYTHON_PATH%" -m venv venv'''
                    
                    // Activate and install dependencies
                    bat '''
                        call venv\\Scripts\\activate.bat
                        "%PYTHON_PATH%" --version
                        "%PYTHON_PATH%" -m pip install --upgrade pip
                    '''
                }
            }
        }
        
        stage('Build') {
            steps {
                bat '''
                    call venv\\Scripts\\activate.bat
                    "%PYTHON_PATH%" hello_world.py
                '''
            }
        }
        
        stage('Test') {
            steps {
                bat '''
                    call venv\\Scripts\\activate.bat
                    "%PYTHON_PATH%" -c "import hello_world; print('Test passed: Module imported successfully')"
                '''
            }
        }
    }
}
```

### Solution 2: Find Python Installation Path
Run this on Jenkins server to find Python:
```cmd
where python
# Or check common locations:
C:\Python39\python.exe
C:\Python38\python.exe
C:\Python311\python.exe
C:\Users\Admin\AppData\Local\Programs\Python\Python39\python.exe
```

### Solution 3: Add Python to System PATH
1. **Windows Settings** → **System** → **About** → **Advanced system settings**
2. **Environment Variables** → **System variables** → **Path** → **Edit**
3. **Add**: `C:\Python39\` and `C:\Python39\Scripts\`
4. **Restart Jenkins service**

### Solution 4: Use Python Launcher
Replace `python` with `py` in Jenkinsfile:
```groovy
bat '''
    py -m venv venv
    call venv\\Scripts\\activate.bat
    py hello_world.py
'''
```

### Solution 5: Install Python on Jenkins Server
If Python is not installed:
1. Download Python from https://python.org
2. Install with "Add to PATH" option checked
3. Restart Jenkins

## Quick Fix for Your Jenkinsfile:
Update your Jenkinsfile to use the Python launcher `py` instead of `python`:

Replace:
```groovy
bat 'python -m venv venv'
```
With:
```groovy
bat 'py -m venv venv'
```

And update all `python` commands to `py` throughout the pipeline.
