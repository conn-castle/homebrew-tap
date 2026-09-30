class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.23.1/al-darwin-arm64", using: :nounzip
      sha256 "b8a74242a4a8e2f4824a214b0cc3587683296a29cd0ae8726ec506375ec9d4a7"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.23.1/al-darwin-amd64", using: :nounzip
      sha256 "68519bfb7e183cf0d183f5c0ec008166f3c4aef120705d986e17819a7e61f51a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.23.1/al-linux-arm64", using: :nounzip
      sha256 "f0030e4108bc712dac5fe82c26d3ded76e116af31089826da8579922ba12dfda"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.23.1/al-linux-amd64", using: :nounzip
      sha256 "ed873d802df6a7e635838cb4d9ae62d3b15ec1461fed3b558deb19b4c8c6aeb1"
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
