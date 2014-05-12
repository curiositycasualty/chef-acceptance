require 'faker'

class Org
  attr_accessor :name, :full_name
end

class User
  attr_accessor :name, :username, :password, :email, :company
end

class Role
  attr_accessor :name, :description
end

FactoryGirl.define do
  factory :org do
    name { "#{Faker::Internet.domain_word}" }
    full_name { "#{name}, #{Faker::Company.suffix}" }
  end

  factory :user do
    name Faker::Name.name
    username Faker::Internet.user_name
    password 'passwd'
    email Faker::Internet.email(username)
    company Faker::Company.name

    trait :username do
      Faker::Internet.user_name
    end
  end

  factory :role do
    sequence(:name) { |n| "role#{n}" }
    description Faker::Lorem.sentence
  end
end
