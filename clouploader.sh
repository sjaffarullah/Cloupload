#!/bin/bash
# main script

# Load environment variables from .env
if [ -f .env ]; then
    source .env
fi

# Check for environmental variables
if [ -z "$AZURE_STORAGE_ACCOUNT" ] || [ -z "$AZURE_STORAGE_CONTAINER" ] || [ -z "$AZURE_STORAGE_KEY" ]; then
    echo "Error: Azure Storage account, key, or container name not set. Please, run config.sh to configure."
    exit 1
fi

# Argument parsing
FILEPATH="$1"
ENCRYPT= false

shift
while [[ "$#" -gt 0 ]]; do
    case $1 in
    --encrypt) ENCRYPT = true ;;
    *) echo "Unknown option: $1"; exit 1;;
    esac
    shift
done

# Check if file exisits locally
if [ ! -f "$FILEPATH" ]; then
    echo "Error: File '$FILEPATH' not found" 
    exit 1
fi

# Encryption process if true
if [ "$ENCRYPT" = true ]; then
    ENCRYPTED_FILE="${FILEPATH}.enc"
    openssl aes-256-cbc -salt -in "$FILEPATH" -out "$ENCRYPTED_FILE" -k "securepassword"
    if [ $? -ne 0 ]; then
    echo "Error: Encryption failed."
    exit 1
  fi
  FILEPATH=$ENCRYPTED_FILE  
fi

# Check if file exists in Azure blob storage
BASENAME=$(basename "$FILEPATH")
EXISTS=$(az storage blob exists --account-name "$AZURE_STORAGE_ACCOUNT" --account-key "$AZURE_STORAGE_KEY" --container-name "$AZURE_STORAGE_CONTAINER" --name "$BASENAME" --output tsv)

if [ "$EXISTS" = "True" ]; then
    echo " File already exists in the cloud storage."
    read -p "Choose action - Overwrite (o), skip (s), or Rename (r): " OPTION
    case $OPTION in
     o) echo "Overwriting file..." ;;
     s) echo "Upload skipped."; exit 0 ;;
     r) read -p "Enter a new name for the file (without extension): " NEW_NAME
      BASENAME="${NEW_NAME}.${BASENAME##*.}" ;;
     *) echo "Invalid option"; exit 1 ;;
  esac
fi

# Upload the file
az storage blob upload --account-name "$AZURE_STORAGE_ACCOUNT" --account-key "$AZURE_STORAGE_KEY" --container-name "$AZURE_STORAGE_CONTAINER" --name "$BASENAME" --file "$FILEPATH"

# Check for successful upload
if [ $? -eq 0 ]; then
  echo "File uploaded successfully."
else
  echo "Error: Upload failed."
  exit 1
fi