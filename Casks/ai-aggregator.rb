cask "ai-aggregator" do
  version "1.0.2"
  sha256 "caf23b64591cc04a56fded2bef383dc76adaab0a08f58d2d17ce391776df087c"

  url "https://github.com/graywzc/ai-aggregator/releases/download/v#{version}/AIAggregator.zip"
  name "AI Aggregator"
  desc "macOS menu bar app to track AI usage limits"
  homepage "https://github.com/graywzc/ai-aggregator"

  app "AIAggregator.app"

  zap trash: [
    "~/Library/Preferences/com.graywzc.AIAggregator.plist",
    "~/Library/Saved Application State/com.graywzc.AIAggregator.savedState",
  ]
end