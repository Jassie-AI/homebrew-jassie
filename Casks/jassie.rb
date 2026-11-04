cask "jassie" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "1.0.48"
  sha256 arm:          "bb03e5ab7cbce6959c5dc8185f33de31fe80fe4ec8b485b9dc9a98baacf46c62",
         intel:        "0edd9d64b23eb831a60188596b9134703978de5a907edf0a6ceab3a48e4bd5dd",
         arm64_linux:  "81dc889db72b9836f0ba8fbeee6fb923ed06ab5c586710a25ab0683fa9fd4d20",
         x86_64_linux: "d77db97fcc66c8c56725d23f97524462955a6f23b0e69a7d13a61191451da5de"

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
