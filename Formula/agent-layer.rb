class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.24.0/al-darwin-arm64", using: :nounzip
      sha256 "2e0125542572ae1d1a99cbed938cf4d8e8fe1bfaa547128bd8c266fca4a1c04d"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.24.0/al-darwin-amd64", using: :nounzip
      sha256 "a19f8b27474fe3a355418e50a37be5f2382fad902ec476ce50d447531de4aed3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.24.0/al-linux-arm64", using: :nounzip
      sha256 "8d8689a78c21e89cf0c4fcf8c0c60b9b6ab97d67635fc205aa4cba092f5e2149"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.24.0/al-linux-amd64", using: :nounzip
      sha256 "4cf837e997eec4b1987c1cd5be156d3566908f00ba8e34564965e71733f71f71"
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
