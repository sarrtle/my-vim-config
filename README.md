# Uses NvChad distribution

> [!TIP]
> **for Linux** <br/>
> `git clone https://github.com/sarrtle/my-vim-config.git .config/nvim`<br/>
> **for windows** <br/>
> `git clone https://github.com/sarrtle/my-vim-config.git appdata/local/nvim`
> - open your terminal and run `nvim`
> - wait for it to install then run `:Mason`
> - wait for it to load and run `:MasonInstallAll` this will install the plugins
> - If there is some missing plugins like **lua-language-server**, you can install it manually with `:MasonInstall lua-language-server`

### Python plugins
- pyright, mypy, pylint, black
### Web development plugins
- typescript-language-server, tailwindcss-language-server, prettierd, emmet-language-server

### Notes and features
1. **Mypy cache disabled**: performance is not really noticeable, I just hate how mypy cache always created on my project directory.
2. **Pyright diagnostics is disabled**: since it is annoying to have duplicates info from mypy, pylint and pyright. Pyright is for auto completion only.
3. **Auto close tags on react html**: whenever you write any html tags, it will be automatically close. `<p>This is a paragraph</p>`
4. **Auto formatting**: By following code writing standard, your code will be automatically clean from bad writing. Both python and Web development works.

### To fix in the future
- pylint is slow, use ruff instead but the current none-ls doesn't seem to have ruff yet from their builtins.
- jedi-language-server doesn't support curoutine or async related-function on returning autocompletion, it always shows as normal function. This info might be useful if you are planning to use jedi-language-server. Use pyright instead.
- use lazyvim instead, nvchad offers simple and easy setup but hard to configure. With lazyvim, we can configure it from lower level as far as I know. But nvchad is becoming more better and providing easy configurations for beginners who wants to use some plugins.

### Images
python
![240425_02h07m17s_screenshot](https://github.com/sarrtle/my-vim-config/assets/163162322/12096f55-3aad-49e0-a6be-5ba9df41824f)
react
![240425_02h31m37s_screenshot](https://github.com/sarrtle/my-vim-config/assets/163162322/b950c2c5-dba6-46b8-9cf4-5b9b31717651)
tailwind
![240425_02h32m15s_screenshot](https://github.com/sarrtle/my-vim-config/assets/163162322/2a795403-0917-49fc-8b5f-689beb97f810)
