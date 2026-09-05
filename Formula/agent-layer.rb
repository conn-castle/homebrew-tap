class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.6/al-darwin-arm64", using: :nounzip
      sha256 "835a338e7463e11ab2c54cdace07163177aa906cfdeac0d0d99b32f5e33f4851"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.6/al-darwin-amd64", using: :nounzip
      sha256 "6240d8853b0ad5749ebe143a96cccba21ae91a4b4440003444325bd0a5fcb61e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.6/al-linux-arm64", using: :nounzip
      sha256 "9580c2926a02edd21c1c97264afc2d55748aaf8459e24877f263e2aa6e7a8682"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.6/al-linux-amd64", using: :nounzip
      sha256 "4dfda50024c7911443c409233ed355413529a62055ee48d279d4a52a48d3c404"
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
