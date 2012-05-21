FactoryGirl.define do
  sequence :refid do |n|
    "refid #{n}"
  end
  
  sequence :message do |n|
    "Commit message #{n}"
  end
  
  factory :commit do
    refid
    message
    author      'Joe Developer'
    commit_date Time.now
    accepted    nil
    is_new      true
  end
end