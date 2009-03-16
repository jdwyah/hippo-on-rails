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
      t.integer :sent_email_ok
      t.timestamps
    end
    
    create_table :users_topics do |t|
      t.integer :topic_id
      t.integer :user_id
    end
    
    create_table :occurrences do |t|
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


    create_table :topics_occurrences do |t|
      t.integer :occurrence_id
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

  end

  def self.down
    drop_table :subscriptions
    drop_table :topics
    drop_table :users
    drop_table :invitations
    drop_table :users_topics
    drop_table :occurrences
    drop_table :subjects
    drop_table :topics_associations
    drop_table :topics_occurrences
    drop_table :topics_topics
  end
end
