# Multi-File Environment Configuration

This document explains the multi-file environment configuration approach used in this Paperless-ngx setup.

## Overview

Instead of using a single `.env` file, this setup uses separate environment files for different services:

- `docker-compose.yml` - Main configuration file
- `db.env` - Database-specific environment variables
- `webserver.env` - Paperless-ngx application environment variables
- `.env` - Global variables used in docker-compose.yml (paths, ports)

## Why This Approach?

Using separate environment files solves several issues:

1. **Avoids complex variable substitution syntax** like `${VARIABLE:+NAME: ${VARIABLE}}` that can cause errors
2. **Improves organization** by grouping related variables together
3. **Simplifies troubleshooting** by isolating configuration issues
4. **Enhances security** by separating credentials

## File Structure

### docker-compose.yml

```yaml
services:
  db:
    env_file:
      - db.env
    
  webserver:
    env_file:
      - webserver.env
```

### db.env

Contains database credentials and settings:

```
POSTGRES_DB=paperless
POSTGRES_USER=paperless
POSTGRES_PASSWORD=paperless
```

### webserver.env

Contains Paperless-ngx application settings:

```
PAPERLESS_SECRET_KEY=secure_key
PAPERLESS_OCR_LANGUAGE=deu+eng
# Other application settings...
```

### .env

Contains global variables referenced in docker-compose.yml:

```
PAPERLESS_PORT=8000
PAPERLESS_MEDIA_DIR=/path/to/media
# Other path mappings...
```

## How to Use

1. Copy the example files:
   ```bash
   cp db.env.example db.env
   cp webserver.env.example webserver.env
   cp .env.example .env
   ```

2. Edit each file to configure your setup

3. Start the services:
   ```bash
   docker-compose up -d
   ```

For detailed configuration information, see the [Environment Configuration Guide](/docs/Environment_Configuration.md).
