class AgentLayer < Formula
  desc "Unified instructions, tools, and MCP servers for various coding agents"
  homepage "https://github.com/conn-castle/agent-layer"
  url "https://github.com/conn-castle/agent-layer/releases/download/v0.9.2/agent-layer-0.9.2.tar.gz"
  sha256 "656d366de25456a643def0d58b984dc5de816fbc09892caa8352f975f6a3dc5a"
  license "MIT"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/agent-layer-0.9.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "b736901f5fc95e1ca8ba72fa5347c479a527eba1363e8534f34f01c6b9680ba6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1782cc27afac6bd5b131507554d96cb08999173bfe22af4852029f23c7f4184d"
  end

  depends_on "go" => :build

  on_macos do
    depends_on arch: :arm64
  end

  def install
    # Build the CLI binary as `al` (the formula name is `agent-layer`).
    ldflags = %W[
      -s -w
      -X main.Version=v#{version}
    ].join(" ")

    system "go", "build", *std_go_args(output: bin/"al", ldflags: ldflags), "./cmd/al"

    # Install shell completions automatically (uses `al completion <shell>`).
    generate_completions_from_executable(
      bin/"al",
      shell_parameter_format: :cobra,
      shells:                 [:bash, :zsh, :fish],
    )
  end

  test do
    assert_match "Agent Layer", shell_output("#{bin}/al --help")
    assert_match "bash completion", shell_output("#{bin}/al completion bash")
  end
end
