#!/bin/bash
# setup script

# Check Az login status
echo "Checking Azure login status..."
az account show &>/dev/null
if [ $? -ne 0 ]; then
    echo "You are not logged into Azure CLI. Initiating login..."
    az login
    if [ $? -ne 0 ]; then
        echo "Error: Azure login failed. Please try again."
        exit 1
    fi
else
    echo "Azure CLI login detected."
fi

# Prompt for Azure storage account name and key
read -p "Enter your Azure Storage Account Name: " AZURE_STORAGE_ACCOUNT
read -p "Enter your Azure Storage Container Name: " AZURE_STORAGE_CONTAINER
read -sp "Enter your Azure Storage Account Key: " AZURE_STORAGE_KEY
echo

# Save credentials to .env file
echo "AZURE_STORAGE_ACCOUNT=$AZURE_STORAGE_ACCOUNT" > .env
echo "AZURE_STORAGE_CONTAINER=$AZURE_STORAGE_CONTAINER" >> .env
echo "AZURE_STORAGE_KEY=$AZURE_STORAGE_KEY" >> .env
chmod 600 .env

echo "Configuration saved. You can now use clouduploader.sh."