cask "jassie" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "1.0.0"
  sha256 arm:          "ce59644b83ed7c075788788635c7e8b7132ba27482a1ec376177668ba6ec2b15",
         intel:        "ce59644b83ed7c075788788635c7e8b7132ba27482a1ec376177668ba6ec2b15"

  url "https://pub-ba9f136fd179474cb0451157d198c49a.r2.dev/releases/#{version}/jassie-#{os}-#{arch}.tar.gz"
  name "Jassie Code"
  desc "AI-powered CLI for building, debugging, and shipping code"
  homepage "https://jassie.ai/"

  depends_on formula: "clamav"

  livecheck do
    url "https://pub-ba9f136fd179474cb0451157d198c49a.r2.dev/releases/stable"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  preflight_steps do
    run "/bin/sh", args: ["-c", "rm -rf /tmp/_MEI* 2>/dev/null || true"], must_succeed: false
  end

  postflight_steps do
    run "/bin/sh", args: ["-c", "find /opt/homebrew/Caskroom/jassie -type f \\( -name '*.dylib' -o -name '*.so' \\) -exec codesign --force --sign - {} + 2>/dev/null || true"], must_succeed: false
    run "/bin/sh", args: ["-c", "codesign --force --sign - /opt/homebrew/Caskroom/jassie/*/jassie 2>/dev/null || true"], must_succeed: false
    run "/bin/sh", args: ["-c", "xattr -cr /opt/homebrew/Caskroom/jassie 2>/dev/null || true"], must_succeed: false
    run "/bin/sh", args: ["-c", "export PATH=/opt/homebrew/bin:/usr/local/bin:$PATH; python3 -m pip install --break-system-packages --quiet pyobjc 2>/dev/null || true"], must_succeed: false, network_access: true
    run "/bin/sh", args: ["-c", "export PATH=/opt/homebrew/bin:/usr/local/bin:$PATH; for p in /opt/homebrew /usr/local; do [ -f \"$p/etc/clamav/freshclam.conf.sample\" ] && ! [ -f \"$p/etc/clamav/freshclam.conf\" ] && cp \"$p/etc/clamav/freshclam.conf.sample\" \"$p/etc/clamav/freshclam.conf\" && sed -i '' 's/^Example$/# Example/' \"$p/etc/clamav/freshclam.conf\"; done; freshclam 2>/dev/null || true"], must_succeed: false, network_access: true
    run "/bin/sh", args: ["-c", "export PATH=/opt/homebrew/bin:/usr/local/bin:$PATH; python3 -m playwright install chromium 2>/dev/null || true"], must_succeed: false, network_access: true
    run "/bin/sh", args: ["-c", "export PATH=/opt/homebrew/bin:/usr/local/bin:$PATH; printf '%s' 'IyEvYmluL2Jhc2gKIyBIb21lYnJldyBydW5zIHVuaW5zdGFsbCBzY3JpcHRzIHdpdGggYSBtaW5pbWFsIFBBVEgg4oCUIHJlc3RvcmUgaXQKZXhwb3J0IFBBVEg9Ii9vcHQvaG9tZWJyZXcvYmluOi9vcHQvaG9tZWJyZXcvc2JpbjovdXNyL2xvY2FsL2JpbjovdXNyL2JpbjovYmluOi91c3Ivc2Jpbjovc2JpbjokUEFUSCIKCkxPRz0vdG1wL2phc3NpZS11bmluc3RhbGwubG9nCmVjaG8gIj09PSBKYXNzaWUgY2xlYW51cCA9PT0iID4gIiRMT0ciCgojIDEuIENhY2hlIGFuZCBzdGF0ZSAocHJlc2VydmUgY29uZmlnLmpzb24gZm9yIHJlaW5zdGFsbHMpCnJtIC1yZiAiJEhPTUUvLmNhY2hlL2phc3NpZSIgIiRIT01FLy5sb2NhbC9zaGFyZS9qYXNzaWUiICIkSE9NRS8ubG9jYWwvc3RhdGUvamFzc2llIgpmb3IgZCBpbiAiJEhPTUUvLmphc3NpZSIgIiRIT01FLy5jb25maWcvamFzc2llIjsgZG8KICBbIC1kICIkZCIgXSAmJiBmaW5kICIkZCIgLW1pbmRlcHRoIDEgLW1heGRlcHRoIDEgISAtbmFtZSAnY29uZmlnLmpzb24nIC1leGVjIHJtIC1yZiB7fSArIDI+L2Rldi9udWxsCmRvbmUKZWNobyAiZGF0YTogY2xlYW5lZCAoY29uZmlnIHByZXNlcnZlZCkiID4+ICIkTE9HIgoKIyAyLiBweW9iamM6IHJlbW92ZSBpZiBzYWZlCmlmIHB5dGhvbjMgLW0gcGlwIHNob3cgcHlvYmpjLWNvcmUgPi9kZXYvbnVsbCAyPiYxOyB0aGVuCiAgREVQUz0kKHB5dGhvbjMgLW0gcGlwIHNob3cgcHlvYmpjLWNvcmUgMj4vZGV2L251bGwgfCBncmVwICJeUmVxdWlyZWQtYnk6IiB8IHNlZCAicy9SZXF1aXJlZC1ieTogKi8vIikKICBTQUZFPXRydWUKICBJRlM9JywgJyByZWFkIC1yYSBJVEVNUyA8PDwgIiRERVBTIgogIGZvciBkIGluICIke0lURU1TW0BdfSI7IGRvCiAgICBbWyAteiAiJGQiIF1dICYmIGNvbnRpbnVlCiAgICBjYXNlICIkZCIgaW4KICAgICAgcHlvYmpjKnxQeU9iakMqfFB5QXV0b0dVSSkgOzsKICAgICAgKikgU0FGRT1mYWxzZTsgZWNobyAicHlvYmpjOiBrZXB0IChuZWVkZWQgYnkgJGQpIiA+PiAiJExPRyI7IGJyZWFrIDs7CiAgICBlc2FjCiAgZG9uZQogIGlmICRTQUZFOyB0aGVuCiAgICBweXRob24zIC1tIHBpcCB1bmluc3RhbGwgLS1icmVhay1zeXN0ZW0tcGFja2FnZXMgLXkgcHlvYmpjIHB5b2JqYy1jb3JlIFwKICAgICAgcHlvYmpjLWZyYW1ld29yay1BcHBsaWNhdGlvblNlcnZpY2VzIHB5b2JqYy1mcmFtZXdvcmstQ29jb2EgXAogICAgICBweW9iamMtZnJhbWV3b3JrLUNvcmVUZXh0IHB5b2JqYy1mcmFtZXdvcmstUXVhcnR6IDI+PiIkTE9HIiB8fCB0cnVlCiAgICAjIFNlY29uZCBwYXNzIGZvciB1c2VyIHNpdGUtcGFja2FnZXMKICAgIHB5dGhvbjMgLW0gcGlwIHVuaW5zdGFsbCAtLWJyZWFrLXN5c3RlbS1wYWNrYWdlcyAteSBweW9iamMgcHlvYmpjLWNvcmUgXAogICAgICBweW9iamMtZnJhbWV3b3JrLUFwcGxpY2F0aW9uU2VydmljZXMgcHlvYmpjLWZyYW1ld29yay1Db2NvYSBcCiAgICAgIHB5b2JqYy1mcmFtZXdvcmstQ29yZVRleHQgcHlvYmpjLWZyYW1ld29yay1RdWFydHogMj4+IiRMT0ciIHx8IHRydWUKICAgIGVjaG8gInB5b2JqYzogY2xlYW5lZCIgPj4gIiRMT0ciCiAgZmkKZmkKCiMgMy4gUGxheXdyaWdodCBicm93c2VycwppZiBweXRob24zIC1tIHBpcCBzaG93IHBsYXl3cmlnaHQgPi9kZXYvbnVsbCAyPiYxOyB0aGVuCiAgUFdfREVQUz0kKHB5dGhvbjMgLW0gcGlwIHNob3cgcGxheXdyaWdodCAyPi9kZXYvbnVsbCB8IGdyZXAgIl5SZXF1aXJlZC1ieToiIHwgc2VkICJzL1JlcXVpcmVkLWJ5OiAqLy8iKQogIGlmIFtbIC16ICIkUFdfREVQUyIgXV07IHRoZW4KICAgIHB5dGhvbjMgLW0gcGxheXdyaWdodCB1bmluc3RhbGwgMj4+IiRMT0ciIHx8IHRydWUKICAgIHJtIC1yZiAiJEhPTUUvTGlicmFyeS9DYWNoZXMvbXMtcGxheXdyaWdodCIgMj4vZGV2L251bGwKICAgIGVjaG8gInBsYXl3cmlnaHQgYnJvd3NlcnM6IGNsZWFuZWQiID4+ICIkTE9HIgogIGVsc2UKICAgIGVjaG8gInBsYXl3cmlnaHQ6IGtlcHQgKG5lZWRlZCBieSAkUFdfREVQUykiID4+ICIkTE9HIgogIGZpCmZpCgojIDQuIENsYW1BVgpDTEFNX1VTRVJTPSQoYnJldyB1c2VzIC0taW5zdGFsbGVkIGNsYW1hdiAyPi9kZXYvbnVsbCB8IGdyZXAgLXYgamFzc2llKQppZiBbWyAteiAiJENMQU1fVVNFUlMiIF1dOyB0aGVuCiAgYnJldyB1bmluc3RhbGwgLS1pZ25vcmUtZGVwZW5kZW5jaWVzIGNsYW1hdiAyPj4iJExPRyIgfHwgdHJ1ZQogIGJyZXcgYXV0b3JlbW92ZSAyPj4iJExPRyIgfHwgdHJ1ZQogIGVjaG8gImNsYW1hdjogY2xlYW5lZCIgPj4gIiRMT0ciCmVsc2UKICBlY2hvICJjbGFtYXY6IGtlcHQgKG5lZWRlZCBieSAkQ0xBTV9VU0VSUykiID4+ICIkTE9HIgpmaQoKZWNobyAiPT09IGRvbmUgPT09IiA+PiAiJExPRyIK' | base64 -d > /opt/homebrew/Caskroom/jassie/.uninstall.sh && chmod +x /opt/homebrew/Caskroom/jassie/.uninstall.sh"], must_succeed: false
  end

  binary "jassie"

  uninstall script: {
    executable: "/bin/bash",
    args:       ["/opt/homebrew/Caskroom/jassie/.uninstall.sh"],
  }
end
