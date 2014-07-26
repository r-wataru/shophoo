{alice: "female", bob: "male", charlie: "male", david: "male", eric: "male"}.each do |data|
  User.create!(
    password: "password",
    setting_password: true,
    screen_name: data.first,
    given_name: data.first.capitalize,
    family_name: 'Smith',
    checked: true,
    birthday: DateTime.now - rand(40).year,
    sex: data.last
  )
end

FactoryGirl.create(:user_with_email, screen_name: 'nobody', family_name: '', given_name: '', sex: nil)

User.all.each do |user|
	u = user.emails.new(
    address: "#{user.screen_name}@example.com",
    main: true
  )
  u.save
end

User.all.each do |user|
  p = user.private_address(
    country_code: 'JP',
    zip_code: '1010002',
    state: '東京都',
    city: '港区',
    address1: '大門1-1-1',
    address2: 'マンション大門101',
    phone: '03-0000-0000',
    fax: '03-0000-0001')
  p.save
  w = user.work_address(
    country_code: 'JP',
    zip_code: '1010002',
    state: '東京都',
    city: '港区',
    address1: '大門1-1-1',
    address2: 'マンション芝大門101',
    phone: '03-0000-0000',
    fax: '03-0000-0001')
  w.save
end
