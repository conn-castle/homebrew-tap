class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.2/al-darwin-arm64", using: :nounzip
      sha256 "ab8cfebb3d05062f2c6b822b017c6bb4a7b4f18bd930c9a415a7abf5c00b582e"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.2/al-darwin-amd64", using: :nounzip
      sha256 "8baad994a4c973d7ec17044a5e09eed1ef85471d00e781cea19a8138890ca42a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.2/al-linux-arm64", using: :nounzip
      sha256 "312df04a56369c938a8b6b67295bd9f6eb816c444068515f448eccce6942809c"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.2/al-linux-amd64", using: :nounzip
      sha256 "ac817de6071dd7166aa56f51d2d005438a0366424eccfbe87d10931a60e4e4e2"
    end
  end

  def install
    bin.install Dir["al-*"].first => "al"
    chmod 0555, bin/"al" # generate_completions_from_executable fails otherwise
    generate_completions_from_executable(bin/"al", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/al --version")
  end
end
