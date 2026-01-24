class AgentLayer < Formula
  desc "Unified instructions, tools, and MCP servers for various coding agents"
  homepage "https://github.com/conn-castle/agent-layer"
  url "https://github.com/conn-castle/agent-layer/releases/download/v0.5.2/agent-layer-0.5.2.tar.gz"
  sha256 "ec83d493235359ddeb66a418445ff45095655135a861e749e19edf4bf23db4a7"
  license "MIT"

  depends_on "go" => :build

  def install
    # Build the CLI binary as `al` (the formula name is `agent-layer`).
    system "go", "build", *std_go_args(output: bin/"al", ldflags: "-s -w"), "./cmd/al"

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
