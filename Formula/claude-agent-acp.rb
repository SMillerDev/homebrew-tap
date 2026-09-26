class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.81.2.tgz"
  sha256 "15368e30e06789df93c057d910247e15a3b38f59bddd039c2e44a0e946341b0c"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.81.1"
    sha256                               arm64_tahoe:  "315c00fdbec97c2a68ac898eb80cedb9d4c50b3f61ffccab734d307b19c2773d"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "33f9b447ad386aa4801f3885380242de9a0824fb54c0fbe1565aa4f996c46ed8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5aa6c75b817326f65230aa96f876aed6a6aee4bd4af6e52dac9f9823af552c83"
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
