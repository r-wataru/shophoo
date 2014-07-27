a = User.find_by_email("alice@example.com")
b = User.find_by_email("bob@example.com")
c = User.find_by_email("charlie@example.com")
d = User.find_by_email("david@example.com")

r = Organization.create!(
  screen_name: "rubyquitous",
  real_name: "ルビキタス",
)
p = Organization.create!(
  screen_name: "phpquitous",
  real_name: "PHPキタス",
)
o = Organization.create!(
  screen_name: "perlquitous",
  real_name: "パールキタス",
)

r.add_owner(a)
r.managers << c

p.add_owner(b)

o.add_owner(c)
o.managers << d
o.managers << a