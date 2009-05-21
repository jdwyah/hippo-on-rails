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
  end
end
