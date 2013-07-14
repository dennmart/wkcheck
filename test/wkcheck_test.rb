require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/setup'

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
require 'wkcheck'

Sickill::Rainbow.enabled = false

class TestStudyQueue < MiniTest::Unit::TestCase
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

  def test_display_review_date_for_next_lessons
    Wanikani::StudyQueue.expects(:queue).returns(study_queue_data(10, 0))

    message = @stats.study_queue
    assert_match /You have more reviews coming your way on Tuesday, January 1 at \d{1,2}:\d{2} (AM|PM)./, message
  end

  def test_display_review_date_for_no_lessons_or_reviews
    Wanikani::StudyQueue.expects(:queue).returns(study_queue_data(0, 0))

    message = @stats.study_queue
    assert_match /You have no lessons or reviews now! You'll have some more on Tuesday, January 1 at \d{1,2}:\d{2} (AM|PM)./, message
  end
end

class TestLevelProgression < MiniTest::Unit::TestCase
  def level_progression_data
    {
      "current_level" => 30,
      "radicals_progress" => 7,
      "radicals_total" => 10,
      "kanji_progress" => 10,
      "kanji_total" => 30
    }
  end

  def setup
    stats = WKCheck::Stats.new
    Wanikani::Level.expects(:progression).returns(level_progression_data)
    @message = stats.level_progression
  end

  def test_display_current_level
    assert_match /Your progress for level 30/, @message
  end

  def test_display_radicals_and_kanji_progress_and_percentage
    assert_match /7 out of 10 Radicals \(70.0%\)/, @message
    assert_match /10 out of 30 Kanji \(33.3%\)/, @message
  end
end
