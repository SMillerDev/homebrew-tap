class N8nWorkflowLinter < Formula
  desc "Static lint for n8n workflow JSON"
  homepage "https://payloadhq.github.io/"
  url "https://github.com/Payloadhq/n8n-workflow-linter/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "c997e9d18e05abf7d0e70a91146075ad4ef32fae2169ee943d39d4f4ab542438"
  license "MIT"

  depends_on "python@3.15"

  deny_network_access!

  def install
    libexec.install "lint.py"
    chmod "+x", libexec/"lint.py"
    (bin/"n8n-workflow-linter").write_env_script libexec/"lint.py",
        PATH: "#{formula_opt_bin("python@3.15")}/python3.15:${PATH}"
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
