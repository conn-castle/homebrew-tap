class PersonalContext < Formula
  desc "Personal structured vault for searchable knowledge, data, files, and slides"
  homepage "https://github.com/conn-castle/personal-context"
  url "https://github.com/conn-castle/personal-context/releases/download/v0.1.1/personal-context-0.1.1.tar.gz"
  sha256 "170b8d7becf84655178938dcdda2774d65b96573c8abadb643af496e1e106f47"
  license "PolyForm-Noncommercial-1.0.0"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/personal-context-0.1.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "1c5fb1421b551241e6097411d7753565621a67fcae05a1decb373e61c4517af6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1d2e8521d677856c68e9780e6aa1f695c62843fceb5beed4e41a4b49b0d14ad5"
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
