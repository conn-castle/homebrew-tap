class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.2.1/al-darwin-arm64", using: :nounzip
      sha256 "7ed826fafed0c91a67bf9a1ae746615ddf9da8c3b262259cb10ef5ea08b074ee"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.2.1/al-darwin-amd64", using: :nounzip
      sha256 "48e10aebf71ce6f0d2ec54e8bc6108d2a08f1f231c0ea06c4749bf30336fd91d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.2.1/al-linux-arm64", using: :nounzip
      sha256 "9e95f979bc3ef0fd931a019394fe591215689f961ae96e79e20a164d1346eed3"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.2.1/al-linux-amd64", using: :nounzip
      sha256 "d21773a3bc80fdb249be6d381cf182a2e393d047315575c42322991b111d3210"
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
