class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  version "0.12.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.12.0/al-darwin-arm64", using: :nounzip
      sha256 "c94a812a42d02e7c954b0e2e8391e40af59996d2489675a312503d53a1b8121f"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.12.0/al-darwin-amd64", using: :nounzip
      sha256 "3755ef77f94b2ae8e6ccc41f7d3d42fb4f8fcb5698857b278cd33194f70c653f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.12.0/al-linux-arm64", using: :nounzip
      sha256 "158a18fb4f1854f06a29fdeffc93b8d6817423fccac88378fd773c4fda4f6d8d"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.12.0/al-linux-amd64", using: :nounzip
      sha256 "e0711eaa5fe48121c11ae3bade1be70532ba2eba80523b5a51cfa3ac3a728675"
    end
  end

  def install
    bin.install Dir["al-*"].first => "al"
    generate_completions_from_executable(bin/"al", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/al --version")
  end
end
