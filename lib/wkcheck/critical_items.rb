module WKCheck
  class CriticalItems
    def initialize(percentage)
      @percentage = (percentage || 75).to_i
    end

    def critical_items
      critical = Wanikani::CriticalItems.critical(@percentage).sort_by { |item| item["type"] }

      summary =  Rainbow("Your Critical Items - Max percentage: #{@percentage} ").bright.white
      summary += "(#{Rainbow('Kanji').red}, #{Rainbow('Radicals').cyan}, #{Rainbow('Vocabulary').magenta}):\n"
      summary += critical.map { |item| send("#{item["type"]}_info", item) }.compact.join("\n")
    end

    private

    def kanji_info(item)
      important_reading = item["important_reading"]
      "#{Rainbow(item["character"]).red} #{Rainbow("(#{item[important_reading]})").red} - #{item["meaning"]}"
    end

    def vocabulary_info(item)
      "#{Rainbow(item["character"]).magenta} #{Rainbow("(#{item["kana"]})").magenta} - #{item["meaning"]}"
    end

    def radical_info(item)
      return nil if item["character"].nil?
      "#{Rainbow(item["character"]).cyan} - #{item["meaning"]}"
    end
  end
end
