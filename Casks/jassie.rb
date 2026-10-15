cask "jassie" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "1.0.0"
  sha256 arm:          "dc68fbc96ad88c729051b848bc56689bc6ac653cb9ab292b3bf57ee057ae14d2",
         intel:        "6f848ed1f0b548e698cbf254c96742dc46cac389f94c97cd712e7d90f650157f",
         arm64_linux:  "4bd254cffb53cf6580bf08cb234ad5488db13c074b0ab46aa427eb4ba849f252",
         x86_64_linux: "8f712235e9fe5bb22a8b812461671cbdae77963c696e8ab6707ab189d8805c0a"

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

  # Downloads are quarantined by macOS; the bundled runtimes must be runnable from a terminal.
  postflight_steps do
    if_path_exists "/opt/homebrew/Caskroom/jassie" do
      run "/bin/sh", args: ["-c", "xattr -dr com.apple.quarantine /opt/homebrew/Caskroom/jassie; true"]
    end
    if_path_exists "/usr/local/Caskroom/jassie" do
      run "/bin/sh", args: ["-c", "xattr -dr com.apple.quarantine /usr/local/Caskroom/jassie; true"]
    end
  end

  # Uninstalling removes everything Jassie Code kept: settings, sessions, memory and the sign-in
  # (~/.jassie). `jassie uninstall` does the same and also removes the icon font it copied.
  uninstall_postflight do
    FileUtils.rm_rf(File.expand_path("~/.jassie"))
  end
  zap trash: "~/.jassie"
end
