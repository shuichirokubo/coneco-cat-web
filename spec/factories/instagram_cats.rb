# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :instagram_cat do
    instagram_id 1
    text "MyString"
    image_url "MyString"
    tags "MyString"
    userid 1
    username "MyString"
    userpic "MyString"
  end
end
