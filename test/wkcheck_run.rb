# wkcheck integration test with real calls.
require 'rainbow'

print "Running #{Rainbow('wkcheck -h').yellow.bright}... "
`wkcheck -h`
puts Rainbow("GOOD!").green.bright

print "Running #{Rainbow('wkcheck -v').yellow.bright}... "
`wkcheck -v`
puts Rainbow("GOOD!").green.bright

print "Running #{Rainbow('wkcheck -q').yellow.bright}... "
`wkcheck -q`
puts Rainbow("GOOD!").green.bright

print "Running #{Rainbow('wkcheck -l').yellow.bright}... "
`wkcheck -l`
puts Rainbow("GOOD!").green.bright

