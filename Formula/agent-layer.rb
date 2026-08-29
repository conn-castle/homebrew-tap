class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.2/al-darwin-arm64", using: :nounzip
      sha256 "81f335e4b8b0c20f5eb590cb3ef069716fced1ada71ef39a61de1fbc2f866e2d"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.2/al-darwin-amd64", using: :nounzip
      sha256 "4a579d4dc7a1e5b96ddecbd21c940e775565eab95f968ab31f1c449ef1c9f167"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.2/al-linux-arm64", using: :nounzip
      sha256 "8e171e345d2031bcf5041b2d45d109bdf1d85df5e14a25ab595da024d6633a84"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.2/al-linux-amd64", using: :nounzip
      sha256 "989b6e3ef79bf10cf803c1a4a1644dbe8a171106b8e85c92d977d3acaaff60a8"
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
