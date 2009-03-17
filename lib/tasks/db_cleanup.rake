namespace :hippo do
  namespace :db do
    task :cleanup => :environment do
      sql_str =<<EOS
    delete from topics_topics tt
where
not exists (select 1 from topics where topics.id = tt.from_id)
or
not exists (select 1 from topics where topics.id = tt.to_id)
EOS
      ActiveRecord::Base.connection.execute(sql_str)

      sql_str =<<EOS
    delete from topics_associations tt
where
not exists (select 1 from topics where topics.id = tt.association_id)
or
not exists (select 1 from topics where topics.id = tt.topic_id)
EOS
      ActiveRecord::Base.connection.execute(sql_str)

      sql_str =<<EOS
    delete from topics_occurrences tt
where
not exists (select 1 from topics where topics.id = tt.topic_id)
or
not exists (select 1 from occurrences where occurrences.id = tt.occurrence_id)
EOS
      ActiveRecord::Base.connection.execute(sql_str)

      sql_str =<<EOS
    delete from users_topics tt
where
not exists (select 1 from topics where topics.id = tt.topic_id)
EOS
      ActiveRecord::Base.connection.execute(sql_str)


      conversions = {'seealso' => 'SeeAlso',
        'association' => 'Association',        
        'date' => 'DateTopic',
        'entry' => 'Entry',
        'file' => 'FileTopic',        
        'gdoc' => 'GoogleDoc',
        'gspread' => 'GoogleSpread',
        'link' => 'Weblink',
        'location' => 'Location',
        'metadate' => 'MetaDate',
        'metalocation' => 'MetaLocation',
        'metatext' => 'MetaText',
        'metatopic' => 'MetaTopic',
        'root' => 'Root',
        'text' => 'Text',
        'Text' => 'TextTopic'
      }

      conversions.each do |from, to|
        sql_str ="update topics set type = '#{to}' where type = '#{from}'"
        ActiveRecord::Base.connection.execute(sql_str)
      end

    end
  end
end