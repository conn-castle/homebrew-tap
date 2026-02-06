class AgentLayer < Formula
  desc "Unified instructions, tools, and MCP servers for various coding agents"
  homepage "https://github.com/conn-castle/agent-layer"
  url "https://github.com/conn-castle/agent-layer/releases/download/v0.6.1/agent-layer-0.6.1.tar.gz"
  sha256 "30a970c0edda6df628e8c04aaa47ef9e2f54ec9677bef3081917f6f828a05c30"
  license "MIT"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/agent-layer-0.6.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "3ff5aa57b0b5c4cb56f62a8b8f1432ed6338a9188d5efda39668ca160ed96773"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "60ccf0078df107979e1bfc5543c07b48d5a45636e47ed7cd0d2e7f1b5a9cd4e9"
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
