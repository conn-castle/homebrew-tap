class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.21.0/al-darwin-arm64", using: :nounzip
      sha256 "76e7666b0d17e5c5e2a6a6b037c87edeb512884868180cc2bfe18d4c9097c446"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.21.0/al-darwin-amd64", using: :nounzip
      sha256 "a968cceaa0000922d938517fbc23c6e5847357f9858d118630cc14a354030158"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.21.0/al-linux-arm64", using: :nounzip
      sha256 "78dd3e0925126501609dd30ef0d42acdb7ee0abc010fb8a30e6a42039f5b16f9"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.21.0/al-linux-amd64", using: :nounzip
      sha256 "6ef63094b292b1d2eec69d2b0f93b556b0ba3108b32e998abd4327fa5add0a6b"
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
