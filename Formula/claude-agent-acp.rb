class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.73.0.tgz"
  sha256 "eb03d0c6c1934726535d5c6b8defd3b37c2c2d77f5d9d037d3a97d624ea733c3"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.73.0"
    sha256                               arm64_tahoe:  "54d4b152090db8c4176bbe950dd62d5003dcf9b62e61422b6f29f1c42671c0e8"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "a9249740fbde073194bb746c60ed66cf1818299edeee21c91480cd1fd86c45a7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0fd3eaf09e7beef4030d18230746bf4ee0814c2a345860bb245b898533ec922d"
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
