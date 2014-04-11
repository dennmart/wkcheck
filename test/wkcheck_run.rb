# wkcheck integration test with real calls.
require 'rainbow'

error = false

%w(-h -v -q -l).each do |switch|
  command = "wkcheck #{switch}"
  puts "Running #{Rainbow(command).yellow.bright}... "

  begin
    puts `wkcheck #{switch}`
    puts Rainbow("GOOD!").green.bright
  rescue
    puts Rainbow("ERROR!").red.bright
    error = true
  end
  puts "----------------------------------------"
end

if error
  puts Rainbow("There was an error on one or more commands - please run the commands manually to see what happened...").red
else
  puts Rainbow("All commands are green, you're good to go!").green
end
