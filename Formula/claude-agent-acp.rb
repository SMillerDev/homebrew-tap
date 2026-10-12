class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.89.1.tgz"
  sha256 "0df9fa22a5e1ccc39bfba37c0c58f272febed6884fb51a2df970840796ea2acb"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.89.1"
    sha256                               arm64_tahoe:  "90c52e95184f9c6cbc88cdf23bb15864866bf66a3fe993a91cfc59c39f0a115a"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "2c86266873d7bba5a4971e30f6a795bbedc1a0bf7cc570e5a5338ec6f72f4c9f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d08898e17fe333c65f6c404ee69cecc3c8f693fc027b2c34a6f9b20b19738928"
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
