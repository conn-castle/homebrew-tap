class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.2.0/al-darwin-arm64", using: :nounzip
      sha256 "d8cde6ab4397b011628aa3c68fae35f78149c33925d68a00c6b6f61cd0e807fa"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.2.0/al-darwin-amd64", using: :nounzip
      sha256 "f36add6016d5b601fbb2dc216c095bba0ced08a2d9102a36a2356c50843675a0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.2.0/al-linux-arm64", using: :nounzip
      sha256 "39612ca835e6881f16f25826d945fbfbca9ef7283be13fb9afa39c6a94fe0729"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.2.0/al-linux-amd64", using: :nounzip
      sha256 "b3e839895ac32f3b7a84cbbfbaab4d63fe0b659c4b9231b872798236c161a01b"
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
