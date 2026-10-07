class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.24.1/al-darwin-arm64", using: :nounzip
      sha256 "e0d23b68755158a23b650116129a599ecde56f9b259e4c8b2bb6b8327753c750"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.24.1/al-darwin-amd64", using: :nounzip
      sha256 "0cef570fe991ff292bbe647b898a3b2e906d07945c3fe7eaeff5ac8e1b1408be"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.24.1/al-linux-arm64", using: :nounzip
      sha256 "3cf4d3e8138ac6052ae150f22c0a0219969260fd0ed92a9a6195b04946df8539"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.24.1/al-linux-amd64", using: :nounzip
      sha256 "b4c72c6ad37d2b0337160705c77a74a2bdf767db07e8dbc6aa245fe8a53947aa"
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
