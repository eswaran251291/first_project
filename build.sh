#!/bin/bash
# Shell Script for Jenkins Build (Alternative to batch script)
# This can be used on Linux-based Jenkins agents

echo "========================================"
echo "Starting Python Build Process"
echo "========================================"
echo "Build Number: $BUILD_NUMBER"
echo "Job Name: $JOB_NAME"
echo "Workspace: $WORKSPACE"
echo "Timestamp: $(date)"
echo "========================================"

# Set environment variables
export PYTHONPATH="$WORKSPACE"
export VENV_DIR="$WORKSPACE/venv"

echo ""
echo "[STAGE 1] Setting up Python environment..."
# Create virtual environment if it doesn't exist
if [ ! -d "$VENV_DIR" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to create virtual environment"
        exit 1
    fi
fi

# Activate virtual environment
source venv/bin/activate
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to activate virtual environment"
    exit 1
fi

echo "Python version:"
python --version

echo ""
echo "[STAGE 2] Building the application..."
# Run the Python application
python hello_world.py
if [ $? -ne 0 ]; then
    echo "ERROR: Application build failed"
    exit 1
fi

echo ""
echo "[STAGE 3] Running tests..."
# Simple test to verify the module can be imported
python -c "import hello_world; print('Test passed: Module imported successfully')"
if [ $? -ne 0 ]; then
    echo "ERROR: Tests failed"
    exit 1
fi

echo ""
echo "[STAGE 4] Creating build artifact..."
# Create distribution directory and copy files
mkdir -p dist
cp hello_world.py dist/
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to create build artifact"
    exit 1
fi

echo ""
echo "========================================"
echo "Build completed successfully!"
echo "Build artifacts created in dist/ directory"
echo "========================================"

# Set build status for Jenkins monitoring
export BUILD_STATUS="SUCCESS"
exit 0
