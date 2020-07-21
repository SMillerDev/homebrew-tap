class Phpdraft < Formula
  desc "Parser for API Blueprint files in PHP"
  homepage "https://github.com/SMillerDev/phpdraft"
  url "https://github.com/SMillerDev/phpdraft/releases/download/2.3.0/phpdraft-2.3.0.phar"
  sha256 "9802a96b96a0cfaae86e6e370fc68a18b062341b094981baf967b3690af6d2bf"
  head "https://github.com/SMillerDev/phpdraft.git"

  bottle :unneeded

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
    assert_match "<title>Real World API<\/title>", shell_output("#{bin}/phpdraft --file index.apib")
  end
end
