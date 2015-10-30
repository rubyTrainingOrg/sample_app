Factory.define :user do |user|
  user.nom                  "example user"
  user.email                 "email@example.com"
  user.password              "example password"
  user.password_confirmation "example password"
end