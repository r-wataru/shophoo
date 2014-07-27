o1 = Organization.find_by_screen_name("rubyquitous")
o2 = Organization.find_by_screen_name("phpquitous")
o3 = Organization.find_by_screen_name("perlquitous")

30.times do |n|
  Item.create!(
    organization: o1,
    code_name: "ruby_item_#{n}",
    display_name: "Ruby #{n}",
    price: n * 1000,
    description: "説明文です" * 20,
    listable: true
  )
end

20.times do |n|
  Item.create!(
    organization: o2,
    code_name: "php_item_#{n}",
    display_name: "PHP #{n}",
    price: n * 100,
    description: "説明文です" * 20,
    listable: true
  )
end

10.times do |n|
  Item.create!(
    organization: o3,
    code_name: "perl_item_#{n}",
    display_name: "Perl #{n}",
    price: n * 10000,
    description: "説明文です" * 20,
    listable: true
  )
end