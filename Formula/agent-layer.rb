class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.3/al-darwin-arm64", using: :nounzip
      sha256 "9b97c9de83ef2758ff90508649dfad9853332269d593efcb91cadf5964a8bd8d"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.3/al-darwin-amd64", using: :nounzip
      sha256 "392efac57b1fd2095419789f3dda6ef39486f250f7861fdabe5718a548ab04fe"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.3/al-linux-arm64", using: :nounzip
      sha256 "76687ae308dcb9ebffb4590878e8826769115b0b85e5e6c7b3d49676aae64ed2"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.3/al-linux-amd64", using: :nounzip
      sha256 "1ee8a45601ece780e47445471d6bd277b4aa3559e189f609820e912c63c6a213"
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
