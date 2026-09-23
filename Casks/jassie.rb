cask "jassie" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "1.0.0"
  sha256 arm:          "0000000000000000000000000000000000000000000000000000000000000000",
         intel:        "0000000000000000000000000000000000000000000000000000000000000000",
         arm64_linux:  "0000000000000000000000000000000000000000000000000000000000000000",
         x86_64_linux: "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://pub-ba9f136fd179474cb0451157d198c49a.r2.dev/releases/#{version}/jassie-#{os}-#{arch}"
  name "Jassie Code"
  desc "AI-powered CLI for building, debugging, and shipping code"
  homepage "https://jassie.ai"

  livecheck do
    url "https://pub-ba9f136fd179474cb0451157d198c49a.r2.dev/releases/stable"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
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
