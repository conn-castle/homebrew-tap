class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  version "0.12.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.12.3/al-darwin-arm64", using: :nounzip
      sha256 "84c58aa8513ae3e74786cb944fe0429a6260256376c0e3d86f140ce23c732553"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.12.3/al-darwin-amd64", using: :nounzip
      sha256 "cc13dd53f3da3710851e01f265aec3bd52722b2bfebe83455e5f3073d4ac89ca"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.12.3/al-linux-arm64", using: :nounzip
      sha256 "ec4baeeaa0b5107077423b9e3be7ed15186cc2e842631f75a8abf868f6706f2f"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.12.3/al-linux-amd64", using: :nounzip
      sha256 "e578a07c5e5d985b982c85b7f4bbd3c5e264a02dbff2320edb1a4989734d2821"
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
