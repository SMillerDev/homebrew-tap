class Phpdraft < Formula
  desc "Parser for API Blueprint files in PHP"
  homepage "https://github.com/SMillerDev/phpdraft"
  url "https://github.com/SMillerDev/phpdraft/releases/download/2.4.1/phpdraft-2.4.1.phar"
  sha256 "2e29cf3e9b8a6da983deabe9afa854aaccf19989fdb2ddeeb0e441752cb72fb1"
  head "https://github.com/SMillerDev/phpdraft.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/phpdraft-2.4.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "54328be36113c4a812708baca58c068689ca895de9a1e4e7d317939a6e658bc8"
    sha256 cellar: :any_skip_relocation, catalina:     "147d2f94c3f058485f49e9ef24fb191f2e6843cd16fd115a2c02db75fd1825ac"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b787ed6da44f5c032671e9d20ed91a6064cdec71d99a3c5cd2fa360d4f18ad13"
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
    assert_match "<title>Real World API<\/title>", shell_output("#{bin}/phpdraft --file index.apib")
  end
end
