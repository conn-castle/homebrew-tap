class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.7/al-darwin-arm64", using: :nounzip
      sha256 "65a93aeb5f7d9ae73e2ce4258b92df4be8a4db331be359316a0b45b8a05f3af2"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.7/al-darwin-amd64", using: :nounzip
      sha256 "9fa830e1a8182e1d47cd49e9c2e828ca198dc66196bb5e54deed355cf9791485"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.7/al-linux-arm64", using: :nounzip
      sha256 "e8186bbd9803290bc469339eb215d57ed01b957610ef9885f6b52c1637e45589"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.7/al-linux-amd64", using: :nounzip
      sha256 "b2352b22fb01f10dc190cdbbfbbf8633a23bf785fbae42f8356d83102589c658"
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
