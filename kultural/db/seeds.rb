event_types_list = [
  ['Music', 'Concerts, street bands, etc'],
  ['Fair', 'Book fairs, etc'],
  ['Art', 'Expositions, paintings sale, etc']
]

event_types_list.each do |name, examples|
  puts("Creating event with name #{name} and examples #{examples}")
  EventType.create(name: name, examples: examples)
end

puts('Creating users')

User.create(name: 'Jaime Castro R',
            password: 'macoy123',
            password_confirmation: 'macoy123',
            mail: 'jecastro1@uc.cl',
            phone: 123456789,
            birthday: Date.strptime('31/12/1994', '%d/%m/%Y'),
            male: true)

User.create(name: 'Jaime Navon C',
            password: 'iphone123',
            password_confirmation: 'iphone123',
            mail: 'jnavon@uc.cl',
            phone: 2777858,
            birthday: Date.strptime('25/12/1960', '%d/%m/%Y'),
            male: true)

User.create(name: 'Patricio Lopez J',
            password: 'iloverails',
            password_confirmation: 'iloverails',
            mail: 'pelopez2@uc.cl',
            phone: 64286428,
            birthday: Date.strptime('13/12/1993', '%d/%m/%Y'),
            male: true)

User.create(name: 'Sebastian Salata R-T',
            password: 'napoleon',
            password_confirmation: 'napoleon',
            mail: 'SASalata@uc.cl',
            phone: 58758745,
            birthday: Date.strptime('16/04/1992', '%d/%m/%Y'),
            male: true)

User.create(name: 'Vicente Dragicevic H',
            password: 'ilovethiscompany',
            password_confirmation: 'ilovethiscompany',
            mail: 'vrdragicevic@uc.cl',
            phone: 123456456,
            birthday: Date.strptime('11/11/1993', '%d/%m/%Y'),
            male: true)

puts('Creating groups')

group = Group.create(name: 'Spread Rails',
                     description: 'Expandir el imperio de Rails y
                     enfrentar a Django es nuestra labor')

puts('Filling groups')

Membership.create(user: User.find(1),
                  group: group,
                  is_admin: true)

Membership.create(user: User.find(2),
                  group: group,
                  is_admin: false)

puts('Creating places')

place_patiwi = Place.create(owner: User.find(3),
                            name: 'Casa del ayudante de Web',
                            description: 'El unico lugar que encontramos',
                            address: 'Vicuña Maquena 3320')

place_dcc = Place.create(owner: group,
                         name: 'Sala Javier Pinto',
                         description: 'Algunas veces la prestan, otras no',
                         address: 'Las Perdices 771')

puts('Creating events')

event_patiwi_1 = Event.create(owner: User.find(4),
                              place: place_patiwi,
                              name: 'Rails presentation',
                              description: 'Lorem ipsum dolor sit amet',
                              date: DateTime.strptime('20/04/2015 15:00', '%d/%m/%Y %H:%M'),
                              price: 5000,
                              event_types: [EventType.find(1)])

event_patiwi_2 = Event.create(owner: group,
                              place: place_patiwi,
                              name: 'Musica maestro',
                              description: 'Cumbia en el departamento del Ayudante. Banda de los Jaimes',
                              date: DateTime.strptime('21/04/2015 12:00', '%d/%m/%Y %H:%M'),
                              price: 100,
                              event_types: [EventType.find(2)])

event_dcc = Event.create(owner: group,
                         place: place_dcc,
                         name: 'SQL dificil',
                         description: 'SQL dificil con Rails. No estan invitados los profes del datalab',
                         date: DateTime.strptime('24/04/2015 11:30', '%d/%m/%Y %H:%M'),
                         price: 5000000.1,
                         event_types: [EventType.find(2), EventType.find(3)])

puts('Creating reports')

event_patiwi_1.reports << Report.create(user: User.find(4))

event_patiwi_2.reports << Report.create(user: User.find(2))

puts('Creating comments')

event_dcc.comments << Comment.create(content: 'DataLab se sentiria avergonzado del polimorfismo',
                                     user: User.find(1))

event_patiwi_2.comments << Comment.create(content: 'Demasiado bueno para ser verdad. Reportenlo como falso',
                                          user: User.find(2))

puts('Creating ratings')

place_dcc.ratings << Rating.create(value: 10,
                                   user: User.find(3))

place_patiwi.ratings << Rating.create(value: 5,
                                      user: User.find(5))

event_dcc.ratings << Rating.create(value: 0,
                                   user: User.find(1))
