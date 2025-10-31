# frozen_string_literal: true

FactoryBot.define do
  factory :spina_user, class: Spina::User do
    name             { 'Bram' }
    sequence(:email) { |n| "bram#{n}@denkgroot.com" }
    password         { 'password' }
    password_confirmation { password }
    admin { true }
  end
end
