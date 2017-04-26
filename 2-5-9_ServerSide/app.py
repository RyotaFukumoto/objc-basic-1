import os

# Flask などの必要なライブラリをインポートする
from flask import Flask, render_template, request, redirect, url_for

#apns
import time
from apns.apns import APNs, Frame, Payload

import subprocess

# 自身の名称を app という名前でインスタンス化する
app = Flask(__name__)

# ここからウェブアプリケーション用のルーティングを記述
# index にアクセスしたときの処理
@app.route('/')
def index():
    title = "プッシュ通知送信画面"
    message = "デバイスIDとOSを指定してください"
    
    os = ['Select one', 'iOS', 'android']
    
    return render_template('index.html',
                           message=message, os=os,title=title)

@app.route('/training/training/push/')
def pushPage():
    title = "プッシュ通知送信画面"
    message = "デバイスIDとOSを指定してください"
    
    os = ['Select one', 'iOS', 'android']
    
    return render_template('index.html',
                           message=message, os=os,title=title)

# /post にアクセスしたときの処理
@app.route('/post', methods=['GET', 'POST'])
def post():
    title = "プッシュ通知を送信しました"
    if request.method == 'POST':
        # リクエストフォームからdevice IDを取得
        device_id = request.form['device_id']
       
        #プッシュ通知を送信
        sendPushNotification()
        
        return render_template('didSend.html',
                               device_id=device_id, title=title)
    else:
        # エラーなどでリダイレクトしたい場合
        return redirect(url_for('index'))

"""
https://github.com/djacobs/PyAPNs を参照のこと
"""
def sendPushNotification():
    apns = APNs(use_sandbox=True, cert_file='server_certificates_sandbox.pem', key_file='pushKey.pem')
    
    # Send an iOS 10 compatible notification
    token_hex = 'device_token'
    payload = Payload(alert="Hello World! This notification is send via flask.", sound="default", badge=1, mutable_content=True)
    apns.gateway_server.send_notification(token_hex, payload)
         
# テストページ
@app.route('/test')
def test():
    title = "テスト"
    message = "これはテストです。"    

    return render_template('test.html',
                           message=message)


                           
if __name__ == '__main__':
    app.debug = True # デバッグモード有効化
    app.run(host='0.0.0.0', port = 80) # どこからでもアクセス可能に
