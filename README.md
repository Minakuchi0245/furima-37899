# テーブル設計

## usersテーブル

| Column              | Type      | Options                        |
| ------------------- | --------- | ------------------------------ |
| nickname            | string    | null: false, unique: true      |
| email               | string    | null: false, unique: true      |
| encrypted_password  | string    | null: false                    |
| last_name           | string    | null: false                    |
| first_name          | string    | null: false                    |
| last_name_kana      | string    | null: false                    |
| first_name_kana     | string    | null: false                    |
| birth_date    　　　 | string    | null: false                    |



## itemsテーブル

| Column              | Type      | Options                        |
| ------------------- | --------- | ------------------------------ |
| item_name           | string    | null: false                    |
| item_instruction    | text      | null: false                    |
| category            | string    | null: false                    |
| condition           | string    | null: false                    |
| shipping_fee_bearer | string    | null: false                    |
| shipping_area       | string    | null: false                    |
| shipping_days       | string    | null: false                    |
| user                | reference | null: fales,foreign_key: true  |



## purchasesテーブル

| Column              | Type      | Options                        |
| ------------------- | --------- | ------------------------------ |
| user                | reference | null: fales,foreign_key: true  |
| item                | reference | null: fales,foreign_key: true  |
| shipping            | reference | null: fales,foreign_key: true  |




## shippingsテーブル

| Column              | Type      | Options                        |
| ------------------- | --------- | ------------------------------ |
| postal_code         | string    | null: false                    |
| prefectures         | string    | null: fales,                   |
| city                | string    | null: fales,                   |
| address             | string    | null: false                    |
| building_name       | string    | null: false                    |
| telephone           | string    | null: false                    |
