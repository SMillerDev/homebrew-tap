class Firefox < Formula
  desc "You know"
  homepage "https://mozilla.org"
  url "https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py"
  version "1.2"
  sha256 "348d4dd6222fa5a5a796f4edc51228905a7f0a67f5301eb054e2f24640f76e82"
  license "MIT"

  depends_on "git" => :build
  depends_on "git-cinnabar" => :build
  depends_on "mercurial" => :build
  depends_on "python@3.11" => :build
  uses_from_macos "curl" => :build

  def install
    system "python3", "bootstrap.py", "--no-interactive"
    system "hg", "up", "-C", "central"
    system "./mach", "build"
  end

  test do
    system "false"
  end
end
