# アプリケーション名
- yell (💪→L→エール)

# アプリケーション概要
- 減量失敗による失格」を解決したい「体重管理の必要なアマチュアスポーツ選手」向けの「減量管理アプリ」

# URL
- 作成中

# テスト用アカウント
- email test@gmail.com  
  パスワード 123456

# 利用方法
- ユーザー登録  
  ユーザーはemail、パスワード、ユーザーネームを入力し、登録ボタンを押すことで、ユーザー登録することができる.ユーザー登録後は、トップページに遷移できます
- ログイン・ログアウト  
  emailとパスワードを入力し、ログインボタンを押すことでログイン、ログアウトボタンを押すことでログアウトできます
- 減量情報投稿
  ユーザーは投稿ボタンを選択すると、減量情報投稿ページへ遷移できます。  
  体重（数値）,睡眠（0.5h刻みのプルダウン形式）,疲労度（0~5のプルダウン形式）,運動,食事内容を文章で投稿出来ます
- カレンダー機能
  投稿のある日付には「情報あるよ」が表示され、クリックすると詳細ページに遷移できます
- 減量情報の編集・削除
  ユーザーは詳細画面にて編集ボタンをクリックすると編集画面に遷移します。編集画面で、ユーザーは減量情報を修正します。保存ボタンを押すと、減量情報が更新できます  
  また、削除ボタンで投稿を削除できます  
- コメント機能  
  投稿内容に対しコメントする事ができます
- 投稿者の選択機能  
  トップページで見たい選手をプルダウンで指定して、パスワード入力（ログインパスワードと同じ）する事で投稿一覧が表示されます
- [![Image from Gyazo](https://i.gyazo.com/ea7b0c9b137e4ff30f560fc6a031993f.png)](https://gyazo.com/ea7b0c9b137e4ff30f560fc6a031993f)
- [![Image from Gyazo](https://i.gyazo.com/f0e9206419d807653ca3ced518345cd4.png)](https://gyazo.com/f0e9206419d807653ca3ced518345cd4)
- [![Image from Gyazo](https://i.gyazo.com/90988e3a80ece57f65362ca7eb6dcea3.png)](https://gyazo.com/90988e3a80ece57f65362ca7eb6dcea3)

# 今後実装したい機能
- 体重の増減グラフ
- 投稿時の通知機能

# アプリケーションを作成した背景	
- 昨年から格闘技を始めて、試合に出場するようになった。その中で減量があり、自身は減量に成功するも脱水症の様な状態で試合ができるコンディションではなく、又、チームメイトは減量に失敗し失格となったことから、このアプリケーションを開発することとした  
 このアプリを利用する事で、減量をチームで管理する事ができ、選手は過去の減量方法を確認する、指導者は状況を確認することができる

# 洗い出した要件
- https://docs.google.com/spreadsheets/d/1Pkzu1Bf1MQARXsFftZpDt58O6AoaSiZt/edit#gid=80442722

# DB設計
## usersテーブル

| Column | Type | Option |
|-|-|-|
| id(PK) | integer | null: false |      
| name | string | null: false |
| email | string | null: false, unique: true |
| encrypted_password | string | null: false |

### Association
- has_many :weightlosses
- has_many :comments

## weightlossesテーブル
 Column | Type | Option |
|-|-|-|
| id(PK) | integer | null: false |
| weight | integer  
| sleep | integer | null: false |
| faigue | integer | null: false |
| exercise | text 
| meal | text 
| user | references | null: false |foreign_key: true |


### Association
- belongs_to :user
- has_many :comments

## comments テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| content   | text       | null: false, foreign_key: true |
| weightloss | references | null: false, foreign_key: true |
| user      | references | null: false, foreign_key: true |

- belongs_to :user
- belongs_to :weightloss

# 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/9b05a9a280628d045bb1089a47640c27.png)](https://gyazo.com/9b05a9a280628d045bb1089a47640c27)

# 開発環境
- Ruby/Ruby on Rails/MySQL/Github/Visual Studio Code/HTML&CSS