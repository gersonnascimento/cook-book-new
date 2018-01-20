FactoryBot.define do
  factory :recipe do
    sequence(:title) {|n| "Bolo de banana#{n}"}
    difficulty 'Fácil'
    cook_time 60
    ingredients 'banana e farinha'
    add_attribute(:method) { 'Misturar tudo e levar ao forno' }
    cuisine
    recipe_type
    user
    picture { File.new("#{Rails.root}/spec/support/fixtures/imagemteste.png") }
  end
end
