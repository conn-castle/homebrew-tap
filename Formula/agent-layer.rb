class AgentLayer < Formula
  desc "Unified instructions, tools, and MCP servers for various coding agents"
  homepage "https://github.com/conn-castle/agent-layer"
  url "https://github.com/conn-castle/agent-layer/releases/download/v0.8.7/agent-layer-0.8.7.tar.gz"
  sha256 "aff88f229d07881c599f04d7d5f4547efb2c4bec2c7bd3dc47660bd7043a6cf1"
  license "MIT"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/agent-layer-0.8.7"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "56895fafdd328f478e8601aaff4e80394797748a16d5e079a17ac4a7f83a8cd0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "33d92285501a32d0884dbce446bdefe0a282244a959447ee689a71d15764b6d9"
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
