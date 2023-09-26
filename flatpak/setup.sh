flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo

applications=(
  # Day to Day
  "org.standardnotes.standardnotes" # Notes
  "com.spotify.Client" # Music
  "org.mozilla.firefox" # Web browser
  "com.rafaelmardojai.Blanket" # Background noise
  "re.sonny.Junction" # Web browser chooser (select it as a default browser)
  "com.nextcloud.desktopclient.nextcloud" # Nextcloud

  # Tools
  "com.github.tchx84.Flatseal" # Manage Flatpak permissions
  "org.gabmus.whatip" # IP address
  "re.sonny.Workbench" # Learn and prototype with GNOME technologies

  # Productivity
  "io.github.seadve.Kooha" # Screen recording
  "com.github.junrrein.PDFSlicer" # PDF splitter
  "org.kde.okular" # PDF reader/editor
  "org.libreoffice.LibreOffice" # Office suite
  "app/org.videolan.VLC/x86_64/stable" # Video player
  "us.zoom.Zoom" # Video conferencing
)

gnomeApplications=(
  "nl.hjdskes.gcolor3" # Color picker
  "com.mattjakeman.ExtensionManager" # GNOME Shell extensions
)

experimentalApplications=(
  "dev.lapce.lapce" # Code editor, written in Rust
)

for application in ${applications[@]}; do
  flatpak install -y --user flathub $application
done
