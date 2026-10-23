class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.1.0/al-darwin-arm64", using: :nounzip
      sha256 "d03197c28dbfdb99e1b04b3da955c858e1b961bfc94126fa5b583972fcf3c6ef"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.1.0/al-darwin-amd64", using: :nounzip
      sha256 "699107ffdcd9398a48172325983aae7065d0dbc00b37feba624114e0ebeb7e9d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.1.0/al-linux-arm64", using: :nounzip
      sha256 "7cb6cd9a16f4806c125e05fa118530bc851bddd4c6dba50253fc8f6ed173f5a2"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v1.1.0/al-linux-amd64", using: :nounzip
      sha256 "652ce13d93931c3e05822e32d826ac9e0e55186ca3eb863a93e68f4c1526c177"
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
