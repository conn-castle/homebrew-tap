class AgentLayer < Formula
  desc "Unified instructions, tools, and MCP servers for various coding agents"
  homepage "https://github.com/conn-castle/agent-layer"
  url "https://github.com/conn-castle/agent-layer/releases/download/v0.5.8/agent-layer-0.5.8.tar.gz"
  sha256 "a1b31d7e6657e68bcd496e72b82c447abbf29db1afc858928e6722bd44ee7546"
  license "MIT"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/agent-layer-0.5.7"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "41ac2ef1f1b3656ec7c0625476a6c24daa7d74dc41e8e5510ce153b55c914f85"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "68ef4b390a0fc75d6931d6c8234fa379904e8abef79160dbb65bfae41234e644"
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
