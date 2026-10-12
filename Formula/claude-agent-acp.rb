class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.88.0.tgz"
  sha256 "5655e1ed94efbc2f05ee0d34a26d98697245946250b334f7e009debe14e5fba6"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.88.0"
    sha256                               arm64_tahoe:  "df0d9138e90bfccdb73db4a8eab150a73209027e7a4254d884dc7cd4d7be3ff1"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "dc34c8d04415c38e02655a247aff0a9eaaa5d481678d4fc3a62d41f65bb5ba7a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "41843ae93a39d25fd96654621fc0587db939a5fb14d1783b58e9f4a982767ec0"
  end

  depends_on "homebrew/core/node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    output = pipe_output("#{bin}/claude-agent-acp 2>&1", "{}")
    assert_match "Invalid request", output
  end
end
