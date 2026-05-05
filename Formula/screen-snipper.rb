class ScreenSnipper < Formula
  desc "Tiny macOS screen-region recorder for GIFs and MP4 video"
  homepage "https://github.com/graywzc/screen-snipper"
  url "https://github.com/graywzc/screen-snipper/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "866a62fd6dd9524e4dc7894f8aeca78ee421e88af5b9983103141d86b87af42f"
  license :cannot_represent

  depends_on macos: :sonoma

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/screen-snipper"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/screen-snipper --help")
  end
end
