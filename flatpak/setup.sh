flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo

applications=(
  # Day to Day
  "org.standardnotes.standardnotes"
  "com.spotify.Client"
  "org.mozilla.firefox"
  "com.rafaelmardojai.Blanket"
  "re.sonny.Junction"

  # Tools
  "com.github.tchx84.Flatseal"
  "org.gabmus.whatip"

  "io.github.seadve.Kooha"
  "com.github.junrrein.PDFSlicer"
  "org.kde.okular"
  "org.libreoffice.LibreOffice"
  "app/org.videolan.VLC/x86_64/stable"
  "us.zoom.Zoom"
)

gnomeApplications=(
  "nl.hjdskes.gcolor3"
  "com.mattjakeman.ExtensionManager"
)

experimentalApplications=(
  "dev.lapce.lapce"
)

for application in ${applications[@]}; do
  flatpak install -y --user flathub $application
done
