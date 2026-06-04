class AgentLayer < Formula
  desc "Unified instructions, tools, and MCP servers for various coding agents"
  homepage "https://github.com/conn-castle/agent-layer"
  url "https://github.com/conn-castle/agent-layer/releases/download/v0.11.0/agent-layer-0.11.0.tar.gz"
  sha256 "b315d71e088f1eb1a1121c106951ef86f860589096957f52d8ebc13a3881b09f"
  license "MIT"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/agent-layer-0.10.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "15c373da76ca16e201a4fc72b48072a1528c6ee8e1abeb5d3c2c2478d385bb03"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "69cd7f96e14093e3f8493d7f8f3e92c23a7a9056046729d61fe9e19da8b908d4"
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
