module WKCheck
  class Stats
    def study_queue
      if Wanikani::User.on_vacation?
        user_info = Wanikani::User.information
        vacation_date = Time.at(user_info["vacation_date"]).localtime.strftime("%A, %B %-d at %-l:%M %p")
        Rainbow("You are currently on vacation from WaniKani, starting from #{Rainbow(vacation_date).bright}.").green
      else
        queue = Wanikani::StudyQueue.queue
        lessons = queue["lessons_available"]
        reviews = queue["reviews_available"]
        next_review_date = Time.at(queue["next_review_date"]).localtime.strftime("%A, %B %-d at %-l:%M %p")
        queue_message(lessons, reviews, next_review_date)
      end
    end

    def level_progression
      progress = Wanikani::Level.progression
      message = Rainbow("Your progress for level #{progress["current_level"]}:\n").green
      message += progression_message(progress, "radicals")
      message += progression_message(progress, "kanji")
    end

    def random_kanji
      random_kanji = Wanikani::Level.kanji(random_level).sample
      message = Rainbow("Your random kanji is ").bright +  Rainbow(random_kanji['character']).bright.underline + "\n"
      message += Rainbow("Level: ").bright + random_kanji['level'].to_s + "\n"
      message += Rainbow("Meaning: ").bright + random_kanji['meaning'] + "\n"
      message += Rainbow("Reading (#{random_kanji['important_reading']}): ").bright + random_kanji[random_kanji['important_reading']]
    end

    def random_word
      random_word = Wanikani::Level.vocabulary(random_level).sample
      message = Rainbow("Your random word is ").bright +  Rainbow(random_word['character']).bright.underline + "\n"
      message += Rainbow("Level: ").bright + random_word['level'].to_s + "\n"
      message += Rainbow("Meaning: ").bright + random_word['meaning'] + "\n"
      message += Rainbow("Reading: ").bright + random_word['kana']
    end

    private

    def queue_message(lessons, reviews, next_review_date)
      if lessons.zero? && reviews.zero?
        message = Rainbow("You have no lessons or reviews now! You'll have some more on #{Rainbow(next_review_date).bright}.").green
      else
        lessons_msg = lessons.zero? ? Rainbow("no").green : Rainbow(lessons.to_s).red
        reviews_msg = reviews.zero? ? Rainbow("no").green : Rainbow(reviews.to_s).red
        message = "You have #{lessons_msg} lessons pending"
        message += "\nYou have #{reviews_msg} reviews pending"
        message += "\nYou have more reviews coming your way on #{Rainbow(next_review_date).bright.green}." if reviews.zero?
        message
      end
    end

    def progression_message(progress, group)
      percent = ((progress["#{group}_progress"].to_f / progress["#{group}_total"].to_f) * 100).round(1).to_s
      message = "#{progress["#{group}_progress"]} out of #{progress["#{group}_total"]} #{group.capitalize} ("
      message += Rainbow("#{percent}%").bright.cyan
      message += ")\n"
    end

    def random_level
      rand(1..50)
    end
  end
end
