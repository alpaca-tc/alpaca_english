# AlpacaEnglish

このプラグインは、英語を話したいけど話せない!
OSS開発で外人とチャットするけど難しい。
そんな人(僕)用のプラグインです。

## 機能

completefuncで英単語を補完します。僕は英語力が弱いので、日本語訳も一緒に欲しいなとずっと思ってました。

### 英語補完(辞書を使った英単語補完)

![english補完](http://cl.ly/image/1l1l0g272I1N/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88%202013-04-21%208.37.39.png)

### Unite

*english_dictionary(辞書検索)*

![Unite english_dictionary](http://cl.ly/image/3n2u0Z2b0v3S/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88%202013-04-23%2023.38.24.png)

*english_thesaurus(類義語検索)*

![Unite english_thesaurus](http://cl.ly/image/0y3W1s032E35/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88%202013-05-14%201.08.56.png)

*english_example(例文検索)*

![Unite english_example](http://cl.ly/image/1R100f2t3e2m/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88%202013-05-14%201.07.39.png)

### Say

`AlpacaEnglishSay`コマンドは、選択範囲の文字を音声で読み上げます(MacOnly)

## インストール

vim
======
vim: +ruby +ruby/dry
ruby: 2.0.0
gem: json, sqlite3

`:ruby p RUBY_DESCRIPTION`でRubyのバージョンを確認出来ます

### vimrc

```vim
if has("ruby")
  NeoBundle 'taichouchou2/alpaca_english', {
        \ 'rev' : 'development',
        \ 'build' : {
        \   'mac' : 'bundle',
        \   'unix' : 'bundle',
        \   'other' : 'bundle',
        \ },
        \ 'autoload' : {
        \   'filetypes' : ['markdown', 'text'],
        \   'commands' : ['AlpacaEnglishDisable', 'AlpacaEnglishEnable', 'AlpacaEnglishSay'],
        \   'unite_sources': ['english_dictionary', 'english_example', 'english_thesaurus'],
        \ }
        \ }
endif

" 有効にする
let g:alpaca_english_enable = 1
" let b:alpaca_english_enable = 1 " Buffer内のみ有効
" SQL検索のLIMITを設定
let g:alpaca_english_max_candidates = 100
" Buffer補完などで、既に候補がある場合も英語の候補を表示する
let g:alpaca_english_enable_duplicate_candidates = 1

" ---
" NeoComplete / NeoComplcacheを使う場合の設定

" 補完を有効にするファイルタイプを追加
let g:neocomplcache_text_mode_filetypes = {
  \ 'markdown' : 1,
  \ 'gitcommit' : 1,
  \ 'text' : 1,
  \ }
let g:neocomplete#text_mode_filetypes = g:neocomplcache_text_mode_filetypes


" ---
" Completefuncを使う場合の設定
augroup MyAutoCmd
  autocmd!
  autocmd FileType markdown,text setl completefunc=alpaca_english#completefunc
augroup END
```

### bundler

このREADMEがあるディレクトリにて`bundle`を実行してください。
`bundle`が無い場合は、`gem install bundler`で先にインストールしてください。

```sh
$ cd /path/to/alpaca_english
$ gem install bundler
$ bundle
```

## License

The MIT License (MIT)

Copyright (c) <2014> <Ishii Hiroyuki>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
