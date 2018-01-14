FactoryBot.define do
  factory :cuisine do
   sequence(:name) {|n| "Brasileira#{n}"}
  end
end
