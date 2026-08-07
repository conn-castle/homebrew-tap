class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.16.0/al-darwin-arm64", using: :nounzip
      sha256 "04acf768dcfaa71c2f31064b39db4dfc8c2db2be5d0e3b556c660c862247fc98"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.16.0/al-darwin-amd64", using: :nounzip
      sha256 "e249de2acc4afe86eae5817f7e5338070d9c620420a4830facb43fcada4b2a8c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.16.0/al-linux-arm64", using: :nounzip
      sha256 "815463534f5ad25c42265c279cb9002b904b5b7e0bc5e96092af1f20397f0261"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.16.0/al-linux-amd64", using: :nounzip
      sha256 "6c99f1a15e0229bfed9bae417384ab765bd0525daaaf49fbb5a8f72894992403"
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
