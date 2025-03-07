# 📁 Guide: Samba Installation and Configuration for Paperless-ngx

This guide describes the **installation and configuration** of a Samba server in an **LXC container** to provide shared folders for **Paperless-ngx**.

## ✅ 1. Check if Samba is installed

```bash
smbd --version
```

**Expected result:**
- If Samba is installed, the **version number** will be displayed (e.g., `Version 4.x.x`).
- If the command is not found, Samba needs to be installed.

## 🔧 2. Install Samba

```bash
apt update && apt install samba -y
```

## 🛠 3. Backup existing Samba configuration

```bash
cp /etc/samba/smb.conf /etc/samba/smb.conf.bak
```

## 📂 4. Configure Samba shares for Paperless-ngx

```bash
nano /etc/samba/smb.conf
```

Add the following configuration:

```ini
[Originals]
   path = /mnt/data/paperless/media/documents/originals
   browseable = yes
   read only = yes
   valid users = paperless

[Consume]
   path = /mnt/data/paperless/consume
   browseable = yes
   read only = no
   valid users = paperless
   force user = paperless
```

> **Note:** Adjust the paths to match your configuration in the `.env` file if you've modified the default paths.

## 🔍 5. Check permissions

Before changing permissions, check the current permissions of the target directory:

```bash
ls -ld /mnt/data/paperless/consume
```

Make sure the output matches the desired values. If not, proceed to the next step.

## 🔑 6. Set permissions

```bash
chown -R paperless:paperless /mnt/data/paperless/consume
chmod -R 770 /mnt/data/paperless/consume
```

## 👤 7. Add Samba user "paperless"

```bash
smbpasswd -a paperless
```

Follow the prompts to set a password for the paperless user.

## 🔄 8. Restart Samba service

```bash
systemctl restart smbd
systemctl status smbd
```

## 🖥️ 9. Test Samba shares

**Mac/Linux:**

```bash
smbclient -L //<LXC-IP> -U paperless
```

**Windows:**
1. Press `WIN + R`
2. Enter `\\<LXC-IP>` and press Enter
3. Enter username `paperless` and the password

## 🎯 Conclusion

The **Samba shares for Paperless-ngx** have been successfully set up! 🎉

## Integration with Docker Setup

If you're using this Samba configuration alongside the Docker setup in this repository, make sure:

1. The paths in the Samba configuration match those in your `.env` file
2. The user permissions are correctly set for the Docker containers to access the shared folders
3. If running Samba in a separate container or host, ensure proper network connectivity between the Samba server and the Paperless-ngx containers

## Security Considerations

- The Samba configuration provided is basic and focused on functionality
- For production environments, consider additional security measures:
  - Restricting access by IP address
  - Using encrypted connections
  - Implementing stronger authentication methods
  - Configuring a firewall to limit access to the Samba ports
