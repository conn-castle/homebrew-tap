class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.23.0/al-darwin-arm64", using: :nounzip
      sha256 "d313e590e4affafd988398642162b227f0531e867fe41e410257c18f07586bc2"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.23.0/al-darwin-amd64", using: :nounzip
      sha256 "0f19faf2d9c21e12cfcd73cafc01da98ebf7cb056c2304a180d59b354de0fd9d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.23.0/al-linux-arm64", using: :nounzip
      sha256 "5fc56df2ec0f43f780b5b1b5224e1b01c5bad1853f561b199d8d067937709e0b"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.23.0/al-linux-amd64", using: :nounzip
      sha256 "5867674036cf2384b7adc2a5b61a8bbd9bfe3e4aafbac83f288131b65a4baa50"
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
