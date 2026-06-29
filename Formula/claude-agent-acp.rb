class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.52.0.tgz"
  sha256 "ceee1a711a368c0edc85921c9d231ebd314c717f48c81e31e8aecd4eb1ef1659"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.49.0"
    sha256                               arm64_tahoe:  "95fb5c25b4d7c9fdaa79139a01047775b13199443633cc37d10ea71d30015a82"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "d7ea2aa254062100384389a1a9ac4a6f354b1dca164844f7004972822d082a57"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6e9ad6a2c40d206f5cdba7cba1f8afe7066f8457fc9985ff7f1f3748489937f6"
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
