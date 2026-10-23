cask "jassie" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "1.0.46"
  sha256 arm:          "126f536c7fdd15c23203d3e046bea70e10c881155136e4b1614c0d527128ff5c",
         intel:        "d6b53877d3583050143b9cc604cd29e4770f7e55cb163fcc9864e87b83af4b5b",
         arm64_linux:  "fb16e73083fc668acb012054eac0eb0722eabdbe81e6fbe53a46cda30a408039",
         x86_64_linux: "8c452453be55f9315704f929fb4cc04bd9159e5055a102787cbe502c2342816e"

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
