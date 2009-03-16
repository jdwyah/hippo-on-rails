module ActiveRecord
  module ConnectionAdapters # :nodoc:
    module SchemaStatements
      
      # Change a column using this "arcane" algorithm copied from the Rails
      # Postgres adapter. This allows us to change a varchar to an integer in
      # a transactional migration.
      def change_column_arcane(table_name, column_name, type, options = {}) #:nodoc:
        add_column(table_name, "#{column_name}_ar_tmp", type, options)
        execute "UPDATE #{table_name} SET #{column_name}_ar_tmp = CAST(#{column_name} AS #{type_to_sql(type, options[:limit], options[:precision], options[:scale])})"
        remove_column(table_name, column_name)
        rename_column(table_name, "#{column_name}_ar_tmp", column_name)
    
        if options_include_default?(options)
          change_column_default(table_name, column_name, options[:default])
        end
      end
  
      # Inserts a row into the given table. The data argument is a hash of
      # column => value pairs.
      def insert_row(table, data)
        columns = []
        values = []
    
        data.each do |column, value|
          columns << quote_column_name(column.to_s)
          values << "#{quote(value)}"
        end
    
        execute "INSERT INTO #{table.to_s} (#{columns.join(', ')}) VALUES (#{values.join(', ')})"
      end
  
      # Updates a row or set of rows in the given table. The options hash
      # should have a :set option and a :where option that correspond to the
      # SQL SET and WHERE clauses in the UPDATE statment. The :set and :where
      # options can be strings, hashes of column => value pairs, or arrays
      # of [column, value] pairs.
      #
      # Examples:
      #
      # update_row 'users', 
      #     :where => 'allows_public=false AND deleted=false', 
      #     :set => "first_name=NULL, last_name=NULL"
      #
      # update_row 'users', 
      #     :where => [[:allows_public, false], [:deleted, false]], 
      #     :set => [[:first_name, nil], [:last_name, nil]]
      #
      # update_row 'users', 
      #     :where => {:allows_public => false, :deleted => false}, 
      #     :set => {:first_name => nil, :last_name => nil}
      #
      # ...will all execute equivalent SQL:
      # UPDATE users SET first_name=NULL, last_name=NULL WHERE allows_public=false AND deleted=false
      def update_row(table, options)
        set_options = options[:set]
        where_options = options[:where]
    
        raise 'ERROR: No :set options were specified so there\'s nothing to do.' if set_options.blank?        
    
        if where_options.blank?
          if options[:update_all] == true
            where_options = '1=1'
          else
            raise 'ERROR: No :where options were specified in call to update_row. This could be dangerous! Specify :update_all => true if that\'s what you want (but it probably isn\'t).' 
          end
        end
    
        set_clause   = join_column_values(set_options, ', ')
        where_clause = join_column_values(where_options, ' AND ')
    
        execute "UPDATE #{table.to_s} SET #{set_clause} WHERE #{where_clause}"        
      end
  
  
      # Deletes a row or set of rows in the given table using the where condition passed.
      # The condition may be a string or a hash of criteria to match on.
      #
      # Examples:
      # delete_row 'users', 'allows_public is not true'
      # delete_row 'users', {:deleted => true}
      #
      # ...will execute:
      # DELETE users WHERE allows_public is not true
      # DELETE users WHERE deleted=true
      def delete_row(table, where_options)
        where_options = where_options[:where] if where_options[:where]
    
    
        if where_options[:delete_all] == true
          where_options = '1=1'
        elsif where_options.blank?
          raise 'ERROR: No :where options were specified in call to delete_row. This could be dangerous! Specify :delete_all => true if that\'s what you want (but it probably isn\'t).' 
        end
    
    
        where_clause = join_column_values(where_options, ' AND ')
    
        execute "DELETE FROM #{table.to_s} WHERE #{where_clause}"
      end
  
      def join_column_values(pairs, connector)
        if pairs.is_a?(Hash) || pairs.is_a?(Array)
          pairs.to_a.map { |c,v| "#{quote_column_name(c.to_s)}=#{quote(v)}" }.join(connector)
        else
          pairs
        end        
      end
  
      def add_foreign_key(table, column, target_table, target_column="id", constraint_name="#{table.to_s}_#{target_table.to_s}_fkey")
        execute "ALTER TABLE #{table.to_s} ADD CONSTRAINT #{constraint_name.to_s} FOREIGN KEY (#{column.to_s}) REFERENCES #{target_table.to_s} (#{target_column.to_s});"
      end
  
      def remove_foreign_key(table, target_table, constraint_name="#{table.to_s}_#{target_table.to_s}_fkey")
        execute "ALTER TABLE #{table.to_s} DROP CONSTRAINT #{constraint_name};"
      end
  
      def set_current_sequence_value(sequence, value)
        execute "SELECT setval('#{sequence.to_s}', #{value}); " # Next nextval will return value + 1
      end
      
    end
  end
end
