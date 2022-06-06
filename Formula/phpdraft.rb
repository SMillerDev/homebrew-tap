class Phpdraft < Formula
  desc "Parser for API Blueprint files in PHP"
  homepage "https://github.com/SMillerDev/phpdraft"
  url "https://github.com/SMillerDev/phpdraft/releases/download/2.4.1/phpdraft-2.4.1.phar"
  sha256 "2e29cf3e9b8a6da983deabe9afa854aaccf19989fdb2ddeeb0e441752cb72fb1"
  head "https://github.com/SMillerDev/phpdraft.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/phpdraft-2.4.0.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "db4e86659d8e1d6ee6051673109c0bf91b5d64162619624bf0f976ae6891c42a"
    sha256 cellar: :any_skip_relocation, catalina:     "6a155d32c87f3b9d23cf9f077fbd3fcebc99ee68e79ac8f33b6b4aa28dec1fcf"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "07b69a368137b1a3b50ef799408bca553f7b4724321fc07bb82abee35f2c78b0"
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
