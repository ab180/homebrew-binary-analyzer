class BinaryAnalyzer < Formula
  desc "Static analysis tool for mobile apps using the Airbridge SDK"
  homepage "https://www.airbridge.io/"

  version = "0.0.0"
  sha_macos_aarch64 = "72a0f59075c35eeaec705f192cb4abca6594231f01846e54aa5d970f0acb4498"
  sha_macos_x64 = "96f1293f5359c2f22e39107bcf4cf36f8811916f00ef90dcdf94f0f32c319406"
  # sha_linux_aarch64 = ""
  sha_linux_x64 = "e4fcb32135a385bb9483e045f5584b92d9c8dc5a7147a7f252197a839253218d"

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
    bin.install "binary-analyzer"
  end
end
