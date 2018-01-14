FactoryBot.define do
  factory :user do
   sequence (:email) {|n| "teste#{n}@teste.com.br"}
    password '123456' 
  end
end
