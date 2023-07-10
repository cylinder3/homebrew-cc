class Hysteria1 < Formula
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
    etc.install "config.json" => "hysteria/config.json-example"
  end

  def caveats
    <<~EOS
      client config example has been installed to #{etc}/hysteria/config.json-example
      please modify it and rename to config.json
    EOS
  end

  test do
    system "#{bin}/hysteria-darwin-amd64-avx", "--version"
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
            <string>#{bin}/hysteria-darwin-amd64-avx</string>
            <string>#{etc}/hysteria/config.json</string>
          </array>
        </dict>
      </plist>
    EOS
  end
end
