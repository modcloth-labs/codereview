require 'grit'

class Commit < ActiveRecord::Base
  def self.get_list
    list = []
    repo = Grit::Repo.new('/Users/edu/lib/modcloth/dsc/ecomm/sphere_dsc_filter')
    repo.commits('sphere_dsc_filter',100).select{|c| c.message.include? '[DSC]'}
  end
end
