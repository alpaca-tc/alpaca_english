# AlpacaEnglish

## About me

このプラグインは英語を話したいけど、話せない!!
OSS開発で外人とチャットするけど難しい、そんな人(僕)用のプラグインです。

## About feature

completefuncで英単語を補完します。僕は英語力が弱いので、日本語訳も一緒に欲しいなとずっと思ってました。
SQLite補完なので、爆速です。

### The English complete(辞書を使った英単語補完)

![english補完](http://cl.ly/image/1l1l0g272I1N/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88%202013-04-21%208.37.39.png)

### Unite 

*english_dictionary(辞書検索)*

![Unite english_dictionary](http://cl.ly/image/3n2u0Z2b0v3S/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88%202013-04-23%2023.38.24.png)

*english_thesaurus(類義語検索)*

![Unite english_thesaurus](http://cl.ly/image/0y3W1s032E35/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88%202013-05-14%201.08.56.png)

*english_example(例文検索)*

![Unite english_example](http://cl.ly/image/1R100f2t3e2m/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88%202013-05-14%201.07.39.png)

### Say

AlpacaEnglishSayコマンドで、選択範囲の文字を音声で読み上げます(MacOnly)

## How to install

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
        \   "mac" : "bundle",
        \   "unix" : "bundle",
        \   "other" : "bundle",
        \ },
        \ 'autoload' : {
        \   'filetypes' : g:my.ft.english_files,
        \   'commands' : ["AlpacaEnglishDisable", "AlpacaEnglishEnable", "AlpacaEnglishSay"],
        \   'unite_sources': ['english_dictionary', 'english_example', 'english_thesaurus'],
        \ }
        \ }
endif

let g:alpaca_english_enable=1
let g:alpaca_english_max_candidates=100
let g:alpaca_english_enable_duplicate_candidates=1

" 補完を有効にするファイルタイプを追加
let g:neocomplcache_text_mode_filetypes = {
  \ 'markdown' : 1,
  \ 'gitcommit' : 1,
  \ 'text' : 1,
  \ }
```

### bundler

このREADMEがあるディレクトリにて`bundle`を実行してください。
`bundle`が無い場合は、`gem install bundler`で先にインストールしてください。

## 実装予定

- 英単語の動的補完(日本語訳つき)(finished)
- 英単語の読み上げ(Mac Only)(finished)
- Uniteを使った単語帳。
    - 検索(日本語、英語両方可能)(finished)
    - 類義語検索(finished)
    - 例文検索(finished)
    - 記録
    - メモ
    - 新規追加
