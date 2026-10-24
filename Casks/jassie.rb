cask "jassie" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "1.0.47"
  sha256 arm:          "db976f55e64dc553ce12fd7ae5a58753d08ab372683e35ef5fd743c25a42efb4",
         intel:        "596bf9eb340a06e65771eccc8c46cf5edb81d9cc1d62a3db6263f3586179abf5",
         arm64_linux:  "9690c73aaeeb9551804734395f560c2cdedd01a016030c949e819c86ac17fa61",
         x86_64_linux: "458f2dad3e779e344eff2c3cceb5288669dc1a7b08231d6c2f1a89dc326eec91"

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
