class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.70.0.tgz"
  sha256 "da2cf1b5f66981578313126a49002c4ae7e0c7e71d92b545f2b834835c6db465"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.69.0"
    sha256                               arm64_tahoe:  "fadfebbaf9a52979e9b60507b8f8c9cf151983e44b5421f0bd024e7741fb215d"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "1637cef3958d90f50f18f6d77ccfb147663fb17e8acb6916fb2d05be91a17a60"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4dff1b66711fabd61b784e3f9a9f75432f1981da614425752111e8b65b839af0"
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
