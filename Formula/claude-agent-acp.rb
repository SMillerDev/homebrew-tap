class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.64.2.tgz"
  sha256 "0129434e382a41bbcb38d3a32c50dc32f1382f285fe070d7f2f507684b6e0e54"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.63.0"
    sha256                               arm64_tahoe:  "11c3324b1ffcd643d0bf2eefab2362536dc3bb1b4c1043ddb64c64f21ce0d3f7"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "e196359de41e17e8edf6a2f646bdaa6d8624afaf6e4ba8aa5c5401017f504c3b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2620c2523a14b24610245c55c89ae02130e7a84f642be31806ae5f0f3c03706b"
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
