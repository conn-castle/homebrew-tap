class AgentLayer < Formula
  desc "Unified instructions, tools, and MCP servers for various coding agents"
  homepage "https://github.com/conn-castle/agent-layer"
  url "https://github.com/conn-castle/agent-layer/releases/download/v0.11.0/agent-layer-0.11.0.tar.gz"
  sha256 "b315d71e088f1eb1a1121c106951ef86f860589096957f52d8ebc13a3881b09f"
  license "MIT"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/agent-layer-0.11.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "f5fbb9b510fe6ef4c92d7b68107895bb041355d387269c251ad04646a8ddf5d5"
    sha256 cellar: :any,                 x86_64_linux: "5db2d17f47018bf2c4802e458e4fd1177a1c9c20941edefcff0706b9cd0c9d07"
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
