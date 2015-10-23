This is not an official Google product.

# Homebrew formula for Google Authenticator

Enables Google Authenticator as a two-factor authentication
for Mac OS X ssh.

```shell
brew tap timothybasanov/google-authenticator
brew install google-authenticator
echo "auth required /usr/local/lib/security/pam_google_authenticator.so nullok" \
     | sudo tee -a /etc/pam.d/sshd
google-authenticator --force --time-based --disallow-reuse --rate-limit=3 \
     --rate-time=30 --window-size=10
```

See https://github.com/google/google-authenticator/tree/master/libpam
for more information.

> Caveat: As of August 2015 on Mac OS X El Capitan public beta `clang` crashes with a segfault.
> A workaround is to install `brew install gcc`. There is no pre-brewed bottle for
> El Capitan yet, installation can take hours.
> (see http://stackoverflow.com/questions/24966404/brew-install-gcc-too-time-consuming)
