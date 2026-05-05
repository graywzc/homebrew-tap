class ScreenSnipper < Formula
  desc "Tiny macOS screen-region recorder for GIFs and MP4 video"
  homepage "https://github.com/graywzc/screen-snipper"
  url "https://github.com/graywzc/screen-snipper/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "092f61272520b3dbfe56a41b30d4dd2577911c078cd56b635aac8f7e83a6a6fc"
  license :cannot_represent

  depends_on macos: :sonoma

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/screen-snipper"
    pkgshare.install "Shortcuts/ScreenSnipper.shortcut"
  end

  def post_install
    shortcut = pkgshare/"ScreenSnipper.shortcut"
    return unless shortcut.exist?
    return unless File.executable?("/usr/bin/shortcuts")

    existing = Utils.safe_popen_read("/usr/bin/shortcuts", "list").lines.map(&:strip)
    return if existing.include?("Screen Snipper")

    system "/usr/bin/shortcuts", "import", shortcut.to_s
  end

  def caveats
    <<~EOS
      A macOS Shortcut named "Screen Snipper" was imported. Click
      "Add Shortcut" in the Shortcuts.app dialog if it appeared.

      To trigger it with a hotkey:
        1. Open Shortcuts.app
        2. Select "Screen Snipper"
        3. Open the details panel (i icon)
        4. Click "Add Keyboard Shortcut" and press your combo (e.g. Cmd-Shift-7)

      While Screen Snipper is open:
        Cmd-Shift-Space  start/stop recording
        Cmd-Shift-7      close the app
    EOS
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/screen-snipper --help")
  end
end
