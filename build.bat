@echo off
REM Jenkins Build Script for Python Hello World Project
REM This script can be used as a freestyle project build step

echo ========================================
echo Starting Python Build Process
echo ========================================
echo Build Number: %BUILD_NUMBER%
echo Job Name: %JOB_NAME%
echo Workspace: %WORKSPACE%
echo Timestamp: %DATE% %TIME%
echo ========================================

REM Set Python environment variables
set PYTHONPATH=%WORKSPACE%
set VENV_DIR=%WORKSPACE%\venv

echo.
echo [STAGE 1] Setting up Python environment...
REM Create virtual environment if it doesn't exist
if not exist "%VENV_DIR%" (
    echo Creating virtual environment...
    py -m venv venv
    if %ERRORLEVEL% neq 0 (
        echo ERROR: Failed to create virtual environment
        exit /b 1
    )
)

REM Activate virtual environment
call venv\Scripts\activate.bat
if %ERRORLEVEL% neq 0 (
    echo ERROR: Failed to activate virtual environment
    exit /b 1
)

echo Python version:
py --version

echo.
echo [STAGE 2] Building the application...
REM Run the Python application
py hello_world.py
if %ERRORLEVEL% neq 0 (
    echo ERROR: Application build failed
    exit /b 1
)

echo.
echo [STAGE 3] Running tests...
REM Simple test to verify the module can be imported
py -c "import hello_world; print('Test passed: Module imported successfully')"
if %ERRORLEVEL% neq 0 (
    echo ERROR: Tests failed
    exit /b 1
)

echo.
echo [STAGE 4] Creating build artifact...
REM Create distribution directory and copy files
if not exist "dist" mkdir dist
copy hello_world.py dist\
if %ERRORLEVEL% neq 0 (
    echo ERROR: Failed to create build artifact
    exit /b 1
)

echo.
echo ========================================
echo Build completed successfully!
echo Build artifacts created in dist/ directory
echo ========================================

REM Set build status for Jenkins monitoring
echo BUILD_STATUS=SUCCESS
exit /b 0
