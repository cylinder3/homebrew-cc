class Xray3 < Formula
  desc "Platform for building proxies to bypass network restrictions"
  homepage "https://xtls.github.io/"
  url "https://github.com/XTLS/Xray-core/releases/download/v1.8.4/Xray-macos-64.zip"
  sha256 "251c9455fd2793072d534e180eae60844d3ec05566c22009e7a7b8abf93371fc"
  license all_of: ["MPL-2.0", "CC-BY-SA-4.0"]
  version "v1.8.4"

  def install
    bin.install "xray"
    pkgshare.install "geoip.dat"
    pkgshare.install "geosite.dat"
    (etc/"xray").mkpath
  end

  service do
    run [opt_bin/"xray", "run", "--config", "#{etc}/xray/xray3.json"]
    run_type :immediate
    keep_alive true
  end

  test do
    system opt_bin/"xray", "--version"
  end
end