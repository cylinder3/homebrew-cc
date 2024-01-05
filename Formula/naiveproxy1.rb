class Naiveproxy1 < Formula
  desc "naiveproxy client"
  homepage "https://github.com/klzgrad/naiveproxy"
  # download binary from upstream directly
  if Hardware::CPU.intel?
    url "https://github.com/klzgrad/naiveproxy/releases/download/v120.0.6099.43-1/naiveproxy-v120.0.6099.43-1-mac-x64.tar.xz"
    sha256 "e617e6a9c7feda69508c11a730844fd5dbf2e6cc9419cbf2b629142c713bb240"
  else
    url "https://github.com/klzgrad/naiveproxy/releases/download/v120.0.6099.43-1/naiveproxy-v120.0.6099.43-1-mac-arm64.tar.xz"
    sha256 "7818d44f29f65a92d4f7e5daaf9b02d1e0093e292bf7ce7926492dc21a95f055"
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
