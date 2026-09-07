class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.19.0/al-darwin-arm64", using: :nounzip
      sha256 "2491cfed1016bec0e9f0e334f9b44560c7f36c09ee50f06c7cfa00d239ecacb4"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.19.0/al-darwin-amd64", using: :nounzip
      sha256 "c16b0ab5af7826853fee2b8e139194ab7d7c5a2c5e63eb5faa5d7daacbfe6f95"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.19.0/al-linux-arm64", using: :nounzip
      sha256 "2004e954bfbe111f0a23f30a87e6e5407f9cdc9983d48adf92e291fa44147a7b"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.19.0/al-linux-amd64", using: :nounzip
      sha256 "36747386118b2165eebc205ab6fcfb80d3cbd83ea6bf3ef1816ba7a4fc9e8670"
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
