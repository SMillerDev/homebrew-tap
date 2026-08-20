class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.70.0.tgz"
  sha256 "da2cf1b5f66981578313126a49002c4ae7e0c7e71d92b545f2b834835c6db465"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.70.0"
    sha256                               arm64_tahoe:  "0b20c5129a0de3f441d7628c9af509b5ad0bc01f32b36cdf6c95cdfdfabd2c37"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "c3511280e41d43811f1cdb57bbf8f7e0ba6b59b6334c0a9126f07f0b64d91e8e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e6b1a655b85a01418dcac1e1e3b47915bee47d9218be372d34d28e34ef4099a2"
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
