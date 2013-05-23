require 'wanikani'
require 'rainbow'

module WKCheck
  VERSION = "0.0.2"
  CONFIG_FILE = "#{Dir.home}/.wkcheck.yml"

  class Stats
    def study_queue
      queue = Wanikani::StudyQueue.queue
      lessons = queue["lessons_available"]
      reviews = queue["reviews_available"]
      next_review_date = Time.at(queue["next_review_date"]).utc.strftime("%A, %B %-d at %-l:%M %p")
      queue_message(lessons, reviews, next_review_date)
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
      end
    end
  end
end
