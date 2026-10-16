cask "jassie" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "1.0.0"
  sha256 arm:          "c77b5d120f10d0f99ecd833964069a79c49234b0bba5b63b016c6630e2cf68b6",
         intel:        "d3286e954bcfa1237f491b133d15b0050f8167300c63843f0c67a4cd8d140754",
         arm64_linux:  "1aa9606ce697285b02443242d5e3b416c1008c34b3231ab709ebb00d594c9c4c",
         x86_64_linux: "b760879e6b97f034cd9357829993833d0f663f95e4b63c7e833ea95b586c8ea6"

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

  # Settings, sessions, memory and the sign-in (~/.jassie) stay on uninstall and upgrade (Homebrew runs
  # uninstall steps on every upgrade); `brew uninstall --zap jassie` or `jassie uninstall` removes them.
  zap trash: "~/.jassie"
end
