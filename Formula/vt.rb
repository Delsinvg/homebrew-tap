class Vt < Formula
  desc "Todos in your Markdown notes, from the terminal"
  homepage "https://github.com/Delsinvg/vt"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Delsinvg/vt/releases/download/v0.2.0/vt-aarch64-apple-darwin.tar.xz"
      sha256 "b32dbc31027d08803cb8bc6443687d066e096caf9aba4e4213812b57d96f9f18"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Delsinvg/vt/releases/download/v0.2.0/vt-x86_64-apple-darwin.tar.xz"
      sha256 "007c0530a9f86a5d6d0a3fe4c59a78a610d8ae67c774e58f41309d5cc45b9ec4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Delsinvg/vt/releases/download/v0.2.0/vt-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "42162d5bb1295a00348c39922bd611cdf98d753f12e94fffdf77b520cd6a916e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Delsinvg/vt/releases/download/v0.2.0/vt-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "14c775696d7ae2a47e7e3f054cdd7852ca18a12f22f8c7a98d488a9f0df08cfc"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "vt"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "vt"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "vt"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "vt"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
