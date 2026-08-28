class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.8/al-darwin-arm64", using: :nounzip
      sha256 "9173dd012612dcacea486ddb28b2ece5a887997124aed938eaf32cf19010a2a1"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.8/al-darwin-amd64", using: :nounzip
      sha256 "dfbeb1098c7f577d22534ab75fa02281264cfbec4aca78d70f77223ba30100ff"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.8/al-linux-arm64", using: :nounzip
      sha256 "1298564871607af158ee93710a98f3cc33cced162d7baec384420c01e3c1e608"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.8/al-linux-amd64", using: :nounzip
      sha256 "321530ce5b7ac918eb05cb1759c165f243651843d726d59bc2e15ee8ac5a2b0a"
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
