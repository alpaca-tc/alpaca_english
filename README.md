# AlpacaEnglish

## About me

このプラグインは英語を話したいけど、話せない!!
OSS開発で外人とチャットするけど難しい、そんな人(僕)用のプラグインです。

## About feature

completefuncで英単語を補完します。僕は英語力が弱いので、日本語訳も一緒に欲しいなとずっと思ってました。
SQLite補完なので、爆速です。

The English complete

![english補完](http://cl.ly/image/1l1l0g272I1N/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88%202013-04-21%208.37.39.png)

Unite english

![Unite english](http://cl.ly/image/3n2u0Z2b0v3S/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88%202013-04-23%2023.38.24.png)

## How to install

vim
======
vim: +ruby +ruby/dry
ruby: < 1.9.7
gem: json, sqlite3

`:ruby p RUBY_DESCRIPTION`でRubyのバージョンを確認出来ます

### vimrc

```vim
NeoBundle 'taichouchou2/alpaca_english', {
    \ 'rev' : 'development',
    \ }

let g:alpaca_english_enable=1

" 補完を有効にするファイルタイプを追加
let g:neocomplcache_text_mode_filetypes = {
  \ 'markdown' : 1,
  \ 'gitcommit' : 1,
  \ 'text' : 1,
  \ }
```

## 実装予定

- 英単語の動的補完(日本語訳つき)(finished)
- 英単語の読み上げ(Mac Only)(finished)
- Uniteを使った単語帳。
    - 検索(finished)
    - 記録
    - メモ
    - 新規追加
