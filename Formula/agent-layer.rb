class AgentLayer < Formula
  desc "Unified instructions, tools, and MCP servers for various coding agents"
  homepage "https://github.com/conn-castle/agent-layer"
  url "https://github.com/conn-castle/agent-layer/releases/download/v0.8.1/agent-layer-0.8.1.tar.gz"
  sha256 "991190d79a7546a63638c680ec766c54ad09a74e0c63f59809360f1c8cdeab41"
  license "MIT"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/agent-layer-0.8.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "12dcf972c1a9417f1b7fbd48dca881bcdb665e6ae2d75910ba9b92060cee472b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cc6edbff5c0af2b1ecad09e8818ffd260681048fe4d33bb8229e70ec1bf101d8"
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
