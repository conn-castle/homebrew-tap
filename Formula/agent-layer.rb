class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.9/al-darwin-arm64", using: :nounzip
      sha256 "7ea1c15d474295020080086ad75edabd6ff22bea11a054dabb3a4d2edaab0c59"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.9/al-darwin-amd64", using: :nounzip
      sha256 "180fba7f209adbaac6ae63f33a4aa40160596bc7235d83d987ef5c47b055d967"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.9/al-linux-arm64", using: :nounzip
      sha256 "4d2db5a28fbd842a18494ac516027341c4b3cf0ee86d4efd40f44b96cce65fa3"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.9/al-linux-amd64", using: :nounzip
      sha256 "5d0d65b3e1ff9ca18f46058b6d38b0943dc5e5714f2274151695f86f320a3d6b"
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
