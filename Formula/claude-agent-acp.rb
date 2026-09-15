class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.76.0.tgz"
  sha256 "b836570348c9400062e39f4d5866734b5fe89613d80b5cf1c47c9446c1b4eafd"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.74.0"
    sha256                               arm64_tahoe:  "915b1fb453bdcf2ed4a5fcb94a0deed363bb5736f4e1134e91819dbabe4ee3b1"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "afdc6e4f96c20e72a8d4fe6adae61bd6b013049c9a283641bfec39c8c18ef422"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "54ca20c0bb1f54b34727683304e5f2a9e970d270c6840701bc36a4421313530e"
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
