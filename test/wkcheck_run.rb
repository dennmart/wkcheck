# wkcheck integration test with real calls.
require 'rainbow'

# Help message
print "Running #{Rainbow('wkcheck -h').yellow.bright}... "
begin
  `wkcheck -h`
  puts Rainbow("GOOD!").green.bright
rescue
  puts Rainbow("ERROR!").red.bright
  error = true
end

# Version display
print "Running #{Rainbow('wkcheck -v').yellow.bright}... "
begin
  `wkcheck -v`
  puts Rainbow("GOOD!").green.bright
rescue
  puts Rainbow("ERROR!").red.bright
  error = true
end

# Study Queue
print "Running #{Rainbow('wkcheck -q').yellow.bright}... "
begin
  `wkcheck -q`
  puts Rainbow("GOOD!").green.bright
rescue
  puts Rainbow("ERROR!").red.bright
  error = true
end

# Level Progression
print "Running #{Rainbow('wkcheck -l').yellow.bright}... "
begin
  `wkcheck -l`
  puts Rainbow("GOOD!").green.bright
rescue
  puts Rainbow("ERROR!").red.bright
  error = true
end

if error
  puts Rainbow("There was an error on one or more commands - please run the commands manually to see what happened...").red
else
  puts Rainbow("All commands are green, you're good to go!").green
end
