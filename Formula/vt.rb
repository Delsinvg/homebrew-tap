class Vt < Formula
  desc "Todos in your Markdown notes, from the terminal"
  homepage "https://github.com/Delsinvg/vt"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Delsinvg/vt/releases/download/v0.1.0/vt-aarch64-apple-darwin.tar.xz"
      sha256 "be31ed1abcfb7552934ad49fb2b90cf8097d7eac47b62b882dc29ea629fd93d2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Delsinvg/vt/releases/download/v0.1.0/vt-x86_64-apple-darwin.tar.xz"
      sha256 "9c34297abcbeee6ba0627b7a4d63d32d4197b8a37b8460bba750d6176e7035cf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Delsinvg/vt/releases/download/v0.1.0/vt-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e497715a41181aee29203c0e76516ce8db55c75300744d0224945e951895bf34"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Delsinvg/vt/releases/download/v0.1.0/vt-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d64fa9a5388da1749787d628f743fe7fb080f33959f09942a2580f794737ea8c"
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
