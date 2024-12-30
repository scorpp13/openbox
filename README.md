# My config files for Openbox WM

A working configuration of Openbox for Linux Distributions

## Installation

- [ ] Clone git-repo or download and extract it to your $HOME
- `git clone https://gitlab.com/scorpp13/openbox.git`
- [ ] Change to qtile directory
- `cd $HOME/openbox/`
- [ ] Copy folders and files from it to your $HOME
- `cp -r .config .icons .local .themes .vim Pictures .alias .bashrc .dmrc .joyfuld .vimrc $HOME`
- [ ] Install necessary software from list
- `sudo zypper install ...`
- [ ] Reboot your machine
- `sudo reboot`
- { ! } Authorization required, but no authorization protocol specified
    - `uncomment in ~/.bashrc -> xhost +si:localuser:$USER`
- { ! } Set CapsLock to change keyboard layout with led-indicator
    - `sudo localectl --no-convert set-x11-keymap us,ru pc105+inet qwerty grp:caps_toggle,grp_led:caps`
- { ! } Reboot your machine
    - `sudo reboot`
- [ ] Enjoy
- `^;^`
