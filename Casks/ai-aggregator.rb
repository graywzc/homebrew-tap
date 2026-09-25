cask "ai-aggregator" do
  version "1.6.0"
  sha256 "671cc4b9197175e607bdc597a2b7d7bc84acc940155dc8b78fd6210dca43e5c0"

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
