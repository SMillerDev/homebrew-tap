class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.97.0.tgz"
  sha256 "e41a8e21333c5ab6e94bdd9b7c58536f10897a9d07e54058c9e9e73fde41e5b9"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.95.0"
    sha256                               arm64_tahoe:  "a932537ea1a58d687d97a886dccf3cd7f7eb240c95f42030583db1ebd0b8cb8c"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "18575bb492e9a5d2f5bab829e549148b2931a218129a9f0fd313bce54023a021"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0e3b903a98ccefab75bcb418593d9b7663143cf9445939f214a3b4d4240f3cc5"
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
