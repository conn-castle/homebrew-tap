class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.24.3/al-darwin-arm64", using: :nounzip
      sha256 "0027683e40d8f5db9693e3e69b7cbd78d899c58a1870120c9fd78e190e07a015"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.24.3/al-darwin-amd64", using: :nounzip
      sha256 "81a764d7d089756263f3512d8d9e94f3eaf6309a32e8ee32a4de44f2eda55eec"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.24.3/al-linux-arm64", using: :nounzip
      sha256 "fbb48660fee14663606336f5846535062d5767587d3e7d5656ec541d9460dc37"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.24.3/al-linux-amd64", using: :nounzip
      sha256 "17d5edf3b7377f5927cb2fcaf962c412065824db167b6a4ed1d9afadb69ff8be"
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
