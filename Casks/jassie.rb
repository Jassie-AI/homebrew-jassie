cask "jassie" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "1.0.45"
  sha256 arm:          "a6e6b9436ff2fabb658b59f8a2f07c2b61592ced6a3acaaedc177386f64854fa",
         intel:        "b5fd1e9f55ce5cf4a05590d78b66ecc6c8160b9399ca336516cef0a60e85bc4c",
         arm64_linux:  "e18c4595e0170c47324e264a54b9e56a34221d72d5ba6d1c8e1b00e0c20bc946",
         x86_64_linux: "3b71c8f004bcbf738af2e7cbd1a1d84d9d0ef37eb9c2a9772c297ca82bf771ec"

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
