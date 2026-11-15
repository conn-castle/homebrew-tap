class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.3.0/al-darwin-arm64", using: :nounzip
      sha256 "a7302a1cd60ecff710d722d2f36a54a813e63207e1823b615783a49d870ac413"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.3.0/al-darwin-amd64", using: :nounzip
      sha256 "d1c9e1a211c1304139587b883c36e63195ac95e7f4b2ebcf516c52f569e9ad2c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.3.0/al-linux-arm64", using: :nounzip
      sha256 "66c9d6402f906f23d158e043bc255f64f6e9c908070f75ca97d19bfd6512dca5"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.3.0/al-linux-amd64", using: :nounzip
      sha256 "8d19abcac4a24d7a6fbfc01c2f500c8e9517c3e2b82e08a443fa3d86b46f98ac"
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
