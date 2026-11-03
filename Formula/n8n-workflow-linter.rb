class N8nWorkflowLinter < Formula
  include Language::Python::Virtualenv

  desc "Static lint for n8n workflow JSON"
  homepage "https://payloadhq.github.io/"
  url "https://github.com/Payloadhq/n8n-workflow-linter/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "b73e65fecf2eaf4bde3c218ade9357d3f56d55200ab5ddb7bc150266ac485ff9"
  license "MIT"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/n8n-workflow-linter-1.1.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "04e73322524df5b84c4d6bacc50f35bed827bc0d40b4935a3f18ac5382369154"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "95f6ea034357a5cee2dc2ee0f36f0cdb6e13ee4dcb5b7aeb0250172804c2613b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "88755edea4647b73e37d1242c2a5158d534c2b6863310059be6d4488a433f7c4"
  end

  depends_on "homebrew/core/python@3.15"

  allow_network_access! :build

  def install
    virtualenv_install_with_resources
  end

  test do
    (testpath/"workflow.json").write <<~JSON
      {
        "name": "Test workflow",
        "nodes": [
          {
            "parameters": {},
            "type": "n8n-nodes-base.manualTrigger",
            "typeVersion": 1,
            "position": [
              0,
              48
            ],
            "id": "83e11395-a158-439b-9926-818257990a66",
            "name": "When clicking ‘Execute workflow’"
          }
        ]
      }
    JSON
    output = shell_output("#{bin}/n8n-workflow-linter #{testpath}/workflow.json", 2)
    assert_match "[N8N008] node 'When clicking ‘Execute workflow’': node has no connections", output
  end
end
