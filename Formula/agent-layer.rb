class AgentLayer < Formula
  desc "Unified instructions, tools, and MCP servers for various coding agents"
  homepage "https://github.com/conn-castle/agent-layer"
  url "https://github.com/conn-castle/agent-layer/releases/download/v0.5.8/agent-layer-0.5.8.tar.gz"
  sha256 "a1b31d7e6657e68bcd496e72b82c447abbf29db1afc858928e6722bd44ee7546"
  license "MIT"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/agent-layer-0.5.8"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "012b4b0ddf3f75afce0a176bbece2fa74a14970b0771a9786c2aa6baf2f1ddd3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c9013aec246005ef87117dcb175d038fd42e408811a06b07eab496721f871819"
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
