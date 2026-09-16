class ClaudeAgentAcp < Formula
  desc "Use Claude Agent SDK from ACP-compatible clients"
  homepage "https://github.com/agentclientprotocol/claude-agent-acp"
  url "https://registry.npmjs.org/@agentclientprotocol/claude-agent-acp/-/claude-agent-acp-0.77.0.tgz"
  sha256 "040871730a084d5da591fff441d51628fb14e6842021aea53d5b5d6923eac508"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/SMillerDev/homebrew-tap/releases/download/claude-agent-acp-0.77.0"
    sha256                               arm64_tahoe:  "2b4fe9a04e529076e8e2ba42cbfa32b7b365d96768315f0dbb4c90d5f2ea1c51"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "3d46c1c97130df60b3be12d7424a894286327550108b237551ec2aca85c69611"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "08e490d6b17669f62ac3933b584d3961796375be0579080629beafc77d2e5da4"
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
