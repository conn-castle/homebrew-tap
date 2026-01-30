class AgentLayer < Formula
  desc "Unified instructions, tools, and MCP servers for various coding agents"
  homepage "https://github.com/conn-castle/agent-layer"
  url "https://github.com/conn-castle/agent-layer/releases/download/v0.5.7/agent-layer-0.5.7.tar.gz"
  sha256 "d71cea0fe525351f857b705c9e4a9794a76f40739aaa35e737d7b974999f5f66"
  license "MIT"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/agent-layer-0.5.6"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "2e5a9717403b3af2d15186970812f2a466f4f94faf28fb1a1d76de17cf56df9a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d221f4d9a48e0abbf39c58522571478018e0488e3a90f0c586f6ede9276ff3e9"
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
