cask "jassie" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "1.0.0"
  sha256 arm:          "4267c9de1c55e08cac01062ed74f28a80736387c00f2828292b2cf35858d3d02",
         intel:        "4267c9de1c55e08cac01062ed74f28a80736387c00f2828292b2cf35858d3d02",
         arm64_linux:  "8454e5a43ac537a3983ffc669c7d756607fc8a24e6a6594709272feeebb38fbe",
         x86_64_linux: "16ba6d2074bf4cd5a18167560cd403b376e3a7371b2d5970eb6b8eb233d85752"

  url "https://pub-ba9f136fd179474cb0451157d198c49a.r2.dev/releases/#{version}/jassie-#{os}-#{arch}"
  name "Jassie Code"
  container type: :naked
  desc "AI-powered CLI for building, debugging, and shipping code"
  homepage "https://jassie.ai"

  livecheck do
    url "https://pub-ba9f136fd179474cb0451157d198c49a.r2.dev/releases/stable"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  postflight_steps do
    on_macos do
      run "/bin/chmod", args: ["-R", "0755", "{{staged_path}}"]
      run "/usr/bin/xattr", args: ["-cr", "{{staged_path}}"]
    end
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
