class AgentLayer < Formula
  desc "Unified instructions, tools, and MCP servers for various coding agents"
  homepage "https://github.com/conn-castle/agent-layer"
  url "https://github.com/conn-castle/agent-layer/releases/download/v0.5.6/agent-layer-0.5.6.tar.gz"
  sha256 "9f9c35ad524bc7337c6b9b983b07e55d85f240bbc4a12778d1e7b8892f22e2ae"
  license "MIT"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/agent-layer-0.5.5"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "7083362b7ca7eebb0997c87fa50dbb8f95922975d0a88cf384ad35b5da7b2c06"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3fcc8490a9b3873b7b8acbe4c913387d264aeb0af518be00ae9d41f1e3023c1c"
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
