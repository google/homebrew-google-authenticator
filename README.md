This is not an official Google product.

# Homebrew formula for Google Authenticator

Enables Google Authenticator as a two-factor authentication
for Mac OS X ssh.

```shell
brew tap tomascassidy/google-authenticator
brew install google-authenticator
echo "auth required /usr/local/lib/security/pam_google_authenticator.so nullok" \
     | sudo tee -a /etc/pam.d/sshd
google-authenticator --force --time-based --disallow-reuse --rate-limit=3 \
     --rate-time=30 --window-size=10
```

See https://github.com/google/google-authenticator-libpam
for more information.
