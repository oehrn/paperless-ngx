# 🔐 Multi-Factor Authentication (MFA) for Paperless-ngx

This guide describes the **setup of Multi-Factor Authentication (MFA)** in Paperless-ngx to enhance application security.

## 🔑 1. Access the Django Admin Interface

Open the admin interface at the following URL:

```
https://paperless.example.com/admin
```

Log in with an administrator account.

## 🆕 2. Add an Authenticator

1. Go to `MFA > Authenticators > Add Authenticator`.
2. Select the user for whom MFA should be enabled.
3. Choose **TOTP Authenticator** as the type.

## 📜 3. JSON Data Structure for the "Data" Field

The following JSON structure must be entered in the "Data" field:

```json
{
  "secret": "[CUSTOM_SECRET]",
  "issuer": "Paperless NGX",
  "label": "[USERNAME]",
  "algorithm": "SHA1",
  "digits": 6,
  "period": 30
}
```

**Explanation of parameters:**

- `secret`: The user's TOTP key.
- `issuer`: "Paperless NGX" (to identify the application).
- `label`: Username or unique description of the user.
- `algorithm`: Hash algorithm (default: SHA1).
- `digits`: Number of digits in the OTP (default: 6).
- `period`: Validity period of a code in seconds (default: 30).

## 🛠 4. Testing Multi-Factor Authentication

1. Scan the generated QR code with a TOTP app (e.g., Google Authenticator, Authy).
2. Perform a test login to confirm functionality.

**Result:** The MFA function has been successfully activated and tested.

## 📌 5. Important Notes

- 🔒 **Backup Key**: The user should securely store the TOTP key.
- 🔄 **Recovery**: If the user loses access, MFA can only be reset by an administrator.
- 👥 **Future Configurations**: Additional users can activate MFA in the same way.

*Documentation completed on: March 7, 2025*
