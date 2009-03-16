namespace :db do
  task :version => :environment do
    applied = ActiveRecord::Base.connection.select_all('select version from schema_migrations').collect! { |record| record['version'].to_i }
      
    m = ActiveRecord::Migrator.new(:up,File.expand_path('db/migrate', RAILS_ROOT))
    migration_classes = m.migrations
      
    unapplied = 0
    migration_classes.each do |migration|
      is_applied = applied.include? migration.version
      puts " Applied: #{is_applied ? 'Yes' : 'No '} #{migration.version}  #{migration.name}"
      unapplied += 1 unless is_applied
    end
    puts "Migration Status for #{RAILS_ENV} database: #{unapplied > 0 ? " #{unapplied} unapplied migration." : 'Up to date.'}"
  end
end
