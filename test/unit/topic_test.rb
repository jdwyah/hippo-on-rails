require File.dirname(__FILE__) + '/../test_helper'


class TopicTest < ActiveSupport::TestCase
  context "topics with a tag" do
    setup do
      @crime_and_punishment = Factory(:topic)
      @book = Factory(:topic)

      @crime_and_punishment.tags << @book
    end

    should "be tagged" do
      assert_equal [@book], @crime_and_punishment.tags
    end

    context "and some properties" do
      setup do
        @date_read = Factory(:property_type, :name => 'Date Read', :type_name => 'MetaDate')
        @book.property_types << @date_read
      end

      should "books should have dates read " do
        assert_equals [@date_read], @book.property_types
        assert_equals [@date_read], @crime_and_punishment.properties_to_use
      end
      
    end
  end
end
