

https://www.chezmoi.io/docs/quick-start/

## checkout on new machine

```
chezmoi init git@github.com:erdii/chezmoi-dotfiles
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
