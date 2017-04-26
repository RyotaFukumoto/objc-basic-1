ポート番号を入れなくていいようにするために、`app.py`の中で

```
if __name__ == '__main__':
    app.debug = True # デバッグモード有効化
    app.run(host='0.0.0.0', port = 80) # どこからでもアクセス可能に
```

としている。なので、起動時に
`sudo python3 app.py`
と頭に`sudo`をつけるようにする。