cask "livetrans" do
  version "0.1.83"
  sha256 "166b01011c8dd5ca60932fb823e73d1b0c3e823d5ad2a93f86c6470ee8ca82fe"

  url "https://github.com/graywzc/live-trans/releases/download/v#{version}/LiveTrans.zip"
  name "LiveTrans"
  desc "Live Japanese captions with furigana and English translation"
  homepage "https://github.com/graywzc/live-trans"

  depends_on macos: :sonoma

  app "LiveTrans.app"

  postflight_steps do
    terminate_process "LiveTrans"
    # The release is signed ad hoc on a CI runner; clear the quarantine flag
    # and re-sign locally so Gatekeeper doesn't report the app as damaged.
    run "/usr/bin/xattr",
        args:           ["-cr", "{{appdir}}/LiveTrans.app"],
        writable_paths: ["LiveTrans.app"],
        writable_base:  :appdir
    run "/usr/bin/codesign",
        args:           ["--force", "--deep", "--sign", "-", "{{appdir}}/LiveTrans.app"],
        writable_paths: ["LiveTrans.app"],
        writable_base:  :appdir
  end

  zap trash: [
    "~/Library/Preferences/com.larrywang.livetrans.plist",
    "~/Library/Saved Application State/com.larrywang.livetrans.savedState",
  ]

  caveats <<~EOS
    LiveTrans transcribes on your own GPU host, reached over ssh. Set the host
    up first: https://github.com/graywzc/live-trans#gpu-host-setup

    The app is re-signed locally on every install, so macOS asks for microphone
    access again after each upgrade.
  EOS
end
