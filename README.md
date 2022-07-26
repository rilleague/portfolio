# README

## usersテーブル
| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false, unique: true |
| email              | string  | null: false               |
| age_id             | integer |                           |
| avatar             | string  |                           |
| introduction       | text    |                           |
| encrypted_password | string  | null: false               |

### association
- has_many :posts
- has_many :comments
- has_many :favorites
<!-- - has_many :relationships
- has_many :followings, through: :relationships, source: :follow
- has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
- has_many :followers, through: :reverse_of_relationships, source: :user  -->




## postsテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| title              | string     | null: false                    |
| images             | string     |                                |
| category_id        | integer    | null: false                    |
| part_id            | integer    |                                |
| skin_id            | integer    |                                |
| detail             | text       | null: false                    |
| user               | references | null: false, foreign_key: true |

### association
- belongs_to :user
- mount_uploaders :images, ImageUploader
- belongs_to :category
- belongs_to :part
- belongs_to :skin
- has_many   :tags, through: :post_tags
- has_many   :post_tags, dependent: :destroy
<!-- - has_many   :favorites -->
- has_many   :comments
<!-- - has_many   :favorites  -->




## commentsテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| content            | text       | null: false                    |
| post               | references | null: false, foreign_key: true |
| user               | references | null: false, foreign_key: true |

### association
- belongs_to :user
- belongs_to :post


## tagsテーブル
| Column             | Type       | Options                         |
| ------------------ | ---------- | ------------------------------- |
| tagname            | string     |                                 |

### association
- has_many   :posts, through: :post_tags
- has_many   :post_tags, dependent: :destroy


## post_tagsテーブル
| Column             | Type       | Options                         |
| ------------------ | ---------- | ------------------------------- |
| post               | references | null: false, foreign_key: true  |
| tag                | references | null: false, foreign_key: true  |

### association
- belongs_to :post
- belongs_to :tag 



## favoritesテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | null: false, foreign_key: true |
| post               | references | null: false, foreign_key: true |

### association
- belongs_to :user
- belongs_to :post



<!-- ## relationshipsテーブル
| Column             | Type          | Options                                        
| ------------------ | ------------- | ---------------------------------------------- 
| user               | references    | null: false, foreign_key: true, unique: true   
| follow             | references    | null: false, foreign_key: { to_table: :users } 

### association
- belongs_to :user
- belongs_to :follow, class_name: 'User'  -->
