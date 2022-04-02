"source ~/scripts/cz-mappings.vim
nmap <F5> :make<CR>
set suffixes+=.aux
set suffixes+=.pdf
set suffixes+=.bbl
set suffixes+=.bcf
set suffixes+=.blg
set suffixes+=.run.xml
set suffixes+=.out
set suffixes+=.log

command Noconceal :set conceallevel=0

autocmd BufRead,BufNewFile *.tex
    \ set spell |
    \ set spelllang=cs |
    \ set spellfile=~/.vim/spell/techspeakC.utf-8.add |
    \ set keywordprg=texdoc |
    \ source ~/scripts/cz-mappings-local.vim

iabbrev Vmetr voltmetr
iabbrev Vmetry voltmetry
iabbrev Vmetru voltmetru
iabbrev Ametr ampérmetr
iabbrev Ametry ampermetry
iabbrev Ametru ampérmetru
iabbrev Mmetr multimetr
iabbrev Mmetry multimetry
iabbrev Mmetru multimetru
iabbrev Wmetr wattmetr
iabbrev Wmetry wattmetry
iabbrev Wmetru wattmetru

iabbrev el. elektrický

iabbrev charka charakteristika
iabbrev charky charakteristiky
iabbrev charku charakteristiku
iabbrev charkou charakteristikou
iabbrev charce charakteristice
iabbrev charek charakteristik
" velka pismena -- zacatek vety
iabbrev Charka Charakteristika
iabbrev Charky Charakteristiky
iabbrev Charku Charakteristiku
iabbrev Charkou Charakteristikou
iabbrev Charce Charakteristice
iabbrev Charek Charakteristik
