class BinaryAnalyzer < Formula
  desc "Static analysis tool for mobile apps using the Airbridge SDK"
  homepage "https://www.airbridge.io/"

  version = "0.0.0"
  sha_macos_aarch64 = "cf648a2cfb3c0acbad935f6808894f91505d32a3f84f305e7061971d3f76b5e6"
  sha_macos_x64 = "fd468e487ce0ce211530a38f6fafad7d695bbbb9d55ad5b9c565ce0aa8bcfcfe"
  # sha_linux_aarch64 = ""
  sha_linux_x64 = "ee6f8a10b100c3755d7fb8933abe90dbedfaccf8ba3b0dbfeddd75d92845a056"

  depends_on "zlib"

  on_macos do
    if Hardware::CPU.arm?
      url "https://sdk-internal.airbridge.io/binary-analyzer/#{version}/macos-aarch64/binary-analyzer.tar.gz"
      sha256 sha_macos_aarch64
    else
      url "https://sdk-internal.airbridge.io/binary-analyzer/#{version}/macos-x64/binary-analyzer.tar.gz"
      sha256 sha_macos_x64
    end
  end

  on_linux do
    depends_on "patchelf" => :build
    # if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    #   url "https://sdk-internal.airbridge.io/binary-analyzer/#{version}/linux-aarch64/binary-analyzer.tar.gz"
    #   sha256 sha_linux_aarch64
    # end
    if Hardware::CPU.intel?
      url "https://sdk-internal.airbridge.io/binary-analyzer/#{version}/linux-x64/binary-analyzer.tar.gz"
      sha256 sha_linux_x64
    else
      version "0.0.0"
      # Dummy URL and SHA256 just to satisfy Homebrew audit for Linux ARM
      url "https://example.com/unsupported-linux-arm.tar.gz"
      sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855" # SHA of empty file
    end
  end

  def install
    libexec.install "binary-analyzer.jar"
    libexec.install "binary-analyzer"

    if OS.linux?
      # Set RPATH for dynamic libz
      rpath = Formula["zlib"].opt_lib
      system "patchelf", "--set-rpath", rpath, "#{libexec}/binary-analyzer"
    end

    (bin / "binary-analyzer").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/binary-analyzer" "$@"
    EOS
  end
end
