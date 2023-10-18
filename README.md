# アプリケーション名
- yell

# アプリケーション概要
- 減量失敗による失格」を解決したい「体重管理の必要なアマチュアスポーツ選手」向けの「減量管理アプリ」

# URL
- 作成中

# テスト用アカウント
- 作成中

# 利用方法
- 作成中

# アプリケーションを作成した背景	
- 昨年から格闘技を始めて、試合に出場するようになった。その中で減量があり、自身は減量に成功するも脱水症の様な状態で試合ができるコンディションではなく、又、チームメイトは減量に失敗し失格となったことから、このアプリケーションを開発することとした

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