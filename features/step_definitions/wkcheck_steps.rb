Given(/^the file "(.*?)" doesn't exist in the home directory$/) do |file|
  FileUtils.rm("#{Dir.home}/.wkcheck.yml") if File.exists?("#{Dir.home}/.wkcheck.yml")
end

Then(/^the file "(.*?)" should exist in the home directory$/) do |file|
  File.exists?("#{Dir.home}/.wkcheck.yml").should be_true
end

Then(/^contain the API key "(.*?)"$/) do |api_key|
  config_file = YAML.load(File.read("#{Dir.home}/.wkcheck.yml"))
  config_file[:api_key].should == api_key
end
