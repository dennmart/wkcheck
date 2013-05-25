require 'wanikani'
require 'rainbow'

module WKCheck
  VERSION = "0.0.3"
  CONFIG_FILE = "#{Dir.home}/.wkcheck.yml"

  class Stats
    def study_queue
      queue = Wanikani::StudyQueue.queue
      lessons = queue["lessons_available"]
      reviews = queue["reviews_available"]
      next_review_date = Time.at(queue["next_review_date"]).utc.strftime("%A, %B %-d at %-l:%M %p")
      queue_message(lessons, reviews, next_review_date)
    end

    def level_progression
      progress = Wanikani::Level.progression
      progression_message(progress)
    end

    private

    def queue_message(lessons, reviews, next_review_date)
      if lessons.zero? && reviews.zero?
        message = "You have no lessons or reviews now! You'll have some more on #{next_review_date.bright}.".color(:green)
      else
        lessons_msg = lessons.zero? ? "no".color(:green) : lessons.to_s.color(:red)
        reviews_msg = reviews.zero? ? "no".color(:green) : reviews.to_s.color(:red)
        message = "You have #{lessons_msg} lessons pending"
        message += "\nYou have #{reviews_msg} reviews pending"
        message += "\nYou have more reviews coming your way on #{next_review_date.bright.color(:green)}."

      end
    end

    def progression_message(progress)
      radicals_percent = (progress["radicals_progress"].to_f / progress["radicals_total"].to_f) * 100
      kanji_percent = (progress["kanji_progress"].to_f / progress["kanji_total"].to_f) * 100

      message = "Your progress for level #{progress["current_level"]}:\n".color(:green)
      message += "#{progress["radicals_progress"]} out of #{progress["radicals_total"]} radicals".color(:cyan)
      message += " (#{radicals_percent.round(1)}%)\n"
      message += "#{progress["kanji_progress"]} out of #{progress["kanji_total"]} Kanji".color(:cyan)
      message += " (#{kanji_percent.round(1)}%)\n"
    end
  end
end
