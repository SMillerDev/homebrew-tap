class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.98.0.tgz"
  sha256 "94cdee902d7d4ddb0360b330c0be9f728aae3370b3028b7d835856ab33e20c8b"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.98.0"
    sha256                               arm64_tahoe:  "b9d506560dda472dc88239a34cb365233b6fad6bb31b78c8c2a3573b8ee103f0"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "20aaea3abffc42b92931599e95034a21e1f6b5a7fdb8cbf11ce1a5f6deda4858"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9b00a3c519c37c74393bac6795abec1fe6c9f2b0b602d6a9f9d5f7abef8f9d91"
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
