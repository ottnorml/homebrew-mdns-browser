cask "mdns-browser" do
  version "1.5.1"
  # see https://github.com/hrzlgnm/mdns-browser/releases/download/mdns-browser-v#{version}/mdns-browser_#{version}_universal.dmg.sha256
  sha256 "b0ac38e900ea1697e1ab1d4b975ff3d494c13fc75fe86c6941bc136c0d977034"

  url "https://github.com/hrzlgnm/mdns-browser/releases/download/mdns-browser-v#{version}/mdns-browser_#{version}_universal.dmg"
  name "mDNS-Browser"
  desc "Cross platform app written in Rust using Tauri and Leptos"
  homepage "https://github.com/hrzlgnm/mdns-browser"

  livecheck do
    url :url
    regex(/^mdns-browser-v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"] || release["prerelease"]

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        match[1]
      end
    end
  end

  depends_on macos: ">= :monterey"

  app "mdns-browser.app"
  binary "#{appdir}/mdns-browser.app/Contents/MacOS/mdns-browser"

  zap trash: [
    "~/Library/Caches/com.github.hrzlgnm.mdns-browser",
    "~/Library/Logs/com.github.hrzlgnm.mdns-browser",
    "~/Library/WebKit/com.github.hrzlgnm.mdns-browser",
  ]
end
