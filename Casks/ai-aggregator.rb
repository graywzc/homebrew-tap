cask "ai-aggregator" do
  version "1.7.0"
  sha256 "042b58f006c73414e17fa54408b34bf3d4bec50cadf223fb7fb6bf3c76a8f4d0"

  url "https://github.com/graywzc/ai-aggregator/releases/download/v#{version}/AIAggregator.zip"
  name "AI Aggregator"
  desc "Menu bar app to track AI usage limits"
  homepage "https://github.com/graywzc/ai-aggregator"

  depends_on macos: :ventura

  app "AIAggregator.app"

  postflight_steps do
    # 1. Quit the app if running
    terminate_process "AIAggregator"

    # 2. Fix quarantine and signature
    run "/usr/bin/xattr",
        args:           ["-cr", "{{appdir}}/AIAggregator.app"],
        writable_paths: ["AIAggregator.app"],
        writable_base:  :appdir
    run "/usr/bin/codesign",
        args:           ["--force", "--deep", "--sign", "-", "{{appdir}}/AIAggregator.app"],
        writable_paths: ["AIAggregator.app"],
        writable_base:  :appdir
  end

  # Steps run in Homebrew's sandbox, where `open` cannot launch apps. With
  # `quit`, `brew upgrade` closes the running app and reopens it afterwards.
  uninstall quit: "com.graywzc.AIAggregator"

  zap trash: [
    "~/Library/Preferences/com.graywzc.AIAggregator.plist",
    "~/Library/Saved Application State/com.graywzc.AIAggregator.savedState",
  ]
end
