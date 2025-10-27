class Cleanold < Formula
  desc "Clean up old files by moving them to macOS Trash"
  homepage "https://github.com/raoxiaoman/homebrew-tools"
  url "https://github.com/raoxiaoman/cleanold/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"
  license "MIT"

  def install
    bin.install "bin/cleanold"
  end

  test do
    system "#{bin}/cleanold", "-h"
  end
end
