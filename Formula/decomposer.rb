class Decomposer < Formula
  desc "Library manager for PHP projects"
  homepage "https://github.com/move-backend/decomposer"
  url "https://github.com/move-backend/decomposer/archive/refs/tags/1.0.0.tar.gz"
  sha256 "b52f3b23645ca0872cacf80e564ecc987188a623136762d6fc161334c0c63ad8"
  head "https://github.com/move-backend/decomposer.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/decomposer-1.0.0"
    sha256 cellar: :any_skip_relocation, catalina:     "1504fd2a8baa5595b080953ddb821b53f9b144039bd7ff38604e61cf46ca70d3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f3ccc4198912dc0e5f6d956180456b6963fd01151300c97b29d5d2e4a771079f"
  end

  depends_on "scdoc" => :build
  depends_on "coreutils"
  depends_on "jq"

  def install
    system "make", "doc"
    system "make", "install", "DESTDIR=#{prefix}", "PREFIX=/"

    bash_completion.install "completions/completion-old.bash" => "decomposer.bash"
    fish_completion.install "completions/completion.fish" => "decomposer.fish"
  end

  test do
    (testpath/"decomposer.json").write <<~EOS
      {
        "Lunr": {
          "url": "https://github.com/M2mobi/lunr.git",
          "version": "0.7",
          "revision": "master",
          "psr4": {
            "prefix": "Lunr",
            "search-path": "/src/Lunr/"
          }
        }
      }
    EOS
    mkdir testpath/"libs"
    ENV["TARGET_DIR"] = testpath/"libs"
    assert_match "Installing Lunr...done\n", shell_output("#{bin}/decomposer install")
    assert File.directory? "#{testpath}/libs/Lunr-0.7"
  end
end
