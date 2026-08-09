class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.16.2/al-darwin-arm64", using: :nounzip
      sha256 "35aedc6f6013202115290511532f1aff7fef0239e67c8bdb95bbd3f0a2faaf32"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.16.2/al-darwin-amd64", using: :nounzip
      sha256 "1100ced3fecdcb09fc01c1e32c4c5b51fb6c10371b94ca3749ccdc7905e4b8bc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.16.2/al-linux-arm64", using: :nounzip
      sha256 "36a10a0efb9f56b3f7e54543d28c72af5e316a9b22f89d670fca18478d98fe10"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.16.2/al-linux-amd64", using: :nounzip
      sha256 "75fc93269727fb56c46d2d2ee939850440e3cbbb94bd20e0d51e08277a5ed153"
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
