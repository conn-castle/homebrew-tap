class AgentLayer < Formula
  desc "Unified instructions, tools, and MCP servers for various coding agents"
  homepage "https://github.com/conn-castle/agent-layer"
  url "https://github.com/conn-castle/agent-layer/releases/download/v0.8.4/agent-layer-0.8.4.tar.gz"
  sha256 "6e53b8c20472a8051d582ecbff2f88d1c3b00205a9ede4fb088d93323441f1ef"
  license "MIT"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/agent-layer-0.8.4"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "a3129bfda605695fc9875e1b1a346cc2a54548fe4464cbc705d3a3b003a64d89"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9e60645bf1cbac79a024d37d5f63dfa98d0e92d3f16cf37ebe76cff1e7ae32f1"
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
