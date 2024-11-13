#!/bin/bash

# Prompt for Azure storage account name and key
read -p "Enter your Azure Storage Account Name: " AZURE_STORAGE_ACCOUNT
read -sp "Enter your Azure Storage Account Key: " AZURE_STORAGE_KEY
echo

# Save credentials to .env file
echo "AZURE_STORAGE_ACCOUNT=$AZURE_STORAGE_ACCOUNT" > .env
echo "AZURE_STORAGE_KEY=$AZURE_STORAGE_KEY" >> .env
chmod 600 .env

echo "Configuration saved. You can now use clouduploader.sh."