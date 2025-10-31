#!/bin/bash
set -e

echo "=== Deploying React Vite App to Azure (Dev) ==="
echo ""

# Build React app
echo "Step 1: Building React app..."
cd ../React-App/react-app
npm run build

# Create zip
echo "Step 2: Creating deployment package..."
cd dist
rm -f ../build.zip
zip -r ../build.zip *
cd ..
echo "✅ Package created: $(ls -lh build.zip | awk '{print $5}')"

# Get Terraform outputs
echo ""
echo "Step 3: Getting deployment info..."
cd ~/terraform-react-workspaces
terraform workspace select dev

WEBAPP_NAME=$(terraform output -raw webapp_name)
RESOURCE_GROUP=$(terraform output -raw resource_group_name)
WEBAPP_URL=$(terraform output -raw webapp_url)

echo "  WebApp: $WEBAPP_NAME"
echo "  Resource Group: $RESOURCE_GROUP"
echo "  URL: $WEBAPP_URL"

# Deploy
echo ""
echo "Step 4: Deploying to Azure..."
cd ~/React-App/react-app

az webapp deploy \
  --resource-group $RESOURCE_GROUP \
  --name $WEBAPP_NAME \
  --src-path build.zip \
  --type static

# Verify
echo ""
echo "Step 5: Verifying deployment..."
sleep 30

HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $WEBAPP_URL)

if [ "$HTTP_STATUS" = "200" ]; then
  echo "✅ SUCCESS! App is live at: $WEBAPP_URL"
else
  echo "⚠️  Warning: Got HTTP status $HTTP_STATUS"
  echo "   App might still be starting up. Check: $WEBAPP_URL"
fi

echo ""
echo "=== Deployment Complete ==="