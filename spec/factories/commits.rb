FactoryGirl.define do
  factory :commit do
    refid       '10cec06442d639fa8550e49a69df1ff177252b12'
    author      'Joe Developer'
    message     'Bug fix for TPS module'
    commit_date Date.today
    accepted    nil
    is_new      true
  end
end