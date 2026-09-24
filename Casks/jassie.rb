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
