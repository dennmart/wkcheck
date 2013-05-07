require 'wanikani'

Wanikani.api_key = ""

queue = Wanikani::StudyQueue.queue
lessons = queue["lessons_available"]
reviews = queue["reviews_available"]
next_review_date = Time.at(queue["next_review_date"])

if lessons.zero? && reviews.zero?
  puts "You have no lessons or reviews now! You'll have some more on #{next_review_date}."
else
  puts "You have #{lessons.zero? ? "no" : lessons } lessons pending."
  puts "You have #{reviews.zero? ? "no" : reviews } reviews pending."
end
