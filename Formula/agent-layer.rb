class AgentLayer < Formula
  desc "Unified instructions, tools, and MCP servers for various coding agents"
  homepage "https://github.com/conn-castle/agent-layer"
  url "https://github.com/conn-castle/agent-layer/releases/download/v0.7.0/agent-layer-0.7.0.tar.gz"
  sha256 "3db4c4165de6810a08eb714b7c6063e0e58f941f5058c5910192b06c4d80a801"
  license "MIT"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/agent-layer-0.7.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "2ee3d74fce5d816dca549cca20d04daa0fa5a90a6eaa8253a2d9da1f461c7623"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "73fa38b3c7729d422fa1afe7be4ea6fe03b0a295dc2fce3848016eacb521f3cb"
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
