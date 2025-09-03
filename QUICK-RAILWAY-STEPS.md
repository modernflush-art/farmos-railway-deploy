# 🚀 Quick Railway Deployment Steps

## Prerequisites ✅
- Railway account (https://railway.app)
- GitHub account
- Your code in a GitHub repository

## 5-Minute Railway Deployment

### Step 1: Prepare Your Code
```bash
# Run the deployment script to push your code
./deploy-to-railway.sh
```

### Step 2: Create Railway Project
1. Go to **https://railway.app**
2. Click **"New Project"**
3. Select **"Deploy from GitHub repo"**
4. Choose **your FarmOS repository**

### Step 3: Add PostgreSQL Database
1. In your project dashboard, click **"New Service"**
2. Select **"Database"** → **"PostgreSQL"**
3. Wait for database to deploy (1-2 minutes)

### Step 4: Configure FarmOS
1. **Visit your Railway app URL** (find it in dashboard)
2. **Complete FarmOS installation** using the database settings Railway provides
3. **Install PostgreSQL extensions** via Railway's database query interface:
   ```sql
   CREATE EXTENSION IF NOT EXISTS pg_trgm;
   CREATE EXTENSION IF NOT EXISTS unaccent;
   CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
   ```

### Step 5: You're Live! 🎉
Your FarmOS application is now running on Railway with PostgreSQL!

## 🔗 Important URLs
- **Railway Dashboard**: https://railway.app/dashboard
- **Your App**: `https://[your-app-name].railway.app`
- **Documentation**: See `RAILWAY-DEPLOYMENT-GUIDE.md` for details

## 💰 Cost
- **Estimated**: $10-15/month for basic usage
- **Free Tier**: Available for development/testing

## 🆘 Need Help?
1. Check `RAILWAY-DEPLOYMENT-GUIDE.md` for detailed instructions
2. Railway Discord: https://discord.gg/railway
3. FarmOS Documentation: https://farmos.org/guide/
