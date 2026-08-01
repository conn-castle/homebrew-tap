class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  version "0.15.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.15.0/al-darwin-arm64", using: :nounzip
      sha256 "4f7caa72148b5f96c14ae7e6e8cfdbd3b93bbb07b9dc73e6f8a30b29b07e8e6e"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.15.0/al-darwin-amd64", using: :nounzip
      sha256 "94963650fa938837669e2adfc1efbc9848e91c6f46fc5a849982b5f3987a54f8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.15.0/al-linux-arm64", using: :nounzip
      sha256 "719776f0faa0e52668064349b0c0b454c3050a233bd301918b92256eb6490e43"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.15.0/al-linux-amd64", using: :nounzip
      sha256 "5d80312168f13514e4de3269b5b08545364f28a27b13a066d5758aedef1921f7"
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
