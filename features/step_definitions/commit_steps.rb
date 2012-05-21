def generate_commits
  # Grit::Repo.any_instance.stub(:commits).and_return(commits)
end

def generate_synched_commits count
  case count
  when "no" then Commit.delete_all
  else count.to_i.times{ |i| FactoryGirl.create(:commit) }
  end
end

Given /^there are commits in the repository$/ do
  generate_commits
end

Given /^there are (.*?) commits synched$/ do |count|
  generate_synched_commits count
end

Given /^the commits have been synched$/ do
  Commit.delete_all
  Commit.sync
end

When /^I visit the homepage$/ do
  visit root_path
end

When /^I sync with the repository$/ do
  click_link "sync commit list"
end

When /^I reset and sync with the repository$/ do
  click_link "reset and sync"
  page.driver.browser.switch_to.alert.accept 
end

When /^I skip a commit from review$/ do
  click_link "skip review"
end

When /^I review a commit$/ do
  click_link "review"
end

When /^I (accept|reject|restart) a commit$/ do |action|
  case action 
  when "accept"
    click_link "review"
    click_link "accept"
  when "reject"
    click_link "review"
    click_link "reject"
  end
end

Then /^I should see the (.*?) button for the commit$/ do |text|
  selector = case text.downcase
  when "accept"  then "accept"
  when "reject"  then "reject"
  when "restart" then "restart"
  end
  find("a.#{selector}").should be_visible
end

Then /^I should see no commits$/ do
  page.should_not have_selector(".commit")
end

Then /^there are (.*?) commits recorded in (new|reject|accept|review) state$/ do |expected, state|
  expected = (expected == "no") ? 0 : expected.to_i
  actual = case state
    when 'review' then Commit.in_review.count
    when 'accept' then Commit.accepted.count
    when 'reject' then Commit.rejected.count
    when 'new'    then Commit.new_commits.count
  end
  actual.should == expected
end

Then /^I should see a list of new commits$/ do
  page.should have_selector(".commit.new")
end
