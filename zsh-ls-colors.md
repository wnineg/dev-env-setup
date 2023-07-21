# Color setup for ls and suggestion list in ZSH

1. Clone the Solarized color theme repository: `git clone https://github.com/seebi/dircolors-solarized.git`.
2. Make a directory for the color theme file reference: `mkdir ~/.dircolors`.
3. Copy the necessary color file: `cp dircolors.256dark ~/.dircolors`.
4. Add a line in `.zshrc` for setting the color theme for `ls`: ``eval `dircolors ~/.dircolors/dircolors.256dark` ``.
5. Add a line in `.zshrc` for setting the color theme for suggestion list: `zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}`.
