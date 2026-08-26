class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.3/al-darwin-arm64", using: :nounzip
      sha256 "59dfcf9c6b9698b08e64ef3300de1700903e9ce88c2bf56d4f2b7ef67b990770"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.3/al-darwin-amd64", using: :nounzip
      sha256 "f691874137d31d39f5fd8405faabd4e2ff12a5f158f615f4cb7ca20add4dd630"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.3/al-linux-arm64", using: :nounzip
      sha256 "b9defb36da0d7f089df0fc83b08e1029369f579fe9178e105354a78ca6207e2e"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.3/al-linux-amd64", using: :nounzip
      sha256 "20534b9388c29036162b19c03c7dcd0c3b25311f21a34852c4f16891ee9b90c5"
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
