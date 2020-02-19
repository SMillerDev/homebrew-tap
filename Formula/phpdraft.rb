class Phpdraft < Formula
  desc "Parser for API Blueprint files in PHP"
  homepage "https://github.com/SMillerDev/phpdraft"
  url "https://github.com/SMillerDev/phpdraft/releases/download/1.15.10/phpdraft-1.15.10.phar"
  sha256 "1535dba4cce8645af191bbc120dfc78e0742a1227dc9344b04aca42e3a4ac5ec"

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
