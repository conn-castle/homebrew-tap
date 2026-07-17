class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  version "0.13.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.13.0/al-darwin-arm64", using: :nounzip
      sha256 "494bbc75343fe4548e75527df13228d40036cb90ecf6b09327d4cf0334201b4d"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.13.0/al-darwin-amd64", using: :nounzip
      sha256 "617f91913238519c640c20a2fbfcaab72cbf8c82ed626d6bd3394629cfb0cbf4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.13.0/al-linux-arm64", using: :nounzip
      sha256 "ddf83b66f14bfe6125b4bb3e8074bb4f433dc5977d29c132384fc0e9173c31fe"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.13.0/al-linux-amd64", using: :nounzip
      sha256 "5d07f99d8fafe7cdcc71dab848d9b21197714462893069b9dc5533837ac845de"
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
