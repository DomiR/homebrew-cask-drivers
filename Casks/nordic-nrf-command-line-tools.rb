cask "nordic-nrf-command-line-tools" do
  version "10.15.4"
  sha256 "819BCB09B6F0AFAF83755CF564B682FB425096FC6A363B7F7705EDCE450EE2A4"

  url "https://www.nordicsemi.com/-/media/Software-and-other-downloads/Desktop-software/nRF-command-line-tools/sw/Versions-#{version.major}-x-x/#{version.dots_to_hyphens}/nRF-Command-Line-Tools_#{version.dots_to_underscores}_OSX.zip"
  name "nRF Command Line Tools"
  desc "Command-line tools for Nordic nRF Semiconductors"
  homepage "https://www.nordicsemi.com/Software-and-Tools/Development-Tools/nRF-Command-Line-Tools"

  livecheck do
    url "https://www.nordicsemi.com/Products/Development-tools/nRF-Command-Line-Tools/Download"
    strategy :page_match do |page|
      page.scan(/nRF[._-]Command[._-]Line[._-]Tools[._-]v?(\d+(?:[_.]\d+)+)[._-]OSX\.zip/i)
          .map { |match| match[0].tr("_", ".") }
    end
  end

  depends_on cask: "segger-jlink"

  binary "nrfjprog/nrfjprog"
  binary "mergehex/mergehex"

  preflight do
    system_command "/usr/bin/tar", args: [
      "--extract",
      "--file",
      "#{staged_path}/nRF-Command-Line-Tools_#{version.dots_to_underscores}_OSX/nRF-Command-Line-Tools_#{version.dots_to_underscores}_OSX.tar",
      "--directory",
      staged_path,
    ]
    system_command "/usr/bin/tar", args: [
      "--extract",
      "--file",
      "#{staged_path}/nRF-Command-Line-Tools_#{version.dots_to_underscores}.tar",
      "--directory",
      staged_path,
    ]
  end
end
