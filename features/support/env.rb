require 'aruba/cucumber'

# Set the bin directory in PATH so we can easily execute it.
ENV['PATH'] = File.expand_path('../../bin', File.dirname(__FILE__)) + File::PATH_SEPARATOR + ENV['PATH']

Before do
  # Since we save the .wkcheck.yml file in the home directory,
  # let's temporarily set the home directory to /tmp.
  @original_homedir = ENV['HOME']
  tmp_homedir = File.join('/tmp')
  FileUtils.rm_rf(tmp_homedir, :secure => true)
  ENV['HOME'] = tmp_homedir
end

After do
  # Revert the temporary home directory.
  ENV['HOME'] = @original_homedir
end
