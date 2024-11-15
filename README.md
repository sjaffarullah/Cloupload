# Cloupload
A Bash-Based Azure CLI Tool for Seamless File Uploads to Azure Blob Storage

## Features
- Generate time-limited shareable links for uploaded files.
- Optional file encryption with AES-256.
- Supports dynamic handling of existing files (overwrite, skip, rename).

## Prerequisites
- **Active Azure Subscription**: Ensure you have an Azure subscription with permissions to create and manage Blob Storage containers.
- **Azure CLI**: Install and log in using `az login`. [Installation Guide](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- **OpenSSL**: Required for file encryption. [Installation Guide](https://openssl-library.org/source/index.html)
- **Bash**: A Bash shell is required (Linux, macOS, or Git Bash on Windows).


## How to setup
1. **Clone the Repository**  
   Clone the project repository to your local machine and move into the directory:
   ```bash
   git clone https://github.com/yourusername/clouduploader.git
   cd clouduploader
   ```
2. **Run the config script**
   Use the config.sh script to configure your Azure Storage credentials and create a .env file:
   ```bash
   ./setup.sh
   ```
3. **Verify the .env File**
   Check that the .env file has been created with the correct values:
   ```bash
   cat .env
   ```


## How to use
## Troubleshooting
## Contribution
