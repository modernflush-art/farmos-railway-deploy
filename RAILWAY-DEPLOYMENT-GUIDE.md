# 🚀 Complete Railway Deployment Guide

This guide will walk you through deploying your FarmOS application with PostgreSQL database on Railway step-by-step.

## 📋 Prerequisites

1. **Railway Account**: Sign up at https://railway.app
2. **GitHub Account**: Your code needs to be in a GitHub repository
3. **Git Installed**: To push your code to GitHub

## 🎯 Step-by-Step Deployment Process

### Step 1: Prepare Your Repository for Railway

First, let's make sure all files are ready and push to GitHub:

```bash
# 1. Initialize git repository (if not already done)
git init

# 2. Add all files to git
git add .

# 3. Commit your changes
git commit -m "Initial FarmOS setup with PostgreSQL for Railway deployment"

# 4. Add your GitHub repository as remote
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPOSITORY_NAME.git

# 5. Push to GitHub
git push -u origin main
```

**✅ Checkpoint**: Your code should now be available on GitHub.

### Step 2: Create New Railway Project

1. **Go to Railway**: Visit https://railway.app
2. **Login**: Use your GitHub account to login
3. **Create New Project**: Click "New Project"
4. **Deploy from GitHub**: Select "Deploy from GitHub repo"
5. **Select Repository**: Choose your FarmOS repository
6. **Import Project**: Railway will automatically detect your Dockerfile

**✅ Checkpoint**: Railway starts building your application.

### Step 3: Add PostgreSQL Database

1. **In your Railway project dashboard**, click "New Service"
2. **Select Database**: Choose "PostgreSQL"
3. **Deploy Database**: Railway creates a PostgreSQL instance
4. **Wait for deployment**: The database will take 1-2 minutes to be ready

**✅ Checkpoint**: You should see both "farmos" and "postgres" services in your dashboard.

### Step 4: Configure Environment Variables

Railway automatically provides database environment variables. Your application will use:

- `PGHOST` → becomes `DB_HOST`
- `PGPORT` → becomes `DB_PORT`
- `PGDATABASE` → becomes `DB_NAME`
- `PGUSER` → becomes `DB_USER`
- `PGPASSWORD` → becomes `DB_PASSWORD`

**No manual configuration needed!** The environment variables are automatically connected.

### Step 5: Configure Custom Domain (Optional)

1. **In your FarmOS service**, go to "Settings" → "Domains"
2. **Generate Domain**: Railway provides a free `.railway.app` domain
3. **Custom Domain** (optional): Add your own domain if you have one

**✅ Checkpoint**: Your application should be accessible via the Railway URL.

### Step 6: Complete FarmOS Installation

1. **Visit your Railway URL**: Click the generated URL from Railway dashboard
2. **Start Installation**: FarmOS installation wizard will appear
3. **Database Configuration**: Use these settings:
   - **Database type**: PostgreSQL
   - **Database name**: The auto-generated database name
   - **Database user**: The auto-generated username
   - **Database password**: The auto-generated password
   - **Host**: Use the internal database hostname
   - **Port**: 5432 (internal port)

**Note**: Railway handles all database connections internally, so use the provided credentials.

### Step 7: Enable Required PostgreSQL Extensions

After FarmOS installation:

1. **Go to Railway Dashboard** → **PostgreSQL service** → **Query tab**
2. **Run these commands**:
   ```sql
   CREATE EXTENSION IF NOT EXISTS pg_trgm;
   CREATE EXTENSION IF NOT EXISTS unaccent;
   CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
   ```

**✅ Checkpoint**: Extensions are installed and FarmOS is fully functional.

## 🔧 Railway Configuration Files

Your repository includes these Railway-specific files:

### `railway.json`
```json
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "DOCKERFILE",
    "dockerfilePath": "Dockerfile"
  },
  "deploy": {
    "startCommand": "apache2-foreground",
    "healthcheckPath": "/health.php",
    "healthcheckTimeout": 300,
    "restartPolicyType": "ON_FAILURE",
    "restartPolicyMaxRetries": 10
  }
}
```

### Enhanced `Dockerfile`
- Optimized for Railway deployment
- Includes PostgreSQL client
- Health check endpoint
- Proper file permissions

## 🌐 Accessing Your Deployed Application

### FarmOS Application
- **URL**: `https://your-app-name.railway.app`
- **Admin Access**: Complete setup through the installation wizard

### PostgreSQL Database
- **Access**: Through Railway dashboard → PostgreSQL service → Query tab
- **External Access**: Available via Railway's database connection details

## 📊 Monitoring and Management

### Railway Dashboard Features
1. **Logs**: View real-time application and database logs
2. **Metrics**: Monitor CPU, memory, and network usage
3. **Environment Variables**: Manage configuration settings
4. **Deployments**: View deployment history and rollback if needed

### Database Management
1. **Query Interface**: Run SQL commands directly in Railway
2. **Backups**: Railway automatically backs up your database
3. **Scaling**: Upgrade database resources as needed

## 🚀 Production Optimizations

### Security
- **Environment Variables**: All secrets are managed by Railway
- **HTTPS**: Automatically provided by Railway
- **Database Security**: Internal network isolation

### Performance
- **CDN**: Railway provides global CDN
- **Auto-scaling**: Automatically handles traffic spikes
- **Health Checks**: Automatic service recovery

### Backups
- **Automatic**: Railway backs up PostgreSQL automatically
- **Manual**: Use Railway dashboard to create manual backups
- **Export**: Download database dumps when needed

## 🆘 Troubleshooting

### Common Issues and Solutions

**1. Build Failures**
```bash
# Check build logs in Railway dashboard
# Ensure all files are committed to GitHub
git add . && git commit -m "Fix build" && git push
```

**2. Database Connection Issues**
- Verify PostgreSQL service is running in Railway
- Check environment variables are properly set
- Ensure pg_trgm extension is installed

**3. File Upload Issues**
- Railway provides persistent storage for uploads
- Check file permissions in the Dockerfile

**4. Performance Issues**
- Monitor resource usage in Railway dashboard
- Consider upgrading to higher Railway plan
- Optimize FarmOS configuration

### Getting Help
- **Railway Documentation**: https://docs.railway.app
- **FarmOS Documentation**: https://farmos.org/guide/
- **Railway Discord**: Community support available

## 💰 Cost Estimation

### Railway Pricing (as of 2024)
- **Starter Plan**: $5/month per service
- **PostgreSQL**: $5/month for basic database
- **Total Estimated**: ~$10-15/month for small to medium usage

### Cost Optimization Tips
1. **Monitor Usage**: Use Railway's usage dashboard
2. **Optimize Resources**: Right-size your services
3. **Development**: Use Railway's free tier for development

## ✅ Deployment Checklist

- [ ] Code pushed to GitHub
- [ ] Railway project created
- [ ] PostgreSQL database added
- [ ] Application deployed successfully
- [ ] FarmOS installation completed
- [ ] PostgreSQL extensions installed
- [ ] Domain configured
- [ ] Application tested and working
- [ ] Monitoring set up

**🎉 Congratulations! Your FarmOS application is now deployed on Railway with PostgreSQL!**

## 📞 Next Steps

1. **Complete FarmOS Setup**: Configure your farm settings
2. **Add Users**: Set up user accounts and permissions
3. **Import Data**: Upload existing farm data if applicable
4. **Monitor Performance**: Keep an eye on Railway metrics
5. **Plan Backups**: Set up additional backup strategies if needed

Your FarmOS application is now running in production on Railway! 🚀
