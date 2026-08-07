class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.65.0.tgz"
  sha256 "92ed8b82a982288cd63648e8dd3e1edba8790ee459a2736092d17fbdb53db7df"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.65.0"
    sha256                               arm64_tahoe:  "1c8d9644675535a067208ad517f70b73c33eeae3b3b91238507b114c8545863f"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "e87dadb81d2480c5e51f1aa03cdd788a443979ec810f7100c756ee9f24095629"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1643d0e2308c273299db6d33dda4060dcb839a760982647d58cc608a2749d2a5"
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
