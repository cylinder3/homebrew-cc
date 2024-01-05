class Hysteria21 < Formula
  desc "hysteria client"
  homepage "https://github.com/apernet/hysteria"
  # download binary from upstream directly
  url "https://github.com/apernet/hysteria/releases/download/app/v2.2.3/hysteria-darwin-amd64-avx"
  sha256 "dcffb2637d5dabb8c4af8b8853dc5bc6e9ffa63e93b66ab2bf7413da5cd98d0a"
  version "v2.2.3"
  license "MIT"

  def install
    bin.install "hysteria-darwin-amd64-avx"
    (etc/"hysteria2").mkpath
  end

  def caveats
    <<~EOS
    Create hysteria configure file on `/usr/local/etc/hysteria2/hysteria21.yaml`
    server: example.com:443
    auth: some_password
    transport:
      type: udp
      udp:
        hopInterval: 30s 
    quic:
      initStreamReceiveWindow: 8388608 
      maxStreamReceiveWindow: 8388608 
      initConnReceiveWindow: 20971520 
      maxConnReceiveWindow: 20971520 
      maxIdleTimeout: 30s 
      keepAlivePeriod: 10s 
      disablePathMTUDiscovery: false 
    bandwidth:
      up: 50 mbps
      down: 50 mbps
    fastOpen: true
    lazy: true
    socks5:
      listen: 127.0.0.1:1080
      disableUDP: false
    
    To start the service, run:
      brew services start hysteria21
    EOS
  end

  test do
    system opt_bin/"hysteria-darwin-amd64-avx", "version"
  end

  service do
    run [opt_bin/"hysteria-darwin-amd64-avx", "-c", "#{etc}/hysteria2/hysteria21.yaml"]
    run_type :immediate
    keep_alive true
  end
end
