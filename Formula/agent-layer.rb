class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.0/al-darwin-arm64", using: :nounzip
      sha256 "e53a4f60669403cacc055cb5f9fa055e781e75724e998f5ce723a060c8d67899"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.0/al-darwin-amd64", using: :nounzip
      sha256 "02fa7f997682a40e948ac880420e9041010e823287aef7d49cfbe0712a711ee4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.0/al-linux-arm64", using: :nounzip
      sha256 "361e900617c43afe2893fec32219b5eb688f5b4e38babafbf9aa7d767271c016"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.0/al-linux-amd64", using: :nounzip
      sha256 "b15c577770eb7b7a4fbc519104fa52136cfd2483f7ac464013073fefd1eb5631"
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
