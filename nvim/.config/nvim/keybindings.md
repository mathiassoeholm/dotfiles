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
  - a - New file
  - c - Copy
  - x - Cut
  - p - Paste
  - d - Delete
  - r - Rename

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

## Special

- C-t - Toggle terminal
