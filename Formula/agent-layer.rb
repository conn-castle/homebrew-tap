class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.1/al-darwin-arm64", using: :nounzip
      sha256 "68c244c4c44445f5abb48afb06b567f2bf820779e51daf102f5ce62b9f4d97d4"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.1/al-darwin-amd64", using: :nounzip
      sha256 "4ca04226038a08dd1d557a1187f58c0115c6a9eb81dd68f0b6ffe685e369ba4b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.1/al-linux-arm64", using: :nounzip
      sha256 "cb4ab3fa4eabdfde97580e8a8bc60d01657e7959fd0b861c70d5c169ce70f883"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.1/al-linux-amd64", using: :nounzip
      sha256 "d63243da72264e2729545be2aae418cb87785366c128fe58b4ff725508005d00"
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
