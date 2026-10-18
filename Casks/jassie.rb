cask "jassie" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "1.0.3"
  sha256 arm:          "55339f78c883e9b0c6126581238a95e9ab1dca2da3029d696d7c67ddab197dff",
         intel:        "485991e4c189577c5df9b26f0c41e56a69549bc74f79a7e651f543566e74f14e",
         arm64_linux:  "30a340dc22f95ab582ae29fd4978209c92e5b0858a4ec8baf3e33d24f6582058",
         x86_64_linux: "24e86e1892705d87f4f656ff5de3d867ea3f0714c661b04ca03b7fd1ee49a981"

  url "https://pub-61dc367041774690837aa2a72014be22.r2.dev/releases/#{version}/jassie-#{os}-#{arch}.tar.gz"
  name "Jassie Code"
  desc "AI-powered CLI for building, debugging, and shipping code"
  homepage "https://jassie.ai/"

  livecheck do
    url "https://pub-61dc367041774690837aa2a72014be22.r2.dev/releases/stable"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  binary "jassie"

  # Only one way of installing Jassie Code at a time: refuse next to a curl or apt install.
  preflight_steps do
    if_path_exists "/usr/local/lib/jassie/jassie" do
      run "/bin/sh", args: ["-c", "echo 'Jassie Code is already installed by the install script. " \
                                  "Remove it first: sudo rm -rf /usr/local/lib/jassie " \
                                  "/usr/local/bin/jassie' >&2; exit 1"]
    end
    if_path_exists "/opt/jassie/jassie" do
      run "/bin/sh", args: ["-c", "echo 'Jassie Code is already installed by apt. " \
                                  "Remove it first: sudo apt remove jassie' >&2; exit 1"]
    end
  end

  # No quarantine stripping: every macOS file in the download is signed and notarized
  # (jassie/scripts/sign-macos.sh), so Gatekeeper lets the quarantined copy run.

  # Settings, sessions, memory and the sign-in (~/.jassie) stay on uninstall and upgrade (Homebrew runs
  # uninstall steps on every upgrade); `brew uninstall --zap jassie` or `jassie uninstall` removes them.
  zap trash: "~/.jassie"
end
