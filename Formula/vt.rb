class Vt < Formula
  desc "Todos in your Markdown notes, from the terminal"
  homepage "https://github.com/Delsinvg/vt"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Delsinvg/vt/releases/download/v0.2.1/vt-aarch64-apple-darwin.tar.xz"
      sha256 "cba6e0f60e49ebcf88f4b766ccbc4cb01aa7e58e685f179ec310c0265a393d51"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Delsinvg/vt/releases/download/v0.2.1/vt-x86_64-apple-darwin.tar.xz"
      sha256 "9ef855973ea8f027dbc7f94c58b8f77df7d9653222dc12f3e2a20591bafba9e3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Delsinvg/vt/releases/download/v0.2.1/vt-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "39239b62605279b313fe78fb82f82a5eed93f3134c26729d3c19c0666553b40a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Delsinvg/vt/releases/download/v0.2.1/vt-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d061efe37d6b4b17bc4a2c6aff0556e17dee2ada7432d44ad890831be277b018"
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
