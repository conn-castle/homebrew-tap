class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.5.0/al-darwin-arm64", using: :nounzip
      sha256 "e2e1ed102bf8f619abbd79d8d283a28d39ea9f0bc9d1c98a18a12110904d7904"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.5.0/al-darwin-amd64", using: :nounzip
      sha256 "eb3612b80c9cf09680d6f95c35681e33bd8fe6e1a92c63dbf27e91ae04691bc5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.5.0/al-linux-arm64", using: :nounzip
      sha256 "33e8179a443d1c4d609eca092763a2e0eb97b2990984cab2bf1bde80714f58aa"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.5.0/al-linux-amd64", using: :nounzip
      sha256 "be027f577be580c2e4f1d46446399c5285775056b9b1a0a535c45311d386b6ae"
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
