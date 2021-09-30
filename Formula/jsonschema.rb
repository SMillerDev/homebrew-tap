class Jsonschema < Formula
  include Language::Python::Virtualenv

  desc "Implementation of JSON Schema for Python"
  homepage "https://github.com/Julian/jsonschema"
  url "https://files.pythonhosted.org/packages/9c/99/9789c7fd0bb8876a7d624d903195ce11e5618b421bdb1bf7c975d17a9bc3/jsonschema-4.0.0.tar.gz"
  sha256 "bc51325b929171791c42ebc1c70b9713eb134d3bb8ebd5474c8b659b15be6d86"
  head "https://github.com/Julian/jsonschema.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/jsonschema-4.0.0"
    sha256 cellar: :any_skip_relocation, catalina:     "fbb6823adb31c2b0e7b638af7f05ad83059524dcafd4f1df3c70d2f1cc18eefd"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c6f58cda24da5ac4313b7da1b5da1a858dfc3b802b1d2efd3531969b5fc1920b"
  end

  depends_on "python@3.9"
  depends_on "six"

  resource "attrs" do
    url "https://files.pythonhosted.org/packages/ed/d6/3ebca4ca65157c12bd08a63e20ac0bdc21ac7f3694040711f9fd073c0ffb/attrs-21.2.0.tar.gz"
    sha256 "ef6aaac3ca6cd92904cdd0d83f629a15f18053ec84e6432106f7a4d04ae4f5fb"
  end

  resource "pyrsistent" do
    url "https://files.pythonhosted.org/packages/f4/d7/0fa558c4fb00f15aabc6d42d365fcca7a15fcc1091cd0f5784a14f390b7f/pyrsistent-0.18.0.tar.gz"
    sha256 "773c781216f8c2900b42a7b638d5b517bb134ae1acbebe4d1e8f1f41ea60eb4b"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    (testpath/"test.json").write <<~EOS
      {
      	"name" : "Eggs",
      	"price" : 34.99
      }
    EOS

    (testpath/"test.schema").write <<~EOS
      {
        "type": "object",
        "properties": {
            "price": {"type": "number"},
            "name": {"type": "string"}
        }
      }
    EOS

    out = shell_output("#{bin}/jsonschema --output pretty --instance #{testpath}/test.json #{testpath}/test.schema")
    assert_match "SUCCESS", out
  end
end
