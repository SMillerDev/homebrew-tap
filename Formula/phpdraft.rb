class Phpdraft < Formula
  desc "Parser for API Blueprint files in PHP"
  homepage "https://github.com/SMillerDev/phpdraft"
  url "https://github.com/SMillerDev/phpdraft/releases/download/2.4.0-rc5/phpdraft-2.4.0-rc5.phar"
  sha256 "2763bc552687cdaf667b02db506a42a9db75355e97f129122dda13e6fdc1be86"
  head "https://github.com/SMillerDev/phpdraft.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/phpdraft-2.4.0-rc5"
    sha256 cellar: :any_skip_relocation, catalina:     "fc9e0274935b6496b67afc860bd6a8acce631488234fe196c5a1a08fd59cf469"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "03945f4eda0d39030d4be789d8bd66e9da83ff41d9dd1a320cb7ef1d7fb3b0da"
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
