class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  version "0.12.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.12.2/al-darwin-arm64", using: :nounzip
      sha256 "e69a5ee80c5fb48cc680a32d666ffb0f6054f02f04e20b7a0c500701a408f58a"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.12.2/al-darwin-amd64", using: :nounzip
      sha256 "e5cd7273341271cdb91c56518482587af3c9c9fc3eef953020bc32e15e54f8cd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.12.2/al-linux-arm64", using: :nounzip
      sha256 "80b1fbadc2d789c3a09b59cd1cc887d394b2e230e6d71cf20455baf71498be9d"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.12.2/al-linux-amd64", using: :nounzip
      sha256 "281baeda81d45bf822441c9c922b2e3a27ce8867b7d21edb3f0d419f94af88a9"
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
