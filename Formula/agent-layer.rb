class AgentLayer < Formula
  desc "Unified instructions, tools, and MCP servers for various coding agents"
  homepage "https://github.com/conn-castle/agent-layer"
  url "https://github.com/conn-castle/agent-layer/releases/download/v0.9.1/agent-layer-0.9.1.tar.gz"
  sha256 "83278b6ab72848293c71aae8a3ca2af653ae7172f55ee1c6535613176c34a33d"
  license "MIT"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/agent-layer-0.9.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "4b86b0039962697c4a8dff1b262fe124e138d291e1d527c4da2bc1340f726f10"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "49ddf9817bb0b07805d70329188b971a811474b17d01f015d201ffb4611addc5"
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
