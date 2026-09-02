class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.5/al-darwin-arm64", using: :nounzip
      sha256 "b26324b74997b32b60969b8666bafe53b6d10a10c2d5437518429f0afaeb3eea"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.5/al-darwin-amd64", using: :nounzip
      sha256 "a83893eaa060c15f2effda85b7806400438eceb3e48bdf13716fc7db76d2550c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.5/al-linux-arm64", using: :nounzip
      sha256 "df270d8ed34659073f53d017012d08acda7d4045c5db5296e2c354a850ee9f7e"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.5/al-linux-amd64", using: :nounzip
      sha256 "c0600f509d921b547a27c85dd4b7e70eb790da4bb71ca1f78f3c1e2e82f5d158"
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
