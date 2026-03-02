class AgentLayer < Formula
  desc "Unified instructions, tools, and MCP servers for various coding agents"
  homepage "https://github.com/conn-castle/agent-layer"
  url "https://github.com/conn-castle/agent-layer/releases/download/v0.9.0/agent-layer-0.9.0.tar.gz"
  sha256 "35903d42b253d27c837c4a7ca48fefb63ff841f940d09580dc1829558026f268"
  license "MIT"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/agent-layer-0.8.8"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "18770714e4a871fb9f705ebdc57d1f2198ca5a140ba6ef27ab3b1de2b60a61da"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "34ad57d064de5c4ecca85710a2ff77de9385eb3bf450d64a00256aacbc71db32"
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
