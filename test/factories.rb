Factory.define :user do |user|
  user.sequence(:login) {|n| "loginname_#{n}"}
  user.password 'test'
  user.password_confirmation 'test'
end

Factory.define :topic do |topic|
  topic.sequence(:name) {|n| "name_#{n}" }
  topic.user { Factory(:user)}
end

Factory.define :property_type do |ptype|
  ptype.name 'Date Seen'
  ptype.type_name 'DateProperty'
end