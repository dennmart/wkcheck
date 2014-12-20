Given(/^the file "(.*?)" doesn't exist in the home directory$/) do |file|
  FileUtils.rm("#{Dir.home}/.wkcheck.yml") if File.exists?("#{Dir.home}/.wkcheck.yml")
end

Then(/^the file "(.*?)" should exist in the home directory$/) do |file|
  expect(File.exists?("#{Dir.home}/.wkcheck.yml")).to be_truthy
end

Then(/^contain the API key "(.*?)"$/) do |api_key|
  config_file = YAML.load(File.read("#{Dir.home}/.wkcheck.yml"))
  expect(config_file[:api_key]).to eq(api_key)
end
