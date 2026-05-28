class Xray2 < Formula
  desc "Platform for building proxies to bypass network restrictions"
  homepage "https://xtls.github.io/"
  if Hardware::CPU.intel?
    url "https://github.com/XTLS/Xray-core/releases/download/v26.3.27/Xray-macos-64.zip"
    sha256 "f5b0471d3459eff1b82e48af0aeac186abcc3298210070afbbbd8437a4e8b203"
  else
    url "https://github.com/XTLS/Xray-core/releases/download/v26.3.27/Xray-macos-arm64-v8a.zip"
    sha256 "2e93a67e8aa1936ecefb307e120830fcbd4c643ab9b1c46a2d0838d5f8409eaf"
  end
  license all_of: ["MPL-2.0", "CC-BY-SA-4.0"]
  version "v26.3.27"

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