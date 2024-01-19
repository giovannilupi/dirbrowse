# dirbrowse

Plugin for browsing through the directory stack.
This is a custom version of the `dircycle` plugin for iTerm2 on MacOs.
It can be used on any other system by rebinding keys accordingly.

This plugin enables directory navigation similar to using back and forward on browsers or common file explorers like Finder or Nautilus. It uses a small zle trick that lets you cycle through your directory stack left, right, or up using <kbd>⌥</kbd> + <kbd>Left</kbd> / <kbd>⌥</kbd> + <kbd>Right</kbd> / <kbd>⌥</kbd> + <kbd>Up</kbd>. This is useful when moving back and forth between directories in development environments, and can be thought of as kind of a nondestructive pushd/popd. The current input buffer is preserved when changing directory.

## Enabling the plugin
1. Copy the plugin inside the `$ZSH_CUSTOM/plugins/dirbrowse` direcory.


2. Open your `.zshrc` file and add `dirbrowse` in the plugins section:

   ```zsh
   plugins=(
       # all your enabled plugins
       dirbrowse
   )
   ```

3. Restart the shell or restart your Terminal session:

   ```console
   $ exec zsh
   $
   ```

## Usage Examples

Say you opened these directories on the terminal:

```console
~$ cd Projects
~/Projects$ cd Hacktoberfest
~/Projects/Hacktoberfest$ cd oh-my-zsh
~/Projects/Hacktoberfest/oh-my-zsh$ dirs -v
0       ~/Projects/Hacktoberfest/oh-my-zsh
1       ~/Projects/Hacktoberfest
2       ~/Projects
3       ~
```

By pressing <kbd>⌥</kbd> + <kbd>Left</kbd>, the current working directory or `$CWD` will be changed from `oh-my-zsh` to `Hacktoberfest`. You can press <kbd>⌥</kbd> + <kbd>Up</kbd> to go to the parent directory `Projects`.

And by pressing <kbd>⌥</kbd> + <kbd>Right</kbd>, the `$CWD` will go from `Projects` to `Hacktoberfest`. Press it again and it will be at `oh-my-zsh`.

Here's a example history table with the same accessed directories like above:

| Current `$CWD`  | Key press                                             | New `$CWD`      |
| --------------- | ----------------------------------------------------- | --------------- |
| `oh-my-zsh`     | <kbd>⌥</kbd> + <kbd>Left</kbd>   | `Hacktoberfest` |
| `Hacktoberfest` | <kbd>⌥</kbd> + <kbd>Left</kbd>   | `Projects`      |
| `Projects`      | <kbd>⌥</kbd> + <kbd>Left</kbd>   | `~`             |
| `~`             | <kbd>⌥</kbd> + <kbd>Right</kbd>  | `Projects`      |
| `Projects`      | <kbd>⌥</kbd> + <kbd>Right</kbd>  | `Hacktoberfest` |
| `Hacktoberfest` | <kbd>⌥</kbd> + <kbd>Right</kbd>  | `oh-my-zsh`     |
| `oh-my-zsh`     | <kbd>⌥</kbd> + <kbd>Right</kbd>  | `~`             |

Note the last traversal, when pressing <kbd>⌥</kbd> + <kbd>Right</kbd> on a last known `$CWD`, it will change back to the first known `$CWD`, which in the example is `~`.

Here's an asciinema cast demonstrating the example above:

[![asciicast](https://asciinema.org/a/204406.png)](https://asciinema.org/a/204406)

## Rebinding keys

You can bind these functions to other key sequences, as long as you know the bindkey sequence. This ensures compatibility on other systems. 

You can get the bindkey sequence by pressing <kbd>Ctrl</kbd> + <kbd>V</kbd>, then pressing the keyboard shortcut you want to use. As an alternative, you can use:
```zsh
showkey -a
```
or: 
```zsh
cat -v
```