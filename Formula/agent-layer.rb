class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.16.3/al-darwin-arm64", using: :nounzip
      sha256 "f313733b7cc8ff30be7d5ede79be01770a9bc4fab7b762cab90a1158644d7638"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.16.3/al-darwin-amd64", using: :nounzip
      sha256 "b41650524dd78a61c3fa92650f0bc1762692fd07d30e64a1a80abdea5cd11cc0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.16.3/al-linux-arm64", using: :nounzip
      sha256 "69231adf4db4266481efd7246ea436f97fb12893cad299846206a8050d349798"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.16.3/al-linux-amd64", using: :nounzip
      sha256 "f44c2cd97aa327f37b867db1f583b1b81bf7e4a74c42710efcfb016a0975fd82"
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
