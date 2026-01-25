class AgentLayer < Formula
  desc "Unified instructions, tools, and MCP servers for various coding agents"
  homepage "https://github.com/conn-castle/agent-layer"
  url "https://github.com/conn-castle/agent-layer/releases/download/v0.5.5/agent-layer-0.5.5.tar.gz"
  sha256 "f150c9f2254c33602d676c03c727cc6c759e1291eacb75bbfa349e5f2526f72e"
  license "MIT"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/agent-layer-0.5.4"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "49284fb71a9e6dec1e5520b910bf2585d4ab0a736261ec622fbc03ab715ed649"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "85b4f53fb3d4b89712cc80ca74d9d001f4f12d86ad761a98faa687c0e8b966f4"
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
