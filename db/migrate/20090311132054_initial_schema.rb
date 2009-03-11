class InitialSchema < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.string :description
      t.float :price
      t.integer :max_topics
      t.timestamps
    end

    create_table :topics do |t|
      t.string :type
      t.integer :user_id
      t.string :title
      t.timestamp :updated_at
      t.timestamp :created_at
      t.integer :public_visible
      t.integer :subject
      t.integer :subject_id
      t.integer :latitude
      t.integer :longitude
      t.text :data
      t.string :uri
      t.string :title_lower
    end
    

    create_table :users do |t|
      t.string :login
      t.string :pasword
      t.string :email
      t.integer :enabled
      t.integer :supervisor
      t.integer :invitations
      t.integer :subscription_id
      t.string :paypal_id
      t.date :last_delicious_import
      t.date :last_google_apps_import
      t.timestamp :created_at
      t.timestamps
    end
    
    create_table :invitations do |t|
      t.string :email
      t.string :user_agent
      t.string :referer
      t.string :host
      t.integer :inviter_user_id
      t.integer :signup_user_id
      t.string :random_key
      t.boolean :sent_email_ok
      t.timestamps
    end
    
    create_table :users_topics do |t|
      t.integer :topic_id
      t.integer :user_id
    end
    
    create_table :occurences do |t|
      t.string :type
      t.integer :user_id
      t.string :title
      t.text :data
      t.timestamp :updated_at
      t.timestamp :created_at
      t.string :uri
      t.integer :mind_tree_id
    end

    create_table :subjects do |t|
      t.string :type
      t.string :foreign_id
      t.string :name
    end

    create_table :topics_associations do |t|
      t.integer :association_id
      t.integer :topic_id
    end


    create_table :topics_occurences do |t|
      t.integer :occurence_id
      t.integer :topic_id
      t.integer :latitude
      t.integer :longitude
    end

    create_table :topics_topics do |t|
      t.integer :from_id
      t.integer :to_id
      t.integer :latitude
      t.integer :longitude
    end

    add_foreign_key :topics, :user_id, :users
    add_foreign_key :topics, :subject_id, :subjects
    add_foreign_key :users, :subscription_id, :subscriptions
    add_foreign_key :invitations, :inviter_user_id, :users, :id, 'invitations_users_inviter_fkey'
    add_foreign_key :invitations, :signup_user_id, :users, :id, 'invitations_users_signup_fkey'

    add_foreign_key :users_topics, :topic_id, :topics
    add_foreign_key :users_topics, :user_id, :users
    add_foreign_key :occurences, :user_id, :users

    add_foreign_key :topics_associations, :association_id, :topics, :id, 'topics_associations_topics_association_fkey'
    add_foreign_key :topics_associations, :topic_id, :topics, :id, 'topics_associations_topics_topic_fkey'

    add_foreign_key :topics_occurences, :occurence_id, :occurences
    add_foreign_key :topics_occurences, :topic_id, :topics
    add_foreign_key :topics_topics, :from_id, :topics, :id, 'topics_topics_topics_from_fkey'
    add_foreign_key :topics_topics, :to_id, :topics, :id, 'topics_topics_topics_to_fkey'


  end

  def self.down

    remove_foreign_key :topics, :users
    remove_foreign_key :topics, :subjects
    remove_foreign_key :users, :subscriptions
    remove_foreign_key :invitations, :users, 'invitations_users_inviter_fkey'
    remove_foreign_key :invitations, :users, 'invitations_users_signup_fkey'

    remove_foreign_key :users_topics, :topics
    remove_foreign_key :users_topics, :users
    remove_foreign_key :occurences, :users

    remove_foreign_key :topics_associations, :associations, 'topics_associations_topics_association_fkey'
    remove_foreign_key :topics_associations, :topics, 'topics_associations_topics_topic_fkey'

    remove_foreign_key :topics_occurences, :occurences
    remove_foreign_key :topics_occurences, :topics
    remove_foreign_key :topics_topics, :topics, 'topics_topics_topics_from_fkey'
    remove_foreign_key :topics_topics, :topics, 'topics_topics_topics_to_fkey'

    drop_table :subscriptions
    drop_table :topics
    drop_table :users
    drop_table :invitations
    drop_table :users_topics
    drop_table :occurences
    drop_table :subjects
    drop_table :topics_associations
    drop_table :topics_occurences
    drop_table :topics_topics
  end
end
