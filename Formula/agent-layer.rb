class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.0.0/al-darwin-arm64", using: :nounzip
      sha256 "f4574d3efd09f5781c7433b474f506974563c9dcbb5f9778996176a164f575f4"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.0.0/al-darwin-amd64", using: :nounzip
      sha256 "1537fdf06d9f81cb150c500138f11ac393a8f6d88470c11a2aa1488b3b938bff"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.0.0/al-linux-arm64", using: :nounzip
      sha256 "1787c78749de757e37168305f7c96aead4fb57b3f6cc84a4670291cdf8c8c696"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.0.0/al-linux-amd64", using: :nounzip
      sha256 "7fd643334cdc890b9a3c9384c3c7a8a5c4fef2d45b6853c849c4f7da5bcad044"
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
