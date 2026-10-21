class Repolens < Formula
  desc "Understand a repository's stack, services, env vars and setup problems"
  homepage "https://github.com/Douglas-Strey/repolens-cli"
  url "https://registry.npmjs.org/@douglas-strey/repolens/-/repolens-0.2.0.tgz"
  sha256 "261d78d489b74c55ac7333265692728846cbd4e9f18b506597ccf0f8dd0d2e81"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/repolens --version")

    (testpath/"package.json").write <<~JSON
      { "name": "brew-test", "packageManager": "pnpm@10.17.1", "scripts": { "dev": "vite" } }
    JSON
    output = shell_output("#{bin}/repolens --json #{testpath}")
    assert_match '"name": "brew-test"', output
    assert_match '"run": "pnpm dev"', output
  end
end
