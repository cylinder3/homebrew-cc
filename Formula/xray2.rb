class Xray2 < Formula
  desc "Platform for building proxies to bypass network restrictions"
  homepage "https://xtls.github.io/"
  url "https://github.com/XTLS/Xray-core/releases/download/v1.8.6/Xray-macos-64.zip"
  sha256 "54616fe61381dad92cfa30030dda3211b3c2e86eb496b18a0462451e29728b5e"
  license all_of: ["MPL-2.0", "CC-BY-SA-4.0"]
  version "v1.8.6"

  def install
    bin.install "xray"
    bin.install "geoip.dat"
    bin.install "geosite.dat"
    (etc/"xray").mkpath
  end

  service do
    run [opt_bin/"xray", "run", "--config", "#{etc}/xray/xray2.json"]
    run_type :immediate
    keep_alive true
  end

  test do
    system opt_bin/"xray", "--version"
  end
end