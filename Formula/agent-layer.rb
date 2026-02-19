class AgentLayer < Formula
  desc "Unified instructions, tools, and MCP servers for various coding agents"
  homepage "https://github.com/conn-castle/agent-layer"
  url "https://github.com/conn-castle/agent-layer/releases/download/v0.8.3/agent-layer-0.8.3.tar.gz"
  sha256 "c6998ce9748da7bc9a104b9b14468a47a4feba9b13de272201070a2bd872e56a"
  license "MIT"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/agent-layer-0.8.3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "be95d4e854b78b27f1d766617b6b1acdafb037ce7258500f321cb59e65ab9da9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6959e8b927dd6200784ff77c9d39b7cb9b9113334da5e27f696b9301e0fa7e1c"
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
