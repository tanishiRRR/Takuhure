# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'hogehoge@admin',
  password: 'hogehoge@admin'
)

EndUser.create!(
  [
    {
      email: 'alice@example.com',
      password: 'alice@example.com',
      account_name: 'Alice',
      is_study: 1,
      exam_date: '2022/10/16',
      is_deleted: false
    },
    {
      email: 'bob@example.com',
      password: 'bob@example.com',
      account_name: 'Bob',
      is_study: 1,
      exam_date: '2022/10/16',
      is_deleted: true
    },
    {
      email: 'carol@example.com',
      password: 'carol@example.com',
      account_name: 'Carol',
      is_study: 0,
      exam_date: '2023/10/15',
      is_deleted: false
    }
  ]
)

Category.create!(
  [
    {
      category_name: '権利関係'
    },
    {
      category_name: '税・価格'
    },
    {
      category_name: '宅建業法'
    },
    {
      category_name: '法令上の制限'
    },
    {
      category_name: '免除科目'
    }
  ]
)