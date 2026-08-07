class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.16.1/al-darwin-arm64", using: :nounzip
      sha256 "3779d5e96c5e26a1dce2e75aed11a82a3b54015dc11113e87abac7ccc9f285ea"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.16.1/al-darwin-amd64", using: :nounzip
      sha256 "3833341c84f8bc7872ebb0ad6bfbfdc9cab270e5656f4c3f529f53265ed5b236"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.16.1/al-linux-arm64", using: :nounzip
      sha256 "8c64022ecf56cbfe9174b962d629a1eda007bdb97de7b48440104cc66021a0e0"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.16.1/al-linux-amd64", using: :nounzip
      sha256 "f9cfa967a0ef7c476b2b63e9f3d8ea0a18adb57b2d674cde4273f15272657600"
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
