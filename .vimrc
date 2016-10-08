" Turns syntax-highlighting on.
syntax on

" Highlights text that matches what the Vim user searches for.
:set hlsearch

" Maps <F12> to switch between a light color scheme and a dark color scheme.
" map <F12> execute 'colorscheme ron'

" Creates a highlight group, which will be used for highlighting characters that
" are close to the end of the acceptable line length.
:highlight CloseToTheAcceptableLineLength cterm=underline

" Creates a highlight group, which will be used for highlighting characters past
" the acceptable line length.
:highlight PastTheAcceptableLineLength ctermbg=LightRed ctermfg=black

:function! ApplyHighlights()
"   Makes the characters from character 75 to 80 on a line be highlighted using
"   a particular highlight group.
"   \%75v - Start matching at the 75th virtual column (1-based counting).
"   .+ - Select 1 or more characters.
"   \%<81v - End matching before the 81st virtual column (1-based counting).
"   It's necessary to match before the virtual column, instead of at the virtual
"   column, because otherwise if the specified virtual column doesn't exist,
"   nothing will be matched. Hence the (\%81v), instead of (\%80v).
"   . - Select 1 character (this makes the character in the 80th virtual column
"   be selected.
:   let closeToTheAcceptableLineLength = matchadd(
\                                           'CloseToTheAcceptableLineLength',
\                                           '\%75v.*\%<81v.'
\                                        )

"   Makes all characters from character 81 onwards on a line be highlighted
"   using a particular highlight group.
"   \%81v - Start matching at the 81st virtual column (1-based counting).
"   .\+ - Select 1 or more characters.
:   let pastTheAcceptableLineLength = matchadd(
\                                           'PastTheAcceptableLineLength',
\                                           '\%81v.\+'
\                                     )
:endfunction

:call ApplyHighlights()

" This doesn't yet work.
" Reapply highlights whenever the Color Scheme is changed in Vim.
:augroup ApplyHighlights
:   autocmd!
:   autocmd ColorScheme * :call ApplyHighlights()
:augroup END

" Automatically makes any new line be indented as much as the line before it.
:set autoindent

" Stops Vim from removing white-space on a line that hasn't been modified after
" having been created, once the user creates another line, or goes into normal
" mode. Copied from: http://stackoverflow.com/a/7413117
inoremap <CR> <CR>x<BS>
nnoremap o ox<BS>
nnoremap O Ox<BS>

" Sets the number of columns that a tab character will take up, to 4.
" This affects tab characters that were already in the file at the time it was
" opened, as well as newly-added tab characters.
:set tabstop=4

" Map Shift-Tab to Control-V of Tab character, to insert a tab character without
" it being converted to spaces.
inoremap <S-Tab> <C-V><Tab>

" Makes it so that when just the tab key is pressed (so not when Shift-Tab is
" pressed) whilst in insert more, spaces will be inserted instead of a tab
" character.
:set expandtab

" Sets the number of spaces that will be inserted when just the tab key is
" pressed (so not when Shift-Tab is pressed) whilst in insert mode, to 4.
:set softtabstop=4

" Removes or inserts 4 spaces when the < key or > key is pressed respectively,
" whilst in visual mode.
:set shiftwidth=4

