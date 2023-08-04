class Phpdraft < Formula
  desc "Parser for API Blueprint files in PHP"
  homepage "https://github.com/SMillerDev/phpdraft"
  url "https://github.com/SMillerDev/phpdraft/releases/download/2.5.2/phpdraft-2.5.2.phar"
  sha256 "0ca79a6986235e9c78398f31b04d34e208e26da91ff2f5dc38c4faf70774e3c3"
  head "https://github.com/SMillerDev/phpdraft.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/phpdraft-2.5.2"
    sha256 cellar: :any_skip_relocation, ventura:      "c382213c39f3bcccdd88225675a13b5b0b23a6531a3164a91322735d3b002080"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d3e252c733003853c7929c2b67299b8967526f5053337caefccbb03294bd1da2"
  end

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
