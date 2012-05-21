def generate_commits
  #Grit::Repo.any_instance.stub(:commits).and_return(commits)
end

def generate_synched_commits number
  case number 
  when "no" then Commit.delete_all
  else number.to_i.times{ |i| FactoryGirl.create(:commit) }
  end
end

Given /^there are commits in the repository$/ do
  generate_commits
end

Given /^there are "(.*?)" commits synched$/ do |arg1|
  generate_synched_commits arg1
end

When /^I visit the homepage$/ do
  visit root_path
end

When /^I sync with the repository$/ do
  click_link "Sync Commit List"
end

Then /^I should see a list of commits$/ do
  page.should have_selector(".new.commit")
end
