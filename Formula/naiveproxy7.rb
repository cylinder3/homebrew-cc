class Naiveproxy7 < Formula
  desc "naiveproxy client"
  homepage "https://github.com/klzgrad/naiveproxy"
  # download binary from upstream directly
  if Hardware::CPU.intel?
    url "https://github.com/klzgrad/naiveproxy/releases/download/v114.0.5735.91-3/naiveproxy-v114.0.5735.91-3-mac-x64.tar.xz"
    sha256 "4568db5eefe9a643b0f1eca2de1acda89310894b3e6bbda3c73e6f4b40316af3"
  else
    url "https://github.com/klzgrad/naiveproxy/releases/download/v114.0.5735.91-3/naiveproxy-v114.0.5735.91-3-mac-arm64.tar.xz"
    sha256 "fcb1aaa926cd474e9a074987a5e5f3ebc3c7db868ad28d71001111c3465ba7a9"
  end
  version "v114.0.5735.91-3"
  license "BSD 3-Clause"

  def install
    bin.install "naive"
    (etc/"naiveproxy").mkpath
    etc.install "config.json" => "naiveproxy/config.json-example"
  end

  def caveats
    <<~EOS
      client config example has been installed to #{etc}/naiveproxy/config.json-example
      please modify it and rename to config.json
    EOS
  end

  test do
    system "/usr/local/bin/naive", "--version"
  end

  plist_options :manual => "naive #{HOMEBREW_PREFIX}/etc/naiveproxy/config.json"

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
            <string>/usr/local/bin/naive</string>
            <string>#{etc}/naiveproxy/config.json</string>
          </array>
        </dict>
      </plist>
    EOS
  end
end
