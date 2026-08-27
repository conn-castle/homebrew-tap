class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.6/al-darwin-arm64", using: :nounzip
      sha256 "452284485ca5aae9e3d082e5e659b7044ab924eb5da3066f849ac82a05f73916"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.6/al-darwin-amd64", using: :nounzip
      sha256 "bfa08020bc0dde2cf4ac655a4ffc89c75767b7a344eaa23b674824965f896813"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.6/al-linux-arm64", using: :nounzip
      sha256 "95a115121f584583d7d1e40f982887a3f349fd5a3f445b8595037a20d8979687"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.17.6/al-linux-amd64", using: :nounzip
      sha256 "e15012a4bba09280621ac275628ef210919480e2e973e0457ebd6482426d755c"
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
