<img width="600px" src="https://i.ibb.co/gdr0m1v/2025-01-18-14-32.png"/>

# My config files for Openbox

Liteweight openSUSE_Tumbleweed with openbox onboard

## Installation

- [ ] Clone git-repo or download and extract it to your $HOME
- `git clone https://gitlab.com/scorpp13/openbox.git`
- [ ] Change to openbox directory
- `cd $HOME/openbox/`
- [ ] Copy files and folders from it to your $HOME
- `cp -r .config .icons .local .themes .vim Pictures .alias .bashrc .dmrc .vimrc $HOME`
- [ ] Install necessary software from list
- `sudo zypper install ...`
- [ ] Reboot your machine
- `sudo reboot`
- <!> Authorization required, but no authorization protocol specified
    - `uncomment in ~/.bashrc -> xhost +si:localuser:$USER`
- <!> Set CapsLock to change keyboard layout with led-indicator
    - `sudo localectl --no-convert set-x11-keymap us,ru pc105+inet qwerty grp:caps_toggle,grp_led:caps`
- <!> Reboot your machine
    - `sudo reboot`
- [ ] Enjoy
- `^;^`
