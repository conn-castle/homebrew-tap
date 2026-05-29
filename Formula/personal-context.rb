class PersonalContext < Formula
  desc "Personal structured vault for searchable knowledge, data, files, and records"
  homepage "https://github.com/conn-castle/personal-context"
  url "https://github.com/conn-castle/personal-context/releases/download/v0.1.3/personal-context-0.1.3.tar.gz"
  sha256 "c73e44cab8f38231985d2fd7a32b95c7dd7edb1f6bf67a53dd59264e51bad9b5"
  license "PolyForm-Noncommercial-1.0.0"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/personal-context-0.1.3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "f4c1baed0c53376d47eba8a800e43838972c080ac4761ce008cd8055d128c97a"
    sha256 cellar: :any,                 x86_64_linux: "e1128411b7ced576accb108f3ac49cd3b292a8f8841493be4bbed06f6ec41868"
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
