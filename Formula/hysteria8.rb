class Hysteria8 < Formula
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
      brew services start hysteria8
    EOS
  end

  test do
    system "/usr/local/bin/hysteria-darwin-amd64-avx", "--version"
  end

  plist_options :manual => "hysteria-darwin-amd64-avx #{HOMEBREW_PREFIX}/etc/hysteria/config.json"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>KeepAlive</key>
          <true/>
          <key>RunAtLoad</key>
          <true/>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
            <string>/usr/local/bin/hysteria-darwin-amd64-avx</string>
            <string>--config</string>
            <string>#{etc}/hysteria/config.json</string>
          </array>
        </dict>
      </plist>
    EOS
  end
end
