require 'minitest/autorun'
require 'mocha/setup'

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
require 'wkcheck'

Sickill::Rainbow.enabled = false

class TestWKCheckStats < MiniTest::Unit::TestCase
  def study_queue_data(lessons, reviews)
    {
      "lessons_available"           => lessons,
      "reviews_available"           => reviews,
      "next_review_date"            => 1357027200,
      "reviews_available_next_hour" => 6,
      "reviews_available_next_day"  => 24
    }
  end

  def setup
    @stats = WKCheck::Stats.new
  end

  def test_display_pending_lessons_and_reviews
    Wanikani::StudyQueue.expects(:queue).returns(study_queue_data(10, 500))

    message = @stats.study_queue
    assert_match /You have 10 lessons pending/, message
    assert_match /You have 500 reviews pending/, message
  end

  def test_uses_no_instead_of_zero
    Wanikani::StudyQueue.expects(:queue).returns(study_queue_data(10, 0))

    message = @stats.study_queue
    assert_match /You have no reviews pending/, message
  end

  def test_display_review_date_for_no_lessons_or_reviews
    Wanikani::StudyQueue.expects(:queue).returns(study_queue_data(0, 0))

    message = @stats.study_queue
    assert_equal "You have no lessons or reviews now! You'll have some more on Tuesday, January 1 at 8:00 AM.", message
  end
end
