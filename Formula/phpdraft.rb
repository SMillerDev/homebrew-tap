class Phpdraft < Formula
  desc "Parser for API Blueprint files in PHP"
  homepage "https://github.com/SMillerDev/phpdraft"
  url "https://github.com/SMillerDev/phpdraft/releases/download/2.1/phpdraft-2.1.phar"
  sha256 "9a46dc16b0a6c970e13bd80c24671c9125ff33ff63da8e2b5af3f58ac7345600"
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
    assert_match /<title>Real World API<\/title>/, shell_output("#{bin}/phpdraft --file index.apib")
  end
end
