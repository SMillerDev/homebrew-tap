class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.55.0.tgz"
  sha256 "ef9ed0322796c388f782843b87f3cccf1865f1660d78ecb4e30bfff83a9fa207"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.52.0"
    sha256                               arm64_tahoe:  "ea7de98e3389708cc7783eaa7d22781fcaceb913bd52d85974b4211d71d6e279"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "0d02c02f3d1e5eb05639a0a27c1872b09e9d0ce6628d3ee3a4343f354ff39b37"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "081b30522fc3cdd67f2881f924eb80f30ca8df930bb03357a141e92f9185a113"
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
