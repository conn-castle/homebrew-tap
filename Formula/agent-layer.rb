class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.22.0/al-darwin-arm64", using: :nounzip
      sha256 "15fbc3bf2823de9783d0b57b1de0d0b514810160e8d26e86f00aacd4f919cfa8"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.22.0/al-darwin-amd64", using: :nounzip
      sha256 "52eb73c32582defe4a4213e0f6a5c9482c6e138a8fa29627bd099c47bde89084"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.22.0/al-linux-arm64", using: :nounzip
      sha256 "22c44aa18afe33d3375783c8cf2057e5a3a0f77d2dd1a6bf74dc4e101d7931f7"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.22.0/al-linux-amd64", using: :nounzip
      sha256 "ea16cc701e4ce62eb079e1d0520a56eb05f1d406fa6a72adda1998f79ff656e0"
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
