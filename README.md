# Paperless-ngx Docker Setup

This repository contains my personal Docker setup for running [Paperless-ngx](https://github.com/paperless-ngx/paperless-ngx), a document management system that helps you archive, index, and search your physical documents digitally.

## Overview

Paperless-ngx is a powerful tool that helps you transition to a paperless lifestyle by:
- Scanning and processing physical documents
- OCR (Optical Character Recognition) to make content searchable
- Organizing documents with tags, correspondents, and document types
- Providing a modern web interface to search and access your documents

This repository provides a containerized setup using Docker and Docker Compose, making it easy to deploy and maintain.

## Prerequisites

- Docker and Docker Compose installed on your system
- Basic understanding of Docker concepts
- A dedicated server/NAS or computer to run the service

## Installation

1. Clone this repository:
```bash
git clone https://github.com/oehrn/paperless-ngx.git
cd paperless-ngx
```

2. Configure your environment by copying and editing the environment files:
```bash
cp db.env.example db.env
cp webserver.env.example webserver.env
cp .env.example .env
```

3. Edit the environment files with your preferred settings:
   - Set your database credentials in `db.env`
   - Configure application settings in `webserver.env`
   - Adjust global settings and paths in `.env`

4. Start the containers:
```bash
docker-compose up -d
```

5. Access the web interface at `http://your-server-ip:8000`

See [Multi-File Environment Configuration](docs/Multi-File_Environment_Configuration.md) for more details on the environment setup.

## Configuration

This setup uses Docker volumes to persist data. The main volumes are:
- `data`: Contains the database and application data
- `media`: Stores your documents
- `consume`: Place documents here to be automatically imported
- `export`: Location for exported documents

## Usage

### Adding Documents

You can add documents to Paperless-ngx in several ways:
1. Upload through the web interface
2. Place files in the `consume` directory
3. Email documents (if configured)
4. Use the API

### Backup

Always ensure you have a proper backup strategy for your documents. This setup includes data volumes that should be backed up regularly.

## Updating

To update to the latest version of Paperless-ngx:

```bash
docker-compose pull
docker-compose down
docker-compose up -d
```

## Troubleshooting

If you encounter issues:
1. Check the container logs: `docker-compose logs -f`
2. Verify your environment settings
3. Ensure your file permissions are correct

## Contributing

Feel free to open issues or submit pull requests if you have improvements to this setup.

## License

This repository is shared under the same license as Paperless-ngx (GPL-3.0).

## Additional Configuration

This repository also includes guides for additional configurations:

- [Multi-File Environment Configuration](/docs/Multi-File_Environment_Configuration.md) - Learn about the environment file structure
- [Samba Configuration](/docs/Samba_Configuration.md) - Set up Samba shares for easy document uploading
- [Multi-Factor Authentication](/docs/MFA_Configuration.md) - Enhance security with MFA
- [Environment Configuration](/docs/Environment_Configuration.md) - Learn how to properly configure environment variables

## Resources

- [Official Paperless-ngx documentation](https://docs.paperless-ngx.com/)
- [Paperless-ngx GitHub Repository](https://github.com/paperless-ngx/paperless-ngx)
