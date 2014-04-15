require 'minitest/autorun'
require 'mocha/setup'

begin
  require 'minitest/pride'
rescue LoadError
end

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
require 'wkcheck'

Rainbow.enabled = false

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
    Wanikani::User.stubs(:on_vacation?).returns(false)
  end

  def test_display_vacation_date_when_in_vacation_mode
    Wanikani::User.stubs(:on_vacation?).returns(true)
    Wanikani::User.stubs(:information).returns({ "vacation_date" => 1357027200 })

    message = @stats.study_queue
    assert_match /You are currently on vacation from WaniKani, starting from Tuesday, January 1 at \d{1,2}:\d{2} (AM|PM)./, message
  end

  def test_display_pending_lessons_and_reviews
    Wanikani::StudyQueue.stubs(:queue).returns(study_queue_data(10, 500))

    message = @stats.study_queue
    assert_match /You have 10 lessons pending/, message
    assert_match /You have 500 reviews pending/, message
  end

  def test_uses_no_instead_of_zero
    Wanikani::StudyQueue.stubs(:queue).returns(study_queue_data(10, 0))

    message = @stats.study_queue
    assert_match /You have no reviews pending/, message
  end

  def test_display_review_date_for_next_lessons_if_there_are_no_reviews
    Wanikani::StudyQueue.stubs(:queue).returns(study_queue_data(10, 0))

    message = @stats.study_queue
    assert_match /You have more reviews coming your way on Tuesday, January 1 at \d{1,2}:\d{2} (AM|PM)./, message
  end

  def test_do_not_display_review_date_for_next_lessons_if_there_are_reviews
    Wanikani::StudyQueue.stubs(:queue).returns(study_queue_data(10, 10))

    message = @stats.study_queue
    refute_match /You have more reviews coming your way on Tuesday, January 1 at \d{1,2}:\d{2} (AM|PM)./, message
  end

  def test_display_review_date_for_no_lessons_or_reviews
    Wanikani::StudyQueue.stubs(:queue).returns(study_queue_data(0, 0))

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
    Wanikani::Level.stubs(:progression).returns(level_progression_data)
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

class TestCriticalItems < MiniTest::Unit::TestCase
  def critical_items
    [
      {"type"=>"kanji", "character"=>"口", "meaning"=>"mouth", "onyomi"=>"こう", "kunyomi"=>"くち", "important_reading"=>"onyomi", "level"=>1, "percentage"=>"77"},
      {"type"=>"radical", "character"=>"本", "meaning"=>"real", "image"=>nil, "level"=>2, "percentage"=>"76"},
      {"type"=>"vocabulary", "character"=>"伝説", "kana"=>"でんせつ", "meaning"=>"legend", "level"=>17, "percentage"=>"76"}
    ]
  end

  def setup
    @critical = WKCheck::CriticalItems.new(nil)
  end

  def test_show_critical_items_default_percentage
    Wanikani::CriticalItems.expects(:critical).with(75).returns(critical_items)
    @critical.critical_items
  end

  def test_show_critical_items_specified_percentage
    Wanikani::CriticalItems.expects(:critical).with(50).returns(critical_items)
    @critical = WKCheck::CriticalItems.new(50)
    @critical.critical_items
  end

  def test_critical_items_kanji_shows_character_important_reading_and_meaning
    Wanikani::CriticalItems.stubs(:critical).returns(critical_items)
    items = @critical.critical_items
    assert_match /口/, items
    assert_match /こう/, items
    assert_match /mouth/, items
    refute_match /くち/, items
  end

  def test_critical_items_radical_shows_character_and_meaning
    Wanikani::CriticalItems.stubs(:critical).returns(critical_items)
    items = @critical.critical_items
    assert_match /本/, items
    assert_match /real/, items
  end

  def test_critical_items_vocabulary_shows_character_kana_and_meaning
    Wanikani::CriticalItems.stubs(:critical).returns(critical_items)
    items = @critical.critical_items
    assert_match /伝説/, items
    assert_match /でんせつ/, items
    assert_match /legend/, items
  end
end
