class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.65.0.tgz"
  sha256 "92ed8b82a982288cd63648e8dd3e1edba8790ee459a2736092d17fbdb53db7df"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.64.2"
    sha256                               arm64_tahoe:  "8588b86467e92867f463b521a86f50cb577147a94ffad328fd0304d8a75c4f05"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "ea023d83ac628ffd320c12c99d9fa7b200595ea7c26f8b4e835c6d0f654b7edf"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "33ab1c7b46441250ad32addd8be0d6845cdc238f8268ec8e31c422226241bb90"
  end

  depends_on "homebrew/core/node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    output = pipe_output("#{bin}/claude-agent-acp 2>&1", "{}")
    assert_match "Invalid message", output
  end
end
