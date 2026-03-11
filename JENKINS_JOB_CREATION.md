# Jenkins Pipeline Job Creation Guide

## Step-by-Step Instructions

### 1. Access Jenkins
- Open your web browser
- Navigate to your Jenkins server (e.g., `http://localhost:8080` or your Jenkins URL)
- Log in with your credentials

### 2. Create New Job
1. Click **"New Item"** on the Jenkins dashboard
2. Enter a **Job name** (e.g., `hello-world-pipeline`)
3. Select **"Pipeline"** as the job type
4. Click **"OK"**

### 3. Configure Pipeline Settings

#### General Tab
- **Description**: Add optional description like "Automated build for Hello World Python project"

#### Pipeline Tab (Most Important)
1. **Definition**: Select **"Pipeline script from SCM"**
2. **SCM**: Select **"Git"**
3. **Repository URL**: `https://github.com/eswaran251291/first_project.git`
4. **Credentials**: 
   - If your repo is private, click "Add" → "Jenkins" to add GitHub credentials
   - If public, leave as "None"
5. **Branch Specifier**: `*/master` (or `*/main` if your default branch is main)
6. **Script Path**: `Jenkinsfile` (this should be the default)

### 4. Configure Build Triggers (Optional - Already in Jenkinsfile)
The Jenkinsfile already contains the schedule, but you can also add:
1. Scroll to **"Build Triggers"** section
2. Check **"Build periodically"** (as backup)
3. Enter: `15 */4 * * *`

### 5. Save and Test
1. Click **"Apply"** then **"Save"**
2. Click **"Build Now"** to test the pipeline immediately
3. Monitor the build progress in the **"Console Output"**

### 6. Verify Scheduled Builds
- The pipeline will automatically run every 4 hours at the 15th minute
- Check **"Build History"** to see scheduled builds
- Monitor build status with the colored indicators (green = success, red = failure)

## Troubleshooting Tips

### Common Issues:
1. **Git clone fails**: Check repository URL and credentials
2. **Python not found**: Ensure Python is installed on Jenkins agent
3. **Permission denied**: Check Jenkins workspace permissions
4. **Build fails**: Check console output for specific error messages

### Debug Steps:
1. **Console Output**: Always check the detailed console output
2. **Workspace**: Browse the workspace to see if files are checked out correctly
3. **Pipeline Syntax**: Use Jenkins' "Pipeline Syntax" tool to validate Groovy syntax

## Advanced Configuration

### Environment Variables:
Add to Jenkinsfile or job configuration:
```groovy
environment {
    PYTHON_HOME = 'C:\\Python39'
    PATH = "${env.PYTHON_HOME}\\bin;${env.PATH}"
}
```

### Email Notifications:
Ensure Email Extension Plugin is installed and configured in:
- **Manage Jenkins** → **Configure System** → **Extended E-mail Notification**

### Build Artifacts:
Add to pipeline to archive build results:
```groovy
post {
    success {
        archiveArtifacts artifacts: 'dist/*', fingerprint: true
    }
}
```

## Next Steps After Setup:
1. Verify the first manual build succeeds
2. Check that scheduled builds run automatically
3. Monitor email notifications
4. Set up build monitoring dashboards if needed
