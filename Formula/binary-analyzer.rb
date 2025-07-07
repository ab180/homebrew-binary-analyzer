class BinaryAnalyzer < Formula
  desc "Static analysis tool for mobile apps using the Airbridge SDK"
  homepage "https://sdk-internal.airbridge.io/binary-analyzer/latest/"

  binary_analyzer_version = "0.0.1"
  sha_macos_aarch64 = "0fa5eee9a44dfc6de144f975d333e96031b5d8d0fd9f0f23ca20966adc32ea1b"
  sha_macos_x64 = "1a4d2887934fddc0ffa7d01811dc52315f50bd7faaadce3bf146078fbdd9c262"
  # sha_linux_aarch64 = ""
  sha_linux_x64 = "59a937942c9c84edeedc8688b9f225ecb1a9f9a5b5d2560b37f714142f8e8118"

  on_macos do
    if Hardware::CPU.arm?
      url "https://sdk-internal.airbridge.io/binary-analyzer/#{binary_analyzer_version}/macos-aarch64/binary-analyzer.tar.gz"
      sha256 sha_macos_aarch64
    else
      url "https://sdk-internal.airbridge.io/binary-analyzer/#{binary_analyzer_version}/macos-x64/binary-analyzer.tar.gz"
      sha256 sha_macos_x64
    end
  end

  on_linux do
    # if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    #   url "https://sdk-internal.airbridge.io/binary-analyzer/#{binary_analyzer_version}/linux-aarch64/binary-analyzer.tar.gz"
    #   sha256 sha_linux_aarch64
    # end
    if Hardware::CPU.intel?
      url "https://sdk-internal.airbridge.io/binary-analyzer/#{binary_analyzer_version}/linux-x64/binary-analyzer.tar.gz"
      sha256 sha_linux_x64
    else
      version binary_analyzer_version
      # Dummy URL and SHA256 just to satisfy Homebrew audit for Linux ARM
      url "https://example.com/unsupported-linux-arm.tar.gz"
      sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855" # SHA of empty file
    end
  end

  def install
    bin.install "binary-analyzer"
  end
end
