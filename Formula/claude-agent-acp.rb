class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.99.0.tgz"
  sha256 "03e7997feee9548bd5a2e180ec9e0a7e462fe03ca278b29b2b1050b8d7f02790"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.99.0"
    sha256                               arm64_tahoe:  "f8a38052cc171f2a42e7069edac1e558b271aec42a334c0096af07aa0b614e0c"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "8a91dfabe9b1243d197e6929cfce512174d48efe5bf4bbe1805c9f1cf59e9236"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0c7df1245745f0e985ed97306e9afb6d90d7d5bd79708cd6893fd7c6f7362f8b"
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
