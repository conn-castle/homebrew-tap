class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  version "0.14.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.14.0/al-darwin-arm64", using: :nounzip
      sha256 "483170177f3fdd48c3d66f3a3957411ade1b29bf47d1e4f9013b70f7dea76f34"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.14.0/al-darwin-amd64", using: :nounzip
      sha256 "0173248b589f4d25855ba11992dd890c515e21fdb339da779e56dacdda92ccd6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.14.0/al-linux-arm64", using: :nounzip
      sha256 "ae9efee5c0b58a33a96d0e049992ecd5e5b9a69aac3ae13b1cbcd3c522bc784f"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.14.0/al-linux-amd64", using: :nounzip
      sha256 "49f9880c441cb03db4a1e8adec4510d8586656a29c4781516397d37d8ac47cac"
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
