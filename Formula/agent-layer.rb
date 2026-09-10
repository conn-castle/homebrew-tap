class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.20.0/al-darwin-arm64", using: :nounzip
      sha256 "5fdecf5e1f55e67a59cf0bd6aafb4704c1c0dd92c9dbf1021c50c709bb3200ab"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.20.0/al-darwin-amd64", using: :nounzip
      sha256 "978b0bc54ed2b342b8c39720e585ee1db8ff088d468d65f77fd4e0d566fc59ca"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.20.0/al-linux-arm64", using: :nounzip
      sha256 "120384bc5cb771951008517d0dcbe0c709814ed57123976ed5ba793fa88512e4"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.20.0/al-linux-amd64", using: :nounzip
      sha256 "ddd3f0a6d7845b19ed380be3aec2f7279a00fdc0b50918fc92c6adf4398ba027"
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
