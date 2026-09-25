cask "jassie" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "1.0.0"
  sha256 arm:          "3ba4fb5b0be64fbafe49f175f9206081b58a2b63c7405e80ceec40cbf60042f1",
         intel:        "3ba4fb5b0be64fbafe49f175f9206081b58a2b63c7405e80ceec40cbf60042f1"

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
    run "/bin/sh", args: ["-c", "export PATH=/opt/homebrew/bin:/usr/local/bin:$PATH; python3 -m pip install --break-system-packages --quiet pyobjc 2>/dev/null || true"], must_succeed: false, network_access: true
    run "/bin/sh", args: ["-c", "export PATH=/opt/homebrew/bin:/usr/local/bin:$PATH; for p in /opt/homebrew /usr/local; do [ -f \"$p/etc/clamav/freshclam.conf.sample\" ] && ! [ -f \"$p/etc/clamav/freshclam.conf\" ] && cp \"$p/etc/clamav/freshclam.conf.sample\" \"$p/etc/clamav/freshclam.conf\" && sed -i '' 's/^Example$/# Example/' \"$p/etc/clamav/freshclam.conf\"; done; freshclam 2>/dev/null || true"], must_succeed: false, network_access: true
    run "/bin/sh", args: ["-c", "export PATH=/opt/homebrew/bin:/usr/local/bin:$PATH; python3 -m playwright install chromium 2>/dev/null || true"], must_succeed: false, network_access: true
  end

  postflight_steps do
    run "/bin/sh", args: ["-c", "find /opt/homebrew/Caskroom/jassie -exec xattr -d com.apple.provenance {} + 2>/dev/null || true"], must_succeed: false
    run "/bin/sh", args: ["-c", "export PATH=/opt/homebrew/bin:/usr/local/bin:$PATH; printf '%s' 'IyEvYmluL2Jhc2gKIyBIb21lYnJldyBydW5zIHVuaW5zdGFsbCBzY3JpcHRzIHdpdGggYSBtaW5pbWFsIFBBVEgg4oCUIHJlc3RvcmUgaXQKZXhwb3J0IFBBVEg9Ii9vcHQvaG9tZWJyZXcvYmluOi9vcHQvaG9tZWJyZXcvc2JpbjovdXNyL2xvY2FsL2JpbjovdXNyL2JpbjovYmluOi91c3Ivc2Jpbjovc2JpbjokUEFUSCIKCkxPRz0vdG1wL2phc3NpZS11bmluc3RhbGwubG9nCmVjaG8gIj09PSBKYXNzaWUgY2xlYW51cCA9PT0iID4gIiRMT0ciCgojIDEuIENvbmZpZyBhbmQgZGF0YQpybSAtcmYgIiRIT01FLy5qYXNzaWUiICIkSE9NRS8uY29uZmlnL2phc3NpZSIgIiRIT01FLy5jYWNoZS9qYXNzaWUiIFwKICAgICAgICIkSE9NRS8ubG9jYWwvc2hhcmUvamFzc2llIiAiJEhPTUUvLmxvY2FsL3N0YXRlL2phc3NpZSIKZWNobyAiY29uZmlnOiBjbGVhbmVkIiA+PiAiJExPRyIKCiMgMi4gcHlvYmpjOiByZW1vdmUgaWYgc2FmZQppZiBweXRob24zIC1tIHBpcCBzaG93IHB5b2JqYy1jb3JlID4vZGV2L251bGwgMj4mMTsgdGhlbgogIERFUFM9JChweXRob24zIC1tIHBpcCBzaG93IHB5b2JqYy1jb3JlIDI+L2Rldi9udWxsIHwgZ3JlcCAiXlJlcXVpcmVkLWJ5OiIgfCBzZWQgInMvUmVxdWlyZWQtYnk6ICovLyIpCiAgU0FGRT10cnVlCiAgSUZTPScsICcgcmVhZCAtcmEgSVRFTVMgPDw8ICIkREVQUyIKICBmb3IgZCBpbiAiJHtJVEVNU1tAXX0iOyBkbwogICAgW1sgLXogIiRkIiBdXSAmJiBjb250aW51ZQogICAgY2FzZSAiJGQiIGluCiAgICAgIHB5b2JqYyp8UHlPYmpDKnxQeUF1dG9HVUkpIDs7CiAgICAgICopIFNBRkU9ZmFsc2U7IGVjaG8gInB5b2JqYzoga2VwdCAobmVlZGVkIGJ5ICRkKSIgPj4gIiRMT0ciOyBicmVhayA7OwogICAgZXNhYwogIGRvbmUKICBpZiAkU0FGRTsgdGhlbgogICAgcHl0aG9uMyAtbSBwaXAgdW5pbnN0YWxsIC0tYnJlYWstc3lzdGVtLXBhY2thZ2VzIC15IHB5b2JqYyBweW9iamMtY29yZSBcCiAgICAgIHB5b2JqYy1mcmFtZXdvcmstQXBwbGljYXRpb25TZXJ2aWNlcyBweW9iamMtZnJhbWV3b3JrLUNvY29hIFwKICAgICAgcHlvYmpjLWZyYW1ld29yay1Db3JlVGV4dCBweW9iamMtZnJhbWV3b3JrLVF1YXJ0eiAyPj4iJExPRyIgfHwgdHJ1ZQogICAgIyBTZWNvbmQgcGFzcyBmb3IgdXNlciBzaXRlLXBhY2thZ2VzCiAgICBweXRob24zIC1tIHBpcCB1bmluc3RhbGwgLS1icmVhay1zeXN0ZW0tcGFja2FnZXMgLXkgcHlvYmpjIHB5b2JqYy1jb3JlIFwKICAgICAgcHlvYmpjLWZyYW1ld29yay1BcHBsaWNhdGlvblNlcnZpY2VzIHB5b2JqYy1mcmFtZXdvcmstQ29jb2EgXAogICAgICBweW9iamMtZnJhbWV3b3JrLUNvcmVUZXh0IHB5b2JqYy1mcmFtZXdvcmstUXVhcnR6IDI+PiIkTE9HIiB8fCB0cnVlCiAgICBlY2hvICJweW9iamM6IGNsZWFuZWQiID4+ICIkTE9HIgogIGZpCmZpCgojIDMuIFBsYXl3cmlnaHQgYnJvd3NlcnMKaWYgcHl0aG9uMyAtbSBwaXAgc2hvdyBwbGF5d3JpZ2h0ID4vZGV2L251bGwgMj4mMTsgdGhlbgogIFBXX0RFUFM9JChweXRob24zIC1tIHBpcCBzaG93IHBsYXl3cmlnaHQgMj4vZGV2L251bGwgfCBncmVwICJeUmVxdWlyZWQtYnk6IiB8IHNlZCAicy9SZXF1aXJlZC1ieTogKi8vIikKICBpZiBbWyAteiAiJFBXX0RFUFMiIF1dOyB0aGVuCiAgICBweXRob24zIC1tIHBsYXl3cmlnaHQgdW5pbnN0YWxsIDI+PiIkTE9HIiB8fCB0cnVlCiAgICBybSAtcmYgIiRIT01FL0xpYnJhcnkvQ2FjaGVzL21zLXBsYXl3cmlnaHQiIDI+L2Rldi9udWxsCiAgICBlY2hvICJwbGF5d3JpZ2h0IGJyb3dzZXJzOiBjbGVhbmVkIiA+PiAiJExPRyIKICBlbHNlCiAgICBlY2hvICJwbGF5d3JpZ2h0OiBrZXB0IChuZWVkZWQgYnkgJFBXX0RFUFMpIiA+PiAiJExPRyIKICBmaQpmaQoKIyA0LiBDbGFtQVYKQ0xBTV9VU0VSUz0kKGJyZXcgdXNlcyAtLWluc3RhbGxlZCBjbGFtYXYgMj4vZGV2L251bGwgfCBncmVwIC12IGphc3NpZSkKaWYgW1sgLXogIiRDTEFNX1VTRVJTIiBdXTsgdGhlbgogIGJyZXcgdW5pbnN0YWxsIC0taWdub3JlLWRlcGVuZGVuY2llcyBjbGFtYXYgMj4+IiRMT0ciIHx8IHRydWUKICBicmV3IGF1dG9yZW1vdmUgMj4+IiRMT0ciIHx8IHRydWUKICBlY2hvICJjbGFtYXY6IGNsZWFuZWQiID4+ICIkTE9HIgplbHNlCiAgZWNobyAiY2xhbWF2OiBrZXB0IChuZWVkZWQgYnkgJENMQU1fVVNFUlMpIiA+PiAiJExPRyIKZmkKCmVjaG8gIj09PSBkb25lID09PSIgPj4gIiRMT0ciCg==' | base64 -d > /opt/homebrew/Caskroom/jassie/.uninstall.sh && chmod +x /opt/homebrew/Caskroom/jassie/.uninstall.sh"], must_succeed: false
  end

  binary "jassie"

  uninstall script: {
    executable: "/bin/bash",
    args:       ["/opt/homebrew/Caskroom/jassie/.uninstall.sh"],
  }
end
