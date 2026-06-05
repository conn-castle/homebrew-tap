class PersonalContext < Formula
  desc "Personal structured vault for searchable knowledge, data, files, and records"
  homepage "https://github.com/conn-castle/personal-context"
  url "https://github.com/conn-castle/personal-context/releases/download/v0.1.5/personal-context-0.1.5.tar.gz"
  sha256 "25480ad0f5aa79d0419517ee1b7e6f3a89066e09923721f45d043a692b539aeb"
  license "PolyForm-Noncommercial-1.0.0"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/personal-context-0.1.5"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "8040a7ef97f703aab1727fce5e7c5b23d63db46368852a75c4beb41e6d50c70f"
    sha256 cellar: :any,                 x86_64_linux: "9221a7da987746cb2a3e758d4df774becfa1a8e3bcacc749ff75843e1d7f6bff"
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
