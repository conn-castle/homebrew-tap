class AgentLayer < Formula
  desc "Unified instructions, tools, and MCP servers for various coding agents"
  homepage "https://github.com/conn-castle/agent-layer"
  url "https://github.com/conn-castle/agent-layer/releases/download/v0.6.1/agent-layer-0.6.1.tar.gz"
  sha256 "30a970c0edda6df628e8c04aaa47ef9e2f54ec9677bef3081917f6f828a05c30"
  license "MIT"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/agent-layer-0.6.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "0bf4029ed867a3a90de71f16017376ee996a7dbf8a70f78ee170ef6835ff4698"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "baa7d47b43cd7cc47f373e13370ed360f1af4fa100dc33c4b9a09f66bda350d8"
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
