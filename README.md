# blaze
blaze

Command Utilities for Backblaze B2 File store Native API
- install command line tools
    - brew install b2-tools

For upload_dir.sh:
- set the account id env var: `export B2_ACCOUNT_ID="your_account_id"`
- set the application key env var: `export B2_APPLICATION_KEY="your_application_key"`
- authorize the account: `b2 authorize-account`
- set the bucket name env var: `export B2_BUCKET_NAME="your_bucket_name"` 
- chmod +x upload_dir.sh

```
upload_dir.sh directory_name
```
Note that the diretory name is a subdirectory of where the script is run from. For example, if the script is run from ~/Documents, and the directory_name is "my_dir", then the script will upload ~/Documents/my_dir to the bucket. The script will create the directory in the bucket if it does not exist.


