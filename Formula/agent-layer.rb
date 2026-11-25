class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.4.0/al-darwin-arm64", using: :nounzip
      sha256 "e4ba81c69b1c501f125783bd867efd8471cdc7a98398ae97b0c0eb84d0dde1a8"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.4.0/al-darwin-amd64", using: :nounzip
      sha256 "47a51ee06476ca757bc23a7ca051545cfc0da9e25130b54858185d87e9ea5c05"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.4.0/al-linux-arm64", using: :nounzip
      sha256 "4a40c5ecb69cf89041de98931eaaf2714b664f9349bcb392b24031255f5b2999"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.4.0/al-linux-amd64", using: :nounzip
      sha256 "bfd7dcab9604cde5c2c2bb3b9ff527171cd3b589349bda2b0f50653ee0a491c5"
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
