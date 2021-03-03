function _gnome-settings-backup() {
  # omfg V
  local fsConformName="dconf${${1//\//\.}%-}.ini"
  echo "$1 > $fsConformName"
  dconf dump "$1" > "$(chezmoi source-path)/ignored/included/$fsConformName"
}
function _gnome-settings-restore() {
  # omfg V
  local fsConformName="dconf${${1//\//\.}%-}.ini"
  echo "$1 < $fsConformName"
  dconf load "$1" < "$(chezmoi source-path)/ignored/included/dconf$fsConformName.ini"
}

function gnome-settings-backup() {
  _gnome-settings-backup "/org/gnome/shell/"
  _gnome-settings-backup "/org/gnome/desktop/wm/"
  _gnome-settings-backup "/org/gnome/desktop/peripherals/touchpad/"
  _gnome-settings-backup "/org/gnome/desktop/interface/"
  _gnome-settings-backup "/org/gnome/desktop/input-sources/"
  _gnome-settings-backup "/org/gnome/settings-daemon/plugins/media-keys/"
}

function gnome-settings-restore(){
  _gnome-settings-restore "/org/gnome/shell/"
  _gnome-settings-restore "/org/gnome/desktop/wm/"
  _gnome-settings-restore "/org/gnome/desktop/peripherals/touchpad/"
  _gnome-settings-restore "/org/gnome/desktop/interface/"
  _gnome-settings-restore "/org/gnome/desktop/input-sources/"
  _gnome-settings-restore "/org/gnome/settings-daemon/plugins/media-keys/"
}
