class Phpdraft < Formula
  desc "Parser for API Blueprint files in PHP"
  homepage "https://github.com/SMillerDev/phpdraft"
  url "https://github.com/SMillerDev/phpdraft/releases/download/2.2.1/phpdraft-2.2.1.phar"
  sha256 "4b3a1f313b9fceeb4d04eb2a44ce752c3915245677012844a0c3aa954035b70f"
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
