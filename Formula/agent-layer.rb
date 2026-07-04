class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  version "0.12.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.12.1/al-darwin-arm64", using: :nounzip
      sha256 "245ab3244b0093a5f354c644a5f85908c16f834e002f670d0a837dfa8dbe638b"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.12.1/al-darwin-amd64", using: :nounzip
      sha256 "2c6ecaeee27e9d1fa7cd10b27c14e60dc1355eb684f74cabb0f1e250360e220b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.12.1/al-linux-arm64", using: :nounzip
      sha256 "26d9cfe9d59f2021920dd47db67ffc3c9ba548636ea6ada5cefd33e801b4df62"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.12.1/al-linux-amd64", using: :nounzip
      sha256 "3642d88d85c54f4672b2da03ff916b3f10b7ea07b1efe1f9377ba1091f90a171"
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
