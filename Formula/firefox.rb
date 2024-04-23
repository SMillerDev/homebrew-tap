class Firefox < Formula
  desc "you know"
  homepage "https://mozilla.org"
  url "https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py"
  version "1.2"
  sha256 "348d4dd6222fa5a5a796f4edc51228905a7f0a67f5301eb054e2f24640f76e82"
  license ""

  depends_on "mercurial"
  depends_on "git-cinnabar"

  uses_from_macos "python"

  def install
    system "python3", "bootstrap.py", "--vcs=git"
    system "hg", "up", "-C", "central"
    system "./mach", "build"
  end

  test do
    system "false"
  end
end
