# Jenkins Setup Guide

## 1. Jenkins Pipeline Setup

### Option A: Pipeline Project (Recommended)
1. Create new "Pipeline" job in Jenkins
2. Add the `Jenkinsfile` to your GitHub repo
3. Configure:
   - Definition: "Pipeline script from SCM"
   - SCM: Git
   - Repository URL: `https://github.com/eswaran251291/first_project.git`
   - Script Path: `Jenkinsfile`

### Option B: Freestyle Project
1. Create new "Freestyle project"
2. Source Code Management: Git
3. Repository URL: `https://github.com/eswaran251291/first_project.git`
4. Build Steps: Add "Execute Windows batch command"
5. Command: `call build.bat`

## 2. Build Status Monitoring

### Automatic Status Reflection
- **Success**: Green ball in Jenkins dashboard
- **Failure**: Red ball in Jenkins dashboard
- **Unstable**: Yellow ball in Jenkins dashboard

### Email Notifications
Configure in Jenkins → Manage Jenkins → Configure System:
- SMTP server settings
- Default email: `eswaran91@gmail.com`

### API Monitoring
```bash
# Check build status via API
curl -u user:token http://jenkins:8080/job/your-job/lastBuild/api/json
```

## 3. Cron Schedule Configuration

### Cron Expression: `15 */4 * * *`
- **15**: 15th minute of the hour
- ***/4**: Every 4 hours
- **Run times**: 00:15, 04:15, 08:15, 12:15, 16:15, 20:15

### Setup Methods:
1. **Pipeline**: Add to `triggers` section in Jenkinsfile
2. **Freestyle**: Configure "Build periodically" in job settings
3. **Web UI**: Job → Configure → Build Triggers → "Build periodically"

## 4. Required Jenkins Plugins
- Pipeline Plugin
- Git Plugin
- Email Extension Plugin
- Workspace Cleanup Plugin

## 5. Environment Setup
- Python 3.x installed on Jenkins agent
- Git configured
- Sufficient permissions for workspace operations
