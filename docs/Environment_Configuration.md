# Environment Configuration Guide

This guide explains how to properly configure environment variables for the Paperless-ngx Docker setup.

## Using Separate Environment Files

The Docker Compose setup now uses separate environment files for different services:

1. **docker-compose.yml**: The main configuration file
2. **db.env**: Environment variables for the database service
3. **webserver.env**: Environment variables for the Paperless-ngx application
4. **.env**: (Optional) Global variables that might be referenced in docker-compose.yml

This approach provides better organization and avoids issues with complex variable substitution.

## Initial Setup

1. Copy the example environment files to create your own configuration:
   ```bash
   cp db.env.example db.env
   cp webserver.env.example webserver.env
   ```

2. Edit each file to adjust settings to your needs.

## Understanding the Configuration Files

### docker-compose.yml

The docker-compose.yml file references the environment files and may include some basic environment variables:

```yaml
services:
  db:
    env_file:
      - db.env
    environment:
      # Override or add variables here if needed
      
  webserver:
    env_file:
      - webserver.env
    environment:
      # Override or add variables here if needed
```

Variables defined directly in the `environment` section will override those in the env files.

### db.env

Contains database-specific configuration:

```
POSTGRES_DB=paperless
POSTGRES_USER=paperless
POSTGRES_PASSWORD=secure_database_password
```

### webserver.env

Contains Paperless-ngx application configuration:

```
# Server settings
PAPERLESS_SECRET_KEY=very_long_random_secure_string
#PAPERLESS_OCR_LANGUAGE=deu+eng
#PAPERLESS_TRUSTED_PROXIES=Your_Proxy_IP

# Uncomment to set admin credentials
# PAPERLESS_ADMIN_USER=admin
# PAPERLESS_ADMIN_PASSWORD=secure_admin_password

# Uncomment to set custom URL (only necessary for certain configurations)
# PAPERLESS_URL=https://paperless.example.com
```

## Benefits of Using Separate Environment Files

This approach offers several advantages:

1. **Simplified syntax**: No need for complex variable substitution like `${VARIABLE:+NAME: ${VARIABLE}}`
2. **Better organization**: Each service has its own dedicated configuration file
3. **Easier troubleshooting**: Configuration issues are isolated to specific files
4. **Improved security**: Sensitive credentials can be managed separately
5. **Cleaner Docker Compose file**: The main file remains focused on service definitions

## How Commenting Works

- A line beginning with `#` is considered a comment
- Commented variables are completely ignored by Docker
- To enable a variable, remove the `#` at the beginning of the line

## Best Practices

1. **Security**: 
   - Always change default passwords
   - Set a strong `PAPERLESS_SECRET_KEY`
   - Keep env files with credentials outside of version control

2. **Organization**:
   - Keep related variables together in the same file
   - Add comments to document your specific configuration choices
   - Use consistent naming conventions

3. **Maintenance**:
   - Backup your environment files in a secure location
   - Document any changes you make to the default configuration
   - Regularly review for outdated or unused variables

## Troubleshooting

If Paperless-ngx isn't respecting your environment settings:

1. Ensure your env files are in the same directory as your `docker-compose.yml` file
2. Check that variables are properly formatted without spaces around the `=` sign
3. Verify file permissions (env files should be readable by Docker)
4. Restart the containers completely after making changes: `docker-compose down && docker-compose up -d`
5. Inspect container environment: `docker-compose exec webserver env`

## Example Setup

For a typical setup, you would:

1. Configure database credentials in `db.env`
2. Set application settings in `webserver.env`
3. Use global settings in `.env` only if needed for volume paths or ports
4. Start the services with `docker-compose up -d`
