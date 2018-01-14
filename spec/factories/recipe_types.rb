FactoryBot.define do
  factory :recipe_type do
   sequence(:name) {|n| "Sobremesa#{n}"}
  end
end
