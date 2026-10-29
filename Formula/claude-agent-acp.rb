class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.98.0.tgz"
  sha256 "94cdee902d7d4ddb0360b330c0be9f728aae3370b3028b7d835856ab33e20c8b"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.97.0"
    sha256                               arm64_tahoe:  "7edf9fa26efe59bd7f7964c5d08d2d462c00893298acd7116744f38240629200"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "d19d0c7ea428ae2fe921da2b6ad09f35c897205bdff4600c633266e26c2f14e6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "12fdb8289d5c84d975064b58dad75472707a2ae130f4f26fc4df947e03bc6310"
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
