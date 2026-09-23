cask "jassie" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "1.0.0"
  sha256 arm:          "0000000000000000000000000000000000000000000000000000000000000000",
         intel:        "0000000000000000000000000000000000000000000000000000000000000000",
         arm64_linux:  "0000000000000000000000000000000000000000000000000000000000000000",
         x86_64_linux: "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/Jassie-AI/homebrew-jassie/releases/download/v#{version}/jassie-#{os}-#{arch}"
  name "Jassie Code"
  desc "AI-powered CLI for building, debugging, and shipping code"
  homepage "https://jassie.ai"

  livecheck do
    url "https://api.github.com/repos/Jassie-AI/homebrew-jassie/releases/latest"
    regex(/"tag_name":\s*"v?(\d+(?:\.\d+)+)"/i)
  end

  binary "jassie-#{os}-#{arch}", target: "jassie"

  zap trash: [
    "~/.jassie",
    "~/.config/jassie",
    "~/.cache/jassie",
    "~/.local/share/jassie",
    "~/.local/state/jassie",
  ]
end
