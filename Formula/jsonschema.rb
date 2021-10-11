class Jsonschema < Formula
  include Language::Python::Virtualenv

  desc "Implementation of JSON Schema for Python"
  homepage "https://github.com/Julian/jsonschema"
  url "https://files.pythonhosted.org/packages/f2/f7/1cb7e8e3a6eb85ffc0d8c14a1022214a1699f110bf51e3d3d178280df04d/jsonschema-4.1.0.tar.gz"
  sha256 "9dd7c33b4a96138dc37bb86b3610d3b12d30d96433d4d73435ca3025804154a8"
  head "https://github.com/Julian/jsonschema.git"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/jsonschema-4.1.0"
    sha256 cellar: :any_skip_relocation, catalina:     "d4bd25eb96832b0d4c07e8fa1a341a24ee30398e6766afa29375127851383786"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cdb5ac9f7129125788d19bb2b797c4fc8da3a215b5aa71dfe2a73ec7a3f3880a"
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
