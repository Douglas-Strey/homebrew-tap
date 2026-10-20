class Repolens < Formula
  desc "Understand a repository's stack, services, env vars and setup problems"
  homepage "https://github.com/Douglas-Strey/repolens-cli"
  url "https://registry.npmjs.org/@douglas-strey/repolens/-/repolens-0.1.1.tgz"
  sha256 "fa811f6dd2b64a73e81dd98c7fe72eac8a0d2444001e2d4b2504d452a6f7071e"
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
