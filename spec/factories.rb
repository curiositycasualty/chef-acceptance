class Org
  attr_accessor :id, :name, :full_name
end

class Login
  attr_accessor :username, :password
end

class Role
  attr_accessor :name, :description
end

FactoryGirl.define do
  factory :org do
    id { Time.now.to_i.to_s }
    full_name { "Test Org #{id}" }
    name { "org#{id}" }
  end

  factory :chef_login, class: Login do
    username 'chef'
    password 'password'
  end

  factory :role do
    sequence(:name) { |n| "role#{n}" }
    description ''
  end
end

