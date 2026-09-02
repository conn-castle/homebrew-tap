class AgentLayer < Formula
  desc "Config-first CLI for keeping coding agents in sync"
  homepage "https://github.com/conn-castle/agent-layer"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.4/al-darwin-arm64", using: :nounzip
      sha256 "4fdd78edcb52d785830e5187027456976f4e932d4add2608260b9d6e5c384c93"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.4/al-darwin-amd64", using: :nounzip
      sha256 "4ca4e643da1ea40044963d0a2a4d401e5666b8b5a9f662479e1546289c32a2e1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.4/al-linux-arm64", using: :nounzip
      sha256 "3172da190944fd9d83d04b82970b54594bcdd92deabec4038cc6e3cf31eb87b2"
    end

    on_intel do
      url "https://github.com/conn-castle/agent-layer/releases/download/v0.18.4/al-linux-amd64", using: :nounzip
      sha256 "f7b13d2efd2f8aeb279e6ae8b47cffe88b95386664d5a35a3e56219bcc53ecee"
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
