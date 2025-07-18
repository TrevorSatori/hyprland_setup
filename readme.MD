# Dotfiles

1. config files folder is used for app specific configs. Move these to ~/.config

2. arch-setup is ansible script to auto deploy setup after basic install

### Automated setup

1. Install Git, Ansible, and Neovim if not already installed

```sh
sudo pacman -S neovim git
```

2. add passwordless sudo temporarily

```sh
sudo visudo
```
- add line "username ALL=(ALL) NOPASSWD: ALL 

3. run ansible script

```sh
ansible-playbook arch-setup.yml
```

4. if any errors after switching to zsh, just reboot. I know there's more efficient way but fuggit.

### After Install

- After installing you will need to set a theme (alt + shift + t)

- To get matching resolution to monitor run the following and update hyprland.conf

```sh
hyprctl monitors
```

5. Lastly move the *menu.rasi* from the rofi config folder to usr/share/rofi/themes
