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

Item.where(id: (1..8)).each_with_index do |item,i|
  image = item.build_image
  image.data1 = File.new(Rails.root.join("spec/data/DSC_#{sprintf('%04d', i + 2)}.JPG"), "rb").read
  image.data2 = File.new(Rails.root.join("spec/data/DSC_#{sprintf('%04d', i + 3)}.JPG"), "rb").read
  image.data3 = File.new(Rails.root.join("spec/data/DSC_#{sprintf('%04d', i + 4)}.JPG"), "rb").read
  image.data1_content_type = "image/jpeg"
  image.data2_content_type = "image/jpeg"
  image.data3_content_type = "image/jpeg"
  image.save!
end

puts "Created up to 8 ...."

Item.where(id: (9..16)).each_with_index do |item,i|
  image = item.build_image
  image.data1 = File.new(Rails.root.join("spec/data/DSC_#{sprintf('%04d', i + 2)}.JPG"), "rb").read
  image.data2 = File.new(Rails.root.join("spec/data/DSC_#{sprintf('%04d', i + 3)}.JPG"), "rb").read
  image.data3 = File.new(Rails.root.join("spec/data/DSC_#{sprintf('%04d', i + 4)}.JPG"), "rb").read
  image.data1_content_type = "image/jpeg"
  image.data2_content_type = "image/jpeg"
  image.data3_content_type = "image/jpeg"
  image.save!
end

puts "Created up to 16 ...."

Item.where(id: (17..24)).each_with_index do |item,i|
  image = item.build_image
  image.data1 = File.new(Rails.root.join("spec/data/DSC_#{sprintf('%04d', i + 2)}.JPG"), "rb").read
  image.data2 = File.new(Rails.root.join("spec/data/DSC_#{sprintf('%04d', i + 3)}.JPG"), "rb").read
  image.data3 = File.new(Rails.root.join("spec/data/DSC_#{sprintf('%04d', i + 4)}.JPG"), "rb").read
  image.data1_content_type = "image/jpeg"
  image.data2_content_type = "image/jpeg"
  image.data3_content_type = "image/jpeg"
  image.save!
end

puts "Created up to 24 ...."

Item.where(id: (25..32)).each_with_index do |item,i|
  image = item.build_image
  image.data1 = File.new(Rails.root.join("spec/data/DSC_#{sprintf('%04d', i + 2)}.JPG"), "rb").read
  image.data2 = File.new(Rails.root.join("spec/data/DSC_#{sprintf('%04d', i + 3)}.JPG"), "rb").read
  image.data3 = File.new(Rails.root.join("spec/data/DSC_#{sprintf('%04d', i + 4)}.JPG"), "rb").read
  image.data1_content_type = "image/jpeg"
  image.data2_content_type = "image/jpeg"
  image.data3_content_type = "image/jpeg"
  image.save!
end

puts "Created up to 32 ...."

Item.where(id: (32..40)).each_with_index do |item,i|
  image = item.build_image
  image.data1 = File.new(Rails.root.join("spec/data/DSC_#{sprintf('%04d', i + 2)}.JPG"), "rb").read
  image.data2 = File.new(Rails.root.join("spec/data/DSC_#{sprintf('%04d', i + 3)}.JPG"), "rb").read
  image.data3 = File.new(Rails.root.join("spec/data/DSC_#{sprintf('%04d', i + 4)}.JPG"), "rb").read
  image.data1_content_type = "image/jpeg"
  image.data2_content_type = "image/jpeg"
  image.data3_content_type = "image/jpeg"
  image.save!
end

puts "Created up to 40 ...."

Item.where(id: (40..48)).each_with_index do |item,i|
  image = item.build_image
  image.data1 = File.new(Rails.root.join("spec/data/DSC_#{sprintf('%04d', i + 2)}.JPG"), "rb").read
  image.data2 = File.new(Rails.root.join("spec/data/DSC_#{sprintf('%04d', i + 3)}.JPG"), "rb").read
  image.data3 = File.new(Rails.root.join("spec/data/DSC_#{sprintf('%04d', i + 4)}.JPG"), "rb").read
  image.data1_content_type = "image/jpeg"
  image.data2_content_type = "image/jpeg"
  image.data3_content_type = "image/jpeg"
  image.save!
end

puts "Created up to 48 ...."

Item.where(id: (48..56)).each_with_index do |item,i|
  image = item.build_image
  image.data1 = File.new(Rails.root.join("spec/data/DSC_#{sprintf('%04d', i + 2)}.JPG"), "rb").read
  image.data2 = File.new(Rails.root.join("spec/data/DSC_#{sprintf('%04d', i + 3)}.JPG"), "rb").read
  image.data3 = File.new(Rails.root.join("spec/data/DSC_#{sprintf('%04d', i + 4)}.JPG"), "rb").read
  image.data1_content_type = "image/jpeg"
  image.data2_content_type = "image/jpeg"
  image.data3_content_type = "image/jpeg"
  image.save!
end

puts "Created up to 56 ...."