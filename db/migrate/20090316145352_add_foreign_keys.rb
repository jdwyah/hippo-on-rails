class AddForeignKeys < ActiveRecord::Migration
  def self.up
    add_foreign_key :topics, :user_id, :users
    add_foreign_key :topics, :subject_id, :subjects
    add_foreign_key :users, :subscription_id, :subscriptions
    add_foreign_key :invitations, :inviter_user_id, :users, :id, 'invitations_users_inviter_fkey'
    add_foreign_key :invitations, :signup_user_id, :users, :id, 'invitations_users_signup_fkey'

    add_foreign_key :users_topics, :topic_id, :topics
    add_foreign_key :users_topics, :user_id, :users
    add_foreign_key :occurrences, :user_id, :users

    add_foreign_key :topics_associations, :association_id, :topics, :id, 'topics_associations_topics_association_fkey'
    add_foreign_key :topics_associations, :topic_id, :topics, :id, 'topics_associations_topics_topic_fkey'

    add_foreign_key :topics_occurrences, :occurrence_id, :occurrences
    add_foreign_key :topics_occurrences, :topic_id, :topics
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
    remove_foreign_key :occurrences, :users

    remove_foreign_key :topics_associations, :associations, 'topics_associations_topics_association_fkey'
    remove_foreign_key :topics_associations, :topics, 'topics_associations_topics_topic_fkey'

    remove_foreign_key :topics_occurrences, :occurrences
    remove_foreign_key :topics_occurrences, :topics
    remove_foreign_key :topics_topics, :topics, 'topics_topics_topics_from_fkey'
    remove_foreign_key :topics_topics, :topics, 'topics_topics_topics_to_fkey'
  end
end
