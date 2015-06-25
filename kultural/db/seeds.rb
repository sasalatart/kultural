require 'faker'

puts('Creating event types')

event_types_list = [
  ['Sightseeing', 'Visiting places of interest in a particular location.'],
  ['Outdoor Recreation', 'Leisure pursuits engaged in the outdoors, often in natural or semi-natural settings out of town.'],
  ['Arts & Heritage', 'Arts... and Heritage'],
  ['Dining & Nightlife', 'Events where you can eat and spend your time at night.'],
  ['Shops & Fairs', 'Events where you can buy stuff...'],
  ['Music', 'Listen to it :)']
]

event_types_list.each do |name, examples|
  EventType.create!(name: name, examples: examples)
end

puts('Creating users')

jaime = User.create!(name:                 'Jaime Castro R',
                     password:              'macoy123',
                     password_confirmation: 'macoy123',
                     mail:                  'jecastro1@uc.cl',
                     phone:                 Faker::PhoneNumber.cell_phone,
                     birthday:              Date.strptime('31/12/1994', '%d/%m/%Y'),
                     male:                  true)

sebas = User.create!(name:                  'Sebastian Salata R-T',
                     password:              'napoleon',
                     password_confirmation: 'napoleon',
                     mail:                  'sasalata@uc.cl',
                     phone:                 Faker::PhoneNumber.cell_phone,
                     birthday:              Date.strptime('16/04/1992', '%d/%m/%Y'),
                     male:                  true)

vicen = User.create!(name:                  'Vicente Dragicevic H',
                     password:              'ilovethiscompany',
                     password_confirmation: 'ilovethiscompany',
                     mail:                  'vrdragicevic@uc.cl',
                     phone:                 Faker::PhoneNumber.cell_phone,
                     birthday:              Date.strptime('11/11/1993', '%d/%m/%Y'),
                     male:                  true)

64.times do
  name      = "#{Faker::Name.first_name} #{Faker::Name.last_name}"
  password  = Faker::Internet.password(10, 20)

  User.create!(name:                  name,
               mail:                  "#{name.gsub(/[^A-Za-z]/, '')}@example.com",
               password:              password,
               password_confirmation: password,
               phone:                 Faker::PhoneNumber.cell_phone,
               birthday:              Faker::Date.between(100.years.ago, 10.years.ago))
end

puts('Creating groups')

32.times do
  Group.create!(name:        Faker::App.name,
                description: Faker::Lorem.paragraph)
end

puts('Filling groups')

Group.all.each do |group|
  user_list = User.order('RANDOM()')
  number_of_members = Random.new.rand(2..8)

  number_of_members.times do |i|
    Membership.create!(user: user_list[i], group: group, is_admin: true) if i == 0
    Membership.create!(user: user_list[i], group: group, is_admin: false) if i != 0
  end
end

puts('Creating places')

jaime.places.create!(name:         'Sala Javier Pinto',
                     address:      'Vicuña Mackenna 4860',
                     description:  Faker::Lorem.paragraph)

jaime.places.create!(name:         'Pontificia Universidad Católica de Chile',
                     address:      'Avenida Libertador Bernardo O Higgins 340',
                     description:  Faker::Lorem.paragraph)

sebas.places.create!(name:         'Estadio San Carlos de Apoquindo',
                     address:      'Av. Las Flores 13000',
                     description:  Faker::Lorem.paragraph)

vicen.places.create!(name:         'Chuck E. Cheese´s',
                     address:      'Presidente Riesco 5711 Of. 1403',
                     description:  Faker::Lorem.paragraph)

vicen.places.create!(name:         'Plaza Baquedano',
                     address:      'Avenida Libertador Bernardo O Higgins',
                     description:  Faker::Lorem.paragraph)

puts('Creating events')

32.times do
  Event.create!(owner:       User.order('RANDOM()').first,
                place:       Place.order('RANDOM()').first,
                name:        Faker::Lorem.words(rand(2..4)).map(&:capitalize).join(' '),
                description: Faker::Lorem.paragraph,
                date:        Faker::Date.between(Date.today, 7.days.from_now),
                price:       (Random.new.rand(500..5000) / 10.0).ceil * 10,
                event_types: [EventType.order('RANDOM()').first])
end

puts('Creating comments, ratings and reports')

Place.all.each do |place|
  user_list_1 = User.order('RANDOM()')
  user_list_2 = User.order('RANDOM()')
  number_of_comments  = Random.new.rand(0..10)
  number_of_ratings   = Random.new.rand(0..10)
  number_of_reports   = Random.new.rand(0..10)

  number_of_comments.times do
    place.comments.create!(user:    User.order('RANDOM()').first,
                           content: Faker::Lorem.paragraph)
  end

  number_of_ratings.times do |i|
    place.ratings.create!(user: user_list_1[i],
                          value: Random.new.rand(0..10))
  end

  number_of_reports.times do |i|
    place.reports.create!(user: user_list_2[i])
  end
end

Event.all.each do |event|
  user_list_1 = User.order('RANDOM()')
  user_list_2 = User.order('RANDOM()')
  number_of_comments  = Random.new.rand(0..10)
  number_of_ratings   = Random.new.rand(0..10)
  number_of_reports   = Random.new.rand(0..10)

  number_of_comments.times do
    event.comments.create!(user:    User.order('RANDOM()').first,
                           content: Faker::Lorem.paragraph)
  end

  number_of_ratings.times do |i|
    event.ratings.create!(user: user_list_1[i],
                          value: Random.new.rand(0..10))
  end

  number_of_reports.times do |i|
    event.reports.create!(user: user_list_2[i])
  end
end

puts('Creating relationships')

User.all.each do |followed|
  number_of_followers = Random.new.rand(0..10)

  number_of_followers.times do
    follower = User.order('RANDOM()').first
    follower = User.order('RANDOM()').first while follower == followed || follower.following?(followed)
    Relationship.create!(follower: follower, followed: followed)
  end
end

puts('Finished seeding')
