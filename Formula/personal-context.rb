class PersonalContext < Formula
  desc "Personal structured vault for searchable knowledge, data, files, and records"
  homepage "https://github.com/conn-castle/personal-context"
  url "https://github.com/conn-castle/personal-context/releases/download/v0.1.4/personal-context-0.1.4.tar.gz"
  sha256 "f5a04621c896cc7d5760202ceb422de06b835dcaaeeeca5dd5318d1b0bb9f3d2"
  license "PolyForm-Noncommercial-1.0.0"

  bottle do
    root_url "https://github.com/conn-castle/homebrew-tap/releases/download/personal-context-0.1.4"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "571016e00146c94e84bea26c9ccced91a2362046102ba8f8a37cd456a5863026"
    sha256 cellar: :any,                 x86_64_linux: "0aeb335dbb106da38d91a46621fad0ca30f2189740fdb0e3b2d4671174cee88d"
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
