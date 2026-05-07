class PersonalContext < Formula
  desc "Personal structured vault for searchable knowledge, data, files, and slides"
  homepage "https://github.com/conn-castle/personal-context"
  url "https://github.com/conn-castle/personal-context/releases/download/v0.1.0/personal-context-0.1.0.tar.gz"
  sha256 "b6aceca47ac09eaa0399633678a5d61a09e00bc29866387cb5bc86911b16b487"
  license "PolyForm-Noncommercial-1.0.0"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/personal-context-0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "2243d8808c68c914837047d6a9a2e37d28fc6fe76041ffba8234c895d9b91904"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dd9a112cc50b65702b9cd63e8e9005dff4579e5fd0d8842b7ee9dafad54318f0"
  end

  depends_on "go" => :build

  def install
    cd "cli" do
      ldflags = %W[
        -s -w
        -X main.version=v#{version}
      ].join(" ")

      system "go", "build", *std_go_args(output: bin/"pc", ldflags: ldflags), "./cmd/pc"
    end

    generate_completions_from_executable(
      bin/"pc",
      shell_parameter_format: :cobra,
      shells:                 [:bash, :zsh, :fish],
    )
  end

  test do
    assert_match "Personal Context CLI", shell_output("#{bin}/pc --help")
    assert_match "bash completion", shell_output("#{bin}/pc completion bash")
  end
end
