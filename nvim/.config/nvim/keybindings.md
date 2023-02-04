# Keybindings

All <leader> references are the same as `s`.

## Vim

- W - Jump to next whitespace
- B - Jump to previous whitespace
- E - Jump to before next whitespace
- gv - Select previous selection
- ds( - Delete surrounding parentheses
- cs"' - Change surrounding " to '
- ysiw( - Add surrounding characters in word
- fa - Jump to next occurence of a
  - ;|f - Jump to next occurence
  - , - Jump to previous occurence
- S" - Surround selection with "
- zz - Center on cursor

## File Navigation

- C-n - Open File Explorer
  - k|j - Navigate up/down
  - o - Open selection
  - a - New file, or directory if ending with /
  - c - Copy
  - x - Cut
  - p - Paste
  - d - Delete
  - r - Rename
  - Tab - Preview

## Search

- C-p - Fuzzy search file
- C-f - Fuzzy search in buffer
- S-f - Fuzzy search in the whole project
- C-b - Open last search
- s - Lightspeed search
- :noh - Clear search buffer

## Buffers

- S + h and S + l: move to buffer to the left or right.
- <leader>q - close current buffer
- <leader>z - save all buffers

## Splits and tabs

- :vs - Vertical split
- C-h(j|k|l) - Move between splits
- :tabnew - Make a new tab
- :tabclose - Close the tab
- gt - Switch tabs

## Code actions

- K - open documentation for hovered line.
- <leader>f - format current buffer
- <leader>rf - Smart rename file
- <leader>oi - Organize imports
- <leader>ru - Remove unused
- <leader>a - Show code actions for hover
- <leader>rn - Smart rename at cursor

## Code navigation

- gd - open definition of cursor in popup window with editing. `q` to exit.
- C-] - Go to definition
- gr - show definition and references.

## Diagnostics

- <leader>d - show error for current line.
- ( or ) jump to previous or next diagnostic in current buffer.

## Telescope
- C-x - Go to file selection as a horizontal split
- C-v - Go to file selection as a vertical split

## Special

- C-t - Toggle terminal

## Amethyst

Default Shortcut Description
mod1 option + shift
mod2 ctrl + option + shift
And defines the following commands, mostly a mapping to xmonad key combinations.

Default Shortcut Description
mod1 + space Cycle layout forward
mod2 + space Cycle layout backwards
mod1 + h Shrink the main pane
mod1 + l Expand the main pane
mod1 + , Increase main pane count
mod1 + . Decrease main pane count
mod1 + j Move focus counter clockwise
mod1 + k Move focus clockwise
mod1 + p Move focus to counter clockwise screen
mod1 + n Move focus to clockwise screen
mod2 + h Swap focused window to counter clockwise screen
mod2 + l Swap focused window to clockwise screen
mod2 + j Swap focused window counter clockwise
mod2 + k Swap focused window clockwise
mod1 + enter Swap focused window with main window
mod1 + z Force windows to be reevaluated
mod2 + z Relaunch Amethyst
mod2 + left Throw focused window to space left
mod2 + right Throw focused window to space right
mod2 + 1 Throw focused window to space 1
mod1 + w Focus Screen 1
mod2 + w Throw focused window to screen 1
mod1 + e Focus Screen 2
mod2 + e Throw focused window to screen 2
mod1 + r Focus Screen 3
mod2 + r Throw focused window to screen 3
mod1 + q Focus Screen 4
mod2 + q Throw focused window to screen 4
mod1 + t Toggle float for focused window
mod1 + i Display current layout
mod2 + t Toggle global tiling
mod1 + a Select tall layout
none Select tall-right layout
mod1 + s Select wide layout
none Select middle-wide layout
mod1 + d Select fullscreen layout
mod1 + f Select column layout
none Select row layout
none Select floating layout
none Select widescreen-tall layout
none Select bsp layout
