# Copyright 2015 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


require 'formula'

# noinspection ALL
class GoogleAuthenticator < Formula
  homepage 'https://github.com/google/google-authenticator-libpam'
  head 'https://github.com/google/google-authenticator-libpam.git'

  url 'https://github.com/google/google-authenticator-libpam.git'

  depends_on 'autoconf' => :build
  depends_on 'automake' => :build
  depends_on 'libtool' => :build
  depends_on 'qrencode' => :recommended

  fails_with :clang do
    build 700
    cause 'clang: error: unable to execute command: Segmentation fault: 11'
  end

  def install
    cd 'src' do
      # I messed up with filename in a patch
      # # https://github.com/google/google-authenticator/pull/513
      inreplace 'google-authenticator.c', 'libqrencode.dylib.3', 'libqrencode.3.dylib'
    end

    system './bootstrap.sh'
    system './configure', '--disable-debug', '--disable-dependency-tracking',
        '--disable-silent-rules', "--prefix=#{prefix}"
    system 'make'
    system 'make', 'install'

  end

  def caveats; <<-EOS.undent
    Google Authenticator: https://github.com/google/google-authenticator-libpam

    Enable 2-factor authentication for ssh when authenticating via password:
        echo "auth required /usr/local/lib/security/pam_google_authenticator.so nullok" \
| sudo tee -a /etc/pam.d/sshd

    Each user should pair to his or her "Google Authenticator" phone application:
        google-authenticator --force --time-based --disallow-reuse --rate-limit=3 \
--rate-time=30 --window-size=10
    EOS
  end

  test do
    system 'google-authenticator', '--help'
  end
end
