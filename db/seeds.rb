unless Rails.env.production?
  require 'database_cleaner'
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.clean
end

table_names = %w(users organizations items)

table_names.each do |table_name|
  dir = case Rails.env
  when 'development'
    'development'
  when 'staging'
    'staging'
  when 'production'
    'production'
  end
  path = Rails.root.join('db', 'seeds', dir, "#{table_name}.rb")
  if File.exist?(path)
    puts "Creating #{table_name}...."
    require(path)
  end
end
