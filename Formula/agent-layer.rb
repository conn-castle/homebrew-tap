class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.0/al-darwin-arm64", using: :nounzip
      sha256 "5cb4ecabb8e39af720d8287d70a2b5a66a06750baba6fe0f1d702df988873e38"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.0/al-darwin-amd64", using: :nounzip
      sha256 "3f4c78d8eb47977d931541863647a5d2a08d65782b90fc92cd13dc78e231b513"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.0/al-linux-arm64", using: :nounzip
      sha256 "17189a13e51e84d661b348962d73bb2d900d6afebd959844af92b64b4bb6632e"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.0/al-linux-amd64", using: :nounzip
      sha256 "fbb08899d9f62dbea38728a42a5937b0540187612fa541640772cffe374e8bc9"
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
