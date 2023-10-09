class Naiveproxy5 < Formula
  desc "naiveproxy client"
  homepage "https://github.com/klzgrad/naiveproxy"
  # download binary from upstream directly
  if Hardware::CPU.intel?
    url "https://github.com/klzgrad/naiveproxy/releases/download/v117.0.5938.44-1/naiveproxy-v117.0.5938.44-1-mac-x64.tar.xz"
    sha256 "ab54c3ae82c4a07fdcded6d5c70b87c07316c693dd3d50ee60d4ed167c3096d2"
  else
    url "https://github.com/klzgrad/naiveproxy/releases/download/v117.0.5938.44-1/naiveproxy-v117.0.5938.44-1-mac-arm64.tar.xz"
    sha256 "d261517d3213d7c94c46e1f01bbeb230abfcf8be7934549653810e341d7e3ff4"
  end
  version "v117.0.5938.44-1"
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
    run [opt_bin/"naive", "#{etc}/naiveproxy/config.json"]
    run_type :immediate
    keep_alive true
  end
end
