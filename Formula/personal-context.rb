class PersonalContext < Formula
  desc "Personal structured vault for searchable knowledge, data, files, and records"
  homepage "https://github.com/conn-castle/personal-context"
  url "https://github.com/conn-castle/personal-context/releases/download/v0.1.3/personal-context-0.1.3.tar.gz"
  sha256 "c73e44cab8f38231985d2fd7a32b95c7dd7edb1f6bf67a53dd59264e51bad9b5"
  license "PolyForm-Noncommercial-1.0.0"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/personal-context-0.1.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "eb1557c12a268f0ae0e3e481aa040d9d2a67daa34129fe27604593da0eb3d032"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1c5c68061c2401200a4420eafe2d62aa792d0597ce1652970e7428b1549d31db"
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
