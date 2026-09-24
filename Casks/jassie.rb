cask "jassie" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "1.0.0"
  sha256 arm:          "b98fe41f6e81c8860e70fb5a8bf00b738140f688228c679a2b605738328dce3e",
         intel:        "b98fe41f6e81c8860e70fb5a8bf00b738140f688228c679a2b605738328dce3e",
         arm64_linux:  "d3ba6bf9c5c832a489d8cd89975766e8dbe030be08533cad88b63a45b3d9eaf1",
         x86_64_linux: "8a57f735c1b07120c6299731ca0638d8eebd5ca0771429d20c83bd0277cd2627"

  url "https://pub-ba9f136fd179474cb0451157d198c49a.r2.dev/releases/#{version}/jassie-#{os}-#{arch}"
  name "Jassie Code"
  container type: :naked
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
