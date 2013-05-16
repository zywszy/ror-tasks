require 'active_record'
require 'active_record/fixtures'
require 'yaml'

ActiveRecord::Base.establish_connection(YAML::load_file("config/db.yml"))

module TestHelper
  def self.included(child)
    # WARNING: we use transactional fixtures only. This helper should not be
    # used to test transaction dependent code.
    child.around do |example|
      tables = Dir["test/fixtures/*.yml"].map{|fn| File.basename(fn,".yml") }
      ActiveRecord::Fixtures.create_fixtures("test/fixtures/",tables)
      ActiveRecord::Base.transaction do
        begin
          example.run
        rescue ActiveRecord::ActiveRecordError => e
          puts e
          raise Exception.new(e)
        end
        raise ActiveRecord::Rollback
      end
    end
  end
end
