class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.1/al-darwin-arm64", using: :nounzip
      sha256 "87e25ac585e346b58d2489054ad57995b5d3237edb7d3ff1e52c3159774c5ab5"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.1/al-darwin-amd64", using: :nounzip
      sha256 "25104df383fdc77b13373f2769519440b7da1fead97eb3317ca6bbca50a67c31"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.1/al-linux-arm64", using: :nounzip
      sha256 "3c841384599917276ec2e93e038893479cbe5dfee149a2a018168d60a3477698"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.1/al-linux-amd64", using: :nounzip
      sha256 "6909e4f94675de747dad20fee21634f1649ae49f07fd89d4f250871f0d5935bb"
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
