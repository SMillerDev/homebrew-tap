class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.69.0.tgz"
  sha256 "73334255e17f5f48f08030fa4e0c54c118e820f9aaaf29f4629aa230e48c65c2"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.68.0"
    sha256                               arm64_tahoe:  "618dea17d749d90c1d235e848e73fcded7c9b846304b91a3df29037ee10f718c"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "91e6faa7618c67349369a3a607f6e0a57ebb12c3461619a189dbdeaabf2f1f7c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e8d83e61a27e6318be263caef2f7575badcc40757434d3c5d038749453c1a27d"
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
