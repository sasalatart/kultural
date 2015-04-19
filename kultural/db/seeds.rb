event_types_list = [
  [ "Music", "Concerts, street bands, etc" ],
  [ "Fair", "Book fairs, etc" ],
  [ "Art", "Expositions, paintings sale, etc" ],
]

event_types_list.each do |name, examples|
  EventType.create( name: name, examples: examples )
end


User.create(
    name: 'Jaime Castro R',
    password: 'macoy123',
    mail: 'jecastro1@uc.cl',
    phone: 123456789,
    birthday: Date.strptime("31/12/1994", "%d/%m/%Y"),
    male: true
)

User.create(
    name: 'Jaime Navon C',
    password: 'iphone123',
    mail: 'jnavon@uc.cl',
    phone: 27753473433,
    birthday: Date.strptime("25/12/1960", "%d/%m/%Y"),
    male: true
)

User.create(
    name: 'Patricio Lopez J',
    password: 'iloverails',
    mail: 'pelopez2@uc.cl',
    phone: 64286428,
    birthday: Date.strptime("13/12/1993", "%d/%m/%Y"),
    male: true
)

User.create(
    name: 'Sebastian Salata RT',
    password: 'napoleon',
    mail: 'sasalata@uc.cl',
    phone: 58758745,
    birthday: Date.strptime("16/04/1992", "%d/%m/%Y"),
    male: true
)

User.create(
    name: 'Vicente Dragicevic H',
    password: 'ilovethiscompany',
    mail: 'vrdragicevic@uc.cl',
    phone: 123456456,
    birthday: Date.strptime("11/11/1993", "%d/%m/%Y"),
    male: true
)

group = Group.create(
    name: 'Spread Rails',
    description: 'Expandir el imperio de Rails y enfrentar a Django es nuestra labor'
)

GroupsUsers.create(
  user: User.find(id:1),
  group: group,
  is_admin: true
)

GroupsUsers.create(
  user: User.find(id:2),
  group: group,
  is_admin: false
)


place_patiwi = Place.create(
  owner: User.find(id:3),
  name: 'Casa del ayudante de Web',
  description: 'El unico lugar que encontramos',
  x: -74.1,
  y: 33.1
)

place_dcc = Place.create(
  owner: group,
  name: 'Sala Javier Pinto',
  description: 'Algunas veces la prestan, otras no',
  x: -74.6,
  y: 33.3
)

event_patiwi_1 = Event.create(
  owner: User.find(id:4),
  place: place_patiwi,
  name: 'Rails presentation',
  description: 'Lorem ipsum dolor sit amet',
  date: DateTime.strptime('20/04/2015 15:00', '%d/%m/%Y %H:%M'),
  price: 5000
)

event_patiwi_1.event_types << EventType.find(id:1)

event_patiwi_2 = Event.create(
  owner: group,
  place: place_patiwi,
  name: 'Musica maestro',
  description: 'Cumbia en el departamento del Ayudante. Banda de los Jaimes',
  date: DateTime.strptime('21/04/2015 12:00', '%d/%m/%Y %H:%M'),
  price: 100
)

event_patiwi_2.event_types << EventType.find_by_name("Art")

event_dcc = Event.create(
  owner: group,
  place: place_dcc,
  name: 'SQL dificil',
  description: 'SQL dificil con Rails. No estan invitados los profes del datalab',
  date: DateTime.strptime('24/04/2015 11:30', '%d/%m/%Y %H:%M'),
  price: 5000000.1
)

event_dcc.event_types << EventType.find(id:2)

event_patiwi_2.reports << Report.create(
  user: User.first,
  genuine: false
)

event_dcc.comments << Comment.create(
  content: 'Reutter se sentiria avergonzado del polimorfismo',
  user: User.find(id:2)
)

#place_dcc.ratings << Rating.create(
#  value: 100,
#  user: User.find(id:3)
#)

#place_patiwi.ratings << Rating.create(
#  value: 50,
#  user: User.find(id:1)
#)




