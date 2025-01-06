# Dotfiles Repository
This repository contains all my dotfiles required to setup my personal dev environment on different machines. *This can only be used on mac or linux machines*.

## Getting Started
To start you must have the pre-requisites below fullfilled.

### Pre-requisites
1. Zsh must be your default shell.
2. You have sudo/admin permissions on the machine to be installed on.
3. You have file/folder permissions for homebrew if your using a shared account ie. the account your using to login to your machine is not the only account on the machine.

### Getting Started
To start the installation process run the following commands below in sequence
1. This first script symlinks the following config files for it to work, I suggest backing up the files below before running the bash script if they are existing in the system to prevent loss of machine specific configurations.
    1. `~/.zshrc`
    2. `~/.p10k.zsh`
    3. `~/.wezterm.lua`
```bash
./01_setup_zshrc.sh
```
2. The second script is responsible for installing the following required developer tools and package managers used by this configuration. The following items will be installed.
    1. `homebrew` - preferred package manager, can be replaced however have to change all the downstream scripts.
    2. `zinit` - zsh package manager to install zsh specific plugins
    3. `git` - git plugin for git transactions
    4. `nvim` - prerferred text editor/IDE
    5. `wezterm` - preferred terminal emulator
    6. `font-meslo-lg-nerd-font` - preferred fonts to be used by the entire config
    7. `font-jetbrains-mono-nerd-font` - alternative font to be used by the entire config
    8. `btop` - terminal based system performance monitoring tool
    9. `docker` - containerization plugin to be used in development workflow
    10. `yazi` - rust based file manager based in the terminal with nvim like configurations
```bash
./02_install_required_apps.sh
```
3. The third script is used to symlink all the configs used by applications installed from the previous step.
```bash
./03_setup_symlinks.sh
```
4. The fourth and final script is used to install other smaller plugins thats being used by my nvim config.
```bash
./04_setup_nvim.sh
```
### Setting-up multiple git ssh keys separated by directory
This step is necessary if you want to mix your personal projects with your work projects. This will allow you to seamlessly switch between git ssh keys depending on which directory you're currently in.
1. Create a root `.gitconfig` in your root folder with the content below. Replace email and name depending on your use case. *Note that includeif section*. The includeif section adds another `.gitconfig` configuration on your root git config depending on what directory you're in. You can change the `gitdir` values to what works for you.
```bash
[user]
    email = your_personal_email@example.com
    name = Personal Name

[includeIf "gitdir:~/Desktop/work/"]
  path = ~/Desktop/work/.gitconfig
```
2. Create another `.gitconfig` file with the content below in the directory you supplied in the first step for the includeIf section.
```bash
[user]
  email = workemail@workdomainexample.com
  name = Work Name
```
3. Create your `ssh-keys` in the `~/.ssh` folder using the commands below
```bash
ssh-keygen -t ed25519 -C "your_personal_email@example.com"
ssh-keygen -t ed25519 -C "workemail@workdomainexample.com"
```
4. Create a config file using the command `touch config` in the `~/.ssh` folder with the content below. *Note the $PWD section*. This working directory should match the directory used in the includeIf section in step 1.
```bash
Match host github.com exec "[[ $PWD == */work* ]]"
    IdentityFile ~/.ssh/id_ed25519_work

Host github.com
    IdentityFile ~/.ssh/id_ed25519
```
5. Verify that the setup is successful by cloning repositories in the `personal` and `work` directories and see if the configuration worked.
