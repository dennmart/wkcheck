require 'yaml'
require 'slop'
require 'wanikani'

CONFIG_FILE = "#{Dir.home}/.wanikani_check.yml"

opts = Slop.parse(help: true) do
  banner "Usage: wanikani_check.rb [options]"

  on "api_key=", "Saves your WaniKani API Key to #{CONFIG_FILE}"
end

unless opts[:api_key].nil? || opts[:api_key].empty?
  File.open(CONFIG_FILE, 'w') { |f| f.write({ api_key: opts[:api_key] }.to_yaml) } unless opts[:api_key].nil?
  puts "WaniKani API Key saved to #{CONFIG_FILE}!"
  exit
end

api_key = if File.exists?(CONFIG_FILE)
            config = YAML.load_file(CONFIG_FILE)
            config[:api_key]
          end

if api_key.nil? || api_key.empty?
  puts "You must first save your WaniKani API Key using the --api-key flag."
  exit
end

Wanikani.api_key = api_key

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
