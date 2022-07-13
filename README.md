

## ---
## open shell in chezmoi folder
chezmoi cd

## change dotfiles
code .

## apply changes
chezmoi apply
## ---

https://www.chezmoi.io/docs/quick-start/

## checkout on new machine

```
chezmoi init git@github.com:irgendwer92/chezmoi-dotfiles
chezmoi apply
```

## pull changes

```
chezmoi update
```

## make changes

auto-commit and auto-push is enabled in chezmoi!

```
chezmoiz edit ~/.zshrc
chezmoi diff
chezmoi -v apply
chezmoi git status/add/commit

```



## if oh-my-zsh themes don't work on arch

uninstall grml-zsh-config `yay -Rncs grml-zsh-config`
