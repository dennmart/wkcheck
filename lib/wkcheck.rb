require 'wanikani'

module WKCheck
  VERSION = "0.0.2"
  CONFIG_FILE = "#{Dir.home}/.wkcheck.yml"

  class Stats
    def study_queue
      queue = Wanikani::StudyQueue.queue
      lessons = queue["lessons_available"]
      reviews = queue["reviews_available"]
      next_review_date = Time.at(queue["next_review_date"]).utc.strftime("%A, %B %-d at %-l:%M %p")

      if lessons.zero? && reviews.zero?
        message = "You have no lessons or reviews now! You'll have some more on #{next_review_date}."
      else
        message = "You have #{lessons.zero? ? "no" : lessons } lessons pending."
        message += "\nYou have #{reviews.zero? ? "no" : reviews } reviews pending."
      end

      message
    end
  end
end
