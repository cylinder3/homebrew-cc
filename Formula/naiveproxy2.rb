class Naiveproxy2 < Formula
  desc "naiveproxy client"
  homepage "https://github.com/klzgrad/naiveproxy"
  # download binary from upstream directly
  if Hardware::CPU.intel?
    url "https://github.com/klzgrad/naiveproxy/releases/download/v148.0.7778.96-5/naiveproxy-v148.0.7778.96-5-mac-x64-x64.tar.xz"
    sha256 "b8e6f6348a7384f30409d67e2c35a6d14de64fc6fcf908385dcf5283bf8815cb"
  else
    url "https://github.com/klzgrad/naiveproxy/releases/download/v148.0.7778.96-5/naiveproxy-v148.0.7778.96-5-mac-arm64-arm64.tar.xz"
    sha256 "b8e6f6348a7384f30409d67e2c35a6d14de64fc6fcf908385dcf5283bf8815cb"
  end
  version "v148.0.7778.96-5"
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
    run [opt_bin/"naive", "#{etc}/naiveproxy/naiveproxy2.json"]
    run_type :immediate
    keep_alive true
  end
end
