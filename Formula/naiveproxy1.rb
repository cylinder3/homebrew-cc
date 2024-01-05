class Naiveproxy1 < Formula
  desc "naiveproxy client"
  homepage "https://github.com/klzgrad/naiveproxy"
  # download binary from upstream directly
  if Hardware::CPU.intel?
    url "https://github.com/klzgrad/naiveproxy/releases/download/v120.0.6099.43-1/naiveproxy-v120.0.6099.43-1-mac-x64.tar.xz"
    sha256 "595d488e4b55aaaddd815a9f38fdc9d6139a2cfa12327928da5c2820793ba611"
  else
    url "https://github.com/klzgrad/naiveproxy/releases/download/v120.0.6099.43-1/naiveproxy-v120.0.6099.43-1-mac-arm64.tar.xz"
    sha256 "3c12ce7797f420c00b813f0059107c8f9b70951429fcbbd9a9a864bcd900bbb7"
  end
  version "v120.0.6099.43-1"
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
    system opt_bin/"naive", "--version"
  end

  service do
    run [opt_bin/"naive", "#{etc}/naiveproxy/naiveproxy1.json"]
    run_type :immediate
    keep_alive true
  end
end
