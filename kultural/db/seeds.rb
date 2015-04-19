event_types_list = [
  [ "Music", "Concerts, street bands, etc" ],
  [ "Fair", "Book fairs, etc" ],
  [ "Art", "Expositions, paintings sale, etc" ],
]

event_types_list.each do |name, examples|
  Country.create( name: name, examples: examples )
end
