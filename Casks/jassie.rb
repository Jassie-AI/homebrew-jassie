cask "jassie" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "1.0.0"
  sha256 arm:          "c8589c830a087aaaccf384d7fcf6ce1894910ff6a90d8224afeac59149d9d5ac",
         intel:        "c8589c830a087aaaccf384d7fcf6ce1894910ff6a90d8224afeac59149d9d5ac",
         arm64_linux:  "1365c2c4d35f77360d7e903edfbb2da62d7caec750a25f1554de7b422c168f3d",
         x86_64_linux: "a55370c539541c9531d13a464078f20fd2f2b960795307e39016baed23bd057f"

  url "https://pub-ba9f136fd179474cb0451157d198c49a.r2.dev/releases/#{version}/jassie-#{os}-#{arch}"
  name "Jassie Code"
  container type: :naked
  desc "AI-powered CLI for building, debugging, and shipping code"
  homepage "https://jassie.ai"

  depends_on formula: "clamav"

  livecheck do
    url "https://pub-ba9f136fd179474cb0451157d198c49a.r2.dev/releases/stable"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  # Install ALL dependencies BEFORE the binary so everything works on first launch
  preflight_steps do
    # 1. Accessibility: pyobjc for macOS AX API
    run "/bin/sh", args: ["-c", "python3 -m pip install --break-system-packages --quiet pyobjc 2>/dev/null || true"], must_succeed: false
    # 2. ClamAV virus definitions: set up freshclam config and download database
    run "/bin/sh", args: ["-c", <<~SH], must_succeed: false
      CONF=""; for p in /opt/homebrew /usr/local; do
        [ -f "$p/etc/clamav/freshclam.conf" ] && CONF="$p/etc/clamav/freshclam.conf" && break
        [ -f "$p/etc/clamav/freshclam.conf.sample" ] && cp "$p/etc/clamav/freshclam.conf.sample" "$p/etc/clamav/freshclam.conf" && sed -i '' 's/^Example$/# Example/' "$p/etc/clamav/freshclam.conf" && CONF="$p/etc/clamav/freshclam.conf" && break
      done
      freshclam 2>/dev/null || true
    SH
    # 3. Playwright Chromium browser for web rendering
    run "/bin/sh", args: ["-c", "python3 -m playwright install chromium 2>/dev/null || true"], must_succeed: false
    # 4. Rename downloaded binary
    run "/bin/sh", args: ["-c", "mv '{{staged_path}}'/jassie-* '{{staged_path}}/jassie'"], must_succeed: true
  end

  # Clear macOS quarantine/provenance attributes so Gatekeeper doesn't scan on every launch
  postflight_steps do
    run "/bin/sh", args: ["-c", "find /opt/homebrew/Caskroom/jassie -exec xattr -d com.apple.provenance {} + 2>/dev/null || true"]
  end

  binary "jassie"

  uninstall script: {
    executable: "/bin/sh",
    args:       ["-c", "rm -rf \"$HOME/.jassie\" \"$HOME/.config/jassie\" \"$HOME/.cache/jassie\" \"$HOME/.local/share/jassie\" \"$HOME/.local/state/jassie\""],
  }
end
