require 'minitest/autorun'
require 'mocha/setup'

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
require 'wkcheck'

describe WKCheck::Study do
  describe ".available_stats" do
    def study_queue_data(lessons, reviews)
      {
        "lessons_available"           => lessons,
        "reviews_available"           => reviews,
        "next_review_date"            => 1357027200,
        "reviews_available_next_hour" => 6,
        "reviews_available_next_day"  => 24
      }
    end

    it "displays pending lessons and reviews" do
      Wanikani::StudyQueue.expects(:queue).returns(study_queue_data(10, 500))

      message = WKCheck::Study.available_stats
      message.must_match /You have 10 lessons pending/
      message.must_match /You have 500 reviews pending/
    end

    it "uses the word 'no' instead of '0' if there are zero lessons or reviews" do
      Wanikani::StudyQueue.expects(:queue).returns(study_queue_data(10, 0))

      message = WKCheck::Study.available_stats
      message.must_match /You have no reviews pending/
    end

    it "displays the next review date if there are zero lessons and reviews" do
      Wanikani::StudyQueue.expects(:queue).returns(study_queue_data(0, 0))

      message = WKCheck::Study.available_stats
      message.must_equal "You have no lessons or reviews now! You'll have some more on Tuesday, January 1 at 12:00 AM."
    end
  end
end
