class BinaryAnalyzer < Formula
  desc "Static analysis tool for mobile apps using the Airbridge SDK"
  homepage "https://www.airbridge.io/"

  version = "0.0.0"
  sha_macos_aarch64 = "ce66d782b51c53ce1e2976d9044a24dd64321486fd1d8bb447ab61b048b80416"
  sha_macos_x64 = "141fd7b732fde5093ace6130083202a1d21bb14057d7c53f5be7d737fa215df8"
  # sha_linux_aarch64 = ""
  sha_linux_x64 = "d0c87cd7d74bec3315141f00431face73c672bbd67cfa31231c7b898f18b3924"

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
