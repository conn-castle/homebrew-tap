class AgentLayer < Formula
  desc "Unified instructions, tools, and MCP servers for various coding agents"
  homepage "https://github.com/conn-castle/agent-layer"
  url "https://github.com/conn-castle/agent-layer/releases/download/v0.8.5/agent-layer-0.8.5.tar.gz"
  sha256 "caaebc1d4fb788939f050b41b7d9b1d407040c9641f454d0c8bf519d6d6c9a04"
  license "MIT"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/agent-layer-0.8.5"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "0409a60f7a83e8606b1d8797148aa79518b90c9d758f82ef94c8a9b58d6a3dbc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5a2d98696e3996166923110bdf1f2b2dbc362e02191b912950bb5800676f672e"
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
