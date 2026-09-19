class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.21.1/al-darwin-arm64", using: :nounzip
      sha256 "83836ee8f03a21febd76ab7cf848a120db09b5a5c367b07dcca012230362f248"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.21.1/al-darwin-amd64", using: :nounzip
      sha256 "f75c7b2f7662e90498eec8b273ac4889f5d98b4d2e49b5c8b783a3cd1d57a8b7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.21.1/al-linux-arm64", using: :nounzip
      sha256 "3854309f172da2cdfa67c03206cc72b0462b6ac811ef26d79289644a1786fa72"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.21.1/al-linux-amd64", using: :nounzip
      sha256 "22dc7ef5d8e3cd735234f8a4d5ba78e98868850d80ebdefdd589b0d733759c4f"
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
