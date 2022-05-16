# テーブル設計

## usersテーブル

| Column                | Type      | Options                        |
| --------------------- | --------- | ------------------------------ |
| nickname              | string    | null: false, unique: true      |
| email                 | string    | null: false, unique: true      |
| encrypted_password    | string    | null: false                    |
| last_name             | string    | null: false                    |
| first_name            | string    | null: false                    |
| last_name_kana        | string    | null: false                    |
| first_name_kana       | string    | null: false                    |
| birth_date            | date      | null: false                    |

## アソシエーション

| method                | model          |
| --------------------- | -------------- |
| has_many              | items          |
| has_many              | purchases      |




## itemsテーブル

| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| item_name             | string      | null: false                    |
| item_instruction      | text        | null: false                    |
| category_id           | integer     | null: false                    |
| condition_id          | integer     | null: false                    |
| shipping_charge_id    | integer     | null: false                    |
| shipping_area_id      | integer     | null: false                    |
| shipping_days_id      | integer     | null: false                    |
| price                 | integer     | null: false                    |
| user                  | references  | null: false,foreign_key: true  |

## アソシエーション

| method                | model          |
| --------------------- | -------------- |
| belongs_to            | user           |
| has_one               | purchase       |




## purchasesテーブル

| Column                | Type       | Options                        |
| --------------------- | ---------- | ------------------------------ |
| user                  | references | null: false,foreign_key: true  |
| item                  | references | null: false,foreign_key: true  |

## アソシエーション

| method                | model          |
| --------------------- | -------------- |
| belongs_to            | user           |
| belongs_to            | item           |
| has_one               | shipping       |




## shippingsテーブル

| Column                | Type       | Options                        |
| --------------------- | ---------- | ------------------------------ |
| postal_code           | string     | null: false                    |
| prefectures_id        | integer    | null: false,                   |
| city                  | string     | null: false,                   |
| address               | string     | null: false                    |
| building_name         | string     |                                |
| telephone             | string     | null: false                    |
| purchase              | references | null: false,foreign_key: true  |

## アソシエーション

| method                | model          |
| --------------------- | -------------- |
| belongs_to            | purchase       |