# bl-dl

Script, Dockerfile, and instructions for downloading full-resolution images for an entire manuscript from the British Library.

## Docker step-by-step instructions

These instructions assume you already have a working [Docker](https://www.docker.com/) install running and some command-line familiarity.

1. Go to the webpage of the British Library manuscript you want to download. For our example we'll use Burney MS 86: <http://www.bl.uk/manuscripts/FullDisplay.aspx?ref=burney_ms_86>
2. Open the image viewer for the manuscript and copy the resulting link, e.g.: <http://www.bl.uk/manuscripts/Viewer.aspx?ref=burney_ms_86_fs001r>
3. Run [the `bl-dl` Docker image](https://hub.docker.com/repository/docker/ryanfb/bl-dl/general) using the image viewer link you just copied, and mapping the current directory into the `/data` volume, e.g.: `docker run -ti -v "$(pwd)":/data ryanfb/bl-dl "http://www.bl.uk/manuscripts/Viewer.aspx?ref=burney_ms_86_fs001r"`

## Non-Docker step-by-step command-line instructions

If you'd prefer not to use Docker, you can instead run this script natively. These instructions assume some command-line familiarity. The `bl-dl.sh` script also needs: `bash`, `wget`, `sort`, `uniq`, `sed`, `grep`, and `fgrep` installed.

1. Download the latest release of `dezoomify-rs` for your platform: <https://github.com/lovasoa/dezoomify-rs/releases>
2. Extract the download archive and open a terminal or command line prompt where the `dezoomify-rs` executable is available. Copy/move the `dezoomify-rs` excutable so that it is available on your `PATH`, e.g.: `sudo mv -v dezoomify-rs /usr/local/bin/`
3. Download [this script](https://github.com/ryanfb/bl-dl/blob/main/bl-dl.sh): `wget "https://raw.githubusercontent.com/ryanfb/bl-dl/main/bl-dl.sh"` - and make it executable, e.g.: `chmod a+x bl-dl.sh`
4. Go to the webpage of the British Library manuscript you want to download. For our example we'll use Burney MS 86: <http://www.bl.uk/manuscripts/FullDisplay.aspx?ref=burney_ms_86>
5. Open the image viewer for the manuscript and copy the resulting link, e.g.: <http://www.bl.uk/manuscripts/Viewer.aspx?ref=burney_ms_86_fs001r>
6. Run the `bl-dl.sh` script you downloaded using the image viewer link you just copied, e.g.: `./bl-dl.sh "http://www.bl.uk/manuscripts/Viewer.aspx?ref=burney_ms_86_fs001r"`
7. The script should automatically run `dezoomify-rs` to download the largest version available for every manuscript image.
