class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.85.0.tgz"
  sha256 "443235d6ee4c4bc6f4b294824a55e01b84ef0472a190d294c28e96da7b501213"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.84.0"
    sha256                               arm64_tahoe:  "596e47884b8ff090062c164a7bb95256deb92709a0eece26d9598e741007ebac"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "87447df2997c7827f6e5f51c97f283cc57434f2d9e957353c929c51b724f8c2c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "19b5ccb32d1422336c4b97bad5042dbf787aca72d4599687e603d601ef80efcd"
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
