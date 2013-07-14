module WKCheck
  class Stats
    def study_queue
      queue = Wanikani::StudyQueue.queue
      lessons = queue["lessons_available"]
      reviews = queue["reviews_available"]
      next_review_date = Time.at(queue["next_review_date"]).localtime.strftime("%A, %B %-d at %-l:%M %p")
      queue_message(lessons, reviews, next_review_date)
    end

    def level_progression
      progress = Wanikani::Level.progression
      message = "Your progress for level #{progress["current_level"]}:\n".color(:green)
      message += progression_message(progress, "radicals")
      message += progression_message(progress, "kanji")
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
        message += "\nYou have more reviews coming your way on #{next_review_date.bright.color(:green)}." unless reviews.zero?
        message
      end
    end

    def progression_message(progress, group)
      percent = ((progress["#{group}_progress"].to_f / progress["#{group}_total"].to_f) * 100).round(1).to_s
      "#{progress["#{group}_progress"]} out of #{progress["#{group}_total"]} #{group.capitalize} (#{percent.bright}%)\n".color(:cyan)
    end
  end
end
