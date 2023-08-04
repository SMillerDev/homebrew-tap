class Phpdraft < Formula
  desc "Parser for API Blueprint files in PHP"
  homepage "https://github.com/SMillerDev/phpdraft"
  url "https://github.com/SMillerDev/phpdraft/releases/download/2.5.1/phpdraft-2.5.1.phar"
  sha256 "ba29515c99350e253c56bfaae4b3be262f034196ba98bb662740b733f68601f3"
  head "https://github.com/SMillerDev/phpdraft.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/phpdraft-2.4.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "4a63d504faaacf7ee03da0c0a15f478ec0752a6557deceeadf6ec1646b86c990"
    sha256 cellar: :any_skip_relocation, catalina:     "ba996d7aa8e9b40386000cf8e9c3b2c9c6014521f6e03759eac7dc097d0c83c1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0c48f8020f1141922c49847ab1540ce5fa2b30a19c9d357cc5d8857fac95da46"
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
