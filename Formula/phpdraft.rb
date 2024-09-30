class Phpdraft < Formula
  desc "Parser for API Blueprint files in PHP"
  homepage "https://github.com/SMillerDev/phpdraft"
  url "https://github.com/SMillerDev/phpdraft/releases/download/2.6.0/phpdraft-2.6.0.phar"
  sha256 "ac6849af7faa3c5c7a0c0601f60bc999afe5407a74c47dfa9c56dd709432879e"
  head "https://github.com/SMillerDev/phpdraft.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/phpdraft-2.6.0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "c504ee714e6cb923cf9dbb158e195c92e3bf3cae22fa1c0d6fa2fb0e1d4663a2"
    sha256 cellar: :any_skip_relocation, ventura:      "5e09537c0acb9f5df8b934c0d81924a11b913d5122a3ccf4aad6e3b94f979b47"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4606c14af9847e6b190ca65739f48eca98153e5af418c927c7eb77325db639fd"
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
