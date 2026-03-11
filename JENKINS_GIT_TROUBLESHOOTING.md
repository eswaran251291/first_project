# Jenkins Git Connection Troubleshooting

## Error: "Failed to connect to repository"

## Solutions (Try in order):

### Solution 1: Check Jenkins Git Configuration
1. **Manage Jenkins** → **Global Tool Configuration**
2. Find **Git** section
3. Ensure Git path is correctly set (e.g., `C:\Program Files\Git\bin\git.exe`)
4. If not configured, click **"Add Git"** and specify the path

### Solution 2: Use SSH Instead of HTTPS
1. Generate SSH keys on Jenkins server:
   ```bash
   ssh-keygen -t rsa -b 4096 -C "jenkins@yourcompany.com"
   ```
2. Add public key to GitHub:
   - Copy `id_rsa.pub` content
   - Go to GitHub → Settings → SSH and GPG keys → New SSH key
3. In Jenkins job, change repository URL to:
   ```
   git@github.com:eswaran251291/first_project.git
   ```
4. Add SSH credentials in Jenkins

### Solution 3: Add GitHub Credentials
1. In Jenkins job configuration, click **"Add"** next to **Credentials**
2. Select **"Username with password"**
3. **Username**: Your GitHub username
4. **Password**: Your GitHub Personal Access Token (not password)
5. **ID**: Give it a name (e.g., `github-credentials`)
6. Click **"Add"**
7. Select the credentials from the dropdown

### Solution 4: Create GitHub Personal Access Token
1. Go to GitHub → Settings → Developer settings → Personal access tokens
2. Click **"Generate new token"**
3. Select scopes: `repo`, `user:email`
4. Copy the token
5. Use this token as password in Jenkins credentials

### Solution 5: Check Network/Proxy Settings
1. **Manage Jenkins** → **Manage Plugins** → **Advanced**
2. Check proxy settings if your organization uses a proxy
3. Ensure Jenkins can access github.com:
   ```bash
   # Test from Jenkins server
   curl -v https://api.github.com
   ```

### Solution 6: Install Required Plugins
Ensure these plugins are installed:
- **Git Plugin**
- **GitHub Plugin** 
- **Credentials Plugin**

### Solution 7: Jenkins Service Permissions
1. Check if Jenkins service has proper permissions
2. Ensure Jenkins can access network and Git executable

## Quick Test Commands:
Run these on Jenkins server to diagnose:
```bash
# Test Git installation
git --version

# Test repository access
git ls-remote https://github.com/eswaran251291/first_project.git HEAD

# Test network connectivity
ping github.com
```

## Most Likely Solution:
For your case, try **Solution 3** first - add GitHub credentials with a Personal Access Token, as the repository is accessible from your machine.
