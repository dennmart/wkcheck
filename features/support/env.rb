require 'aruba/cucumber'
require 'mocha/api'

# Set the bin directory in PATH so we can easily execute it.
ENV['PATH'] = File.expand_path('../../bin', File.dirname(__FILE__)) + File::PATH_SEPARATOR + ENV['PATH']

# Set the constant for the config file path to /tmp for the test run.
WKCheck.const_set("CONFIG_FILE", "/tmp")
