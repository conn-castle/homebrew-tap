class AgentLayer < Formula
  desc "Unified instructions, tools, and MCP servers for various coding agents"
  homepage "https://github.com/conn-castle/agent-layer"
  url "https://github.com/conn-castle/agent-layer/releases/download/v0.8.2/agent-layer-0.8.2.tar.gz"
  sha256 "998139061d80746a5bd420bb0b6c38b725474f00e6d37b27c949498109810356"
  license "MIT"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/agent-layer-0.8.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "9cb5593d7dff98fd407c934871bff66cf1cac7ae2112f331e99e263b1e028417"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d1904cfdf4a9a11d957e390a3dc9f484964ceab64bc2fba24c43dce3759b1e2c"
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
