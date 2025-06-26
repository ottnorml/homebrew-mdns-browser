cask "mdns-browser" do
  version "0.19.5"
  # see https://github.com/hrzlgnm/mdns-browser/releases/download/mdns-browser-v#{version}/mdns-browser_#{version}_universal.dmg.sha256
  sha256 "555f8547a696722161123473af81d9fc999c493a019367dfacec24b6bf2ae044"

  url "https://github.com/hrzlgnm/mdns-browser/releases/download/mdns-browser-v#{version}/mdns-browser_#{version}_universal.dmg"
  name "mDNS-Browser"
  desc "Graphical discovery, inspection and testing tool for mDNS services"
  homepage "https://github.com/hrzlgnm/mdns-browser"

  livecheck do
    url :url
    regex(/^mdns-browser[._-]v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"] || release["prerelease"]

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        match[1]
      end
    end
  end

  depends_on macos: ">= :high_sierra"

  app "mdns-browser.app"
  binary "#{appdir}/mdns-browser.app/Contents/MacOS/mdns-browser"

  zap trash: [
    "~/Library/Caches/com.github.hrzlgnm.mdns-browser",
    "~/Library/Logs/com.github.hrzlgnm.mdns-browser",
    "~/Library/WebKit/com.github.hrzlgnm.mdns-browser",
  ]
end
