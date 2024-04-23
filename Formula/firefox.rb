class Firefox < Formula
  desc ""
  homepage ""
  url "https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py"
  version "1.2"
  sha256 "348d4dd6222fa5a5a796f4edc51228905a7f0a67f5301eb054e2f24640f76e82"
  license ""

  depends_on "mercurial"
  depends_on "git-cinnabar"

  uses_from_macos "python"

  def install
    # Remove unrecognized options if they cause configure to fail
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    # system "./configure", "--disable-silent-rules", *std_configure_args
    # system "make", "install" # if this fails, try separate make/make install steps
    system "python3", "bootstrap.py", "--vcs=git"
    system "hg", "up", "-C", "central"
    system "./mach", "build"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test firefox`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
