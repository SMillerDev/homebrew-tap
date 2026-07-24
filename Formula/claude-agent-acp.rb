class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.61.0.tgz"
  sha256 "bb410d53e2d13591da5ebcaf09ae055d166ffefb27b7172988650cd62ef4ebd3"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.61.0"
    sha256                               arm64_tahoe:  "74ae691fd14c17357ca1718154a412457b1b1fa79d46cc401bd017016248294e"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "4a527c96579bb6c76426df0038d376355277acf2b6ce8dd9e80e28da8942e0f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0f6aa956d06e4ed27a1f01115d3acfb0654d79f1fb1d7dc8768c6aeb957b7fbc"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    output = pipe_output("#{bin}/claude-agent-acp 2>&1", "{}")
    assert_match "Invalid message", output
  end
end
