class Phpdraft < Formula
  desc "Parser for API Blueprint files in PHP"
  homepage "https://github.com/SMillerDev/phpdraft"
  url "https://github.com/SMillerDev/phpdraft/releases/download/2.6.1/phpdraft-2.6.1.phar"
  sha256 "3cdce47bb45c8cabee5f4a35b3bc47ea93abc81549e3e54b5c327cf3b631c5be"
  head "https://github.com/SMillerDev/phpdraft.git", branch: "main"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/phpdraft-2.6.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "8037762ec27694dddff90fbd1e0b8808fc1a74d297ee5398d14b3c193a9b909c"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "ab5f430024f5343c0b940f867ceb90245219cb3f50d6b4a3a4bad0aca2c705a0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9bd4a9fa3162293d6cb15cab29efddb43ff48db31fe5ec97e57aae107c6d4464"
  end

  deprecate! date: "2026-07-01", because: :repo_archived

  depends_on "php" => :test
  depends_on "drafter"

  def install
    bin.install "phpdraft-#{version}.phar" => "phpdraft"
  end

  test do
    (testpath/"index.apib").write <<~EOS
      FORMAT: 1A
      HOST: https://alpha-api.app.net
      EXTRA_HOST: https://test.alpha-api.app.net

      # Real World API
      This API Blueprint demonstrates a real world example documenting a portion of
      [App.net API](http://developers.app.net).

    EOS
    assert_match "<title>Real World API</title>", shell_output("#{bin}/phpdraft --file index.apib")
  end
end
