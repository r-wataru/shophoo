# Use shared connection with transactional fixtures
#
# We can turn on `use_transaction_fixtures` even when using Capybara with javascript driver.
# See http://blog.plataformatec.com.br/2011/12/three-tips-to-improve-the-performance-of-your-test-suite/
# See also http://stackoverflow.com/a/12092473/513554
class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || ConnectionPool::Wrapper.new(:size => 1) { retrieve_connection }
  end
end
