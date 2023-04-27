# Google Drive

Alfred Finder supports opening and editing documents with Google Drive and saving the changes back to Alfresco.

To activate this integration, you must create a Google OAuth 2.0 client and provide the credentials to Alfred Finder

## Creating a Google Drive OAuth client

1. Go to [https://console.developers.google.com/projectcreate](Google API Console)
2. Create a new project
3. Click on "Credentials" in the sidebar on the left
4. Click "Create credentials" and select "OAuth Client id"
5. Select application type "Web application"
6. Enter the URL(s) that are used to access Alfred Finder in "Authorized Origins" You can change these values later
7. Click "Create"
8. Copy the client id to the Alfred Finder configuration file

## Configuring Google Drive authentication

The google drive configuration can be loaded from any `*.yaml` file located in `Data Dictionary/Finder`

```yaml
- Version: 1
  Id: google-drive
  Enabled: true
  OAuth:
    ClientId: XXXXX
    ApiKey: YYYYY # Optional
    HostedDomain: example.com # Optional. Restrict to accounts in your Google Apps domain
```
