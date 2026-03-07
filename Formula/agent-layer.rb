class AgentLayer < Formula
  desc "Unified instructions, tools, and MCP servers for various coding agents"
  homepage "https://github.com/conn-castle/agent-layer"
  url "https://github.com/conn-castle/agent-layer/releases/download/v0.9.1/agent-layer-0.9.1.tar.gz"
  sha256 "83278b6ab72848293c71aae8a3ca2af653ae7172f55ee1c6535613176c34a33d"
  license "MIT"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/agent-layer-0.9.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "0e8477d7ead46c38cf19fae28de675487e92e98a0a4d30342eb11c4e4cc241a7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fbc188d1fd9d2799da87f04ea486ba699f955ce2ef4917e6ae3b27b183f31650"
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
