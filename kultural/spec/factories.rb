FactoryGirl.define do
  factory :user do
    name 'Napoleon Bonaparte'
    mail 'napoleon@bonaparte.fr'
    phone 17691821
    birthday Date.strptime('15/08/1769', '%d/%m/%Y')
    male true
    password 'Austerlitz'
    password_confirmation 'Austerlitz'
  end

  factory :group do
    name 'Illuminatis'
    description 'Uníos'
    user
  end
end
