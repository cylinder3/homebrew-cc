class Hysteria13 < Formula
  desc "hysteria client"
  homepage "https://github.com/apernet/hysteria"
  # download binary from upstream directly
  url "https://github.com/apernet/hysteria/releases/download/v1.3.5/hysteria-darwin-amd64-avx"
  sha256 "1f76b3d63d18c81a8dc2444a1854d4628060909cd41481c27ff6abf30c0fa4ba"
  version "v1.3.5"
  license "MIT"

  def install
    bin.install "hysteria-darwin-amd64-avx"
    (etc/"hysteria").mkpath
  end

  def caveats
    <<~EOS
    Create hysteria configure file on `/usr/local/etc/hysteria/config.json`
    {
      "server": "example.com:5666",
      "obfs": "pass",
      "up_mbps": 10,
      "down_mbps": 100,
      "socks5": {
        "listen": "ip:port"
      },
      "retry": 3,
      "recv_window_conn": 100000000,
      "recv_window": 250000000,
      "fast_open": false,
      "resolve_preference": "4"
    }
    To start the service, run:
      brew services start hysteria13
    EOS
  end

  test do
    system opt_bin/"hysteria-darwin-amd64-avx", "--version"
  end

  service do
    run [opt_bin/"hysteria-darwin-amd64-avx", "--config", "#{etc}/hysteria/config.json"]
    run_type :immediate
    keep_alive true
  end
end
