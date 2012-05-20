class CommitsController < ApplicationController
  def index
    @new_commits      = Commit.new_commits
    @rejected_commits = Commit.rejected
  end

  def edit
    if @commit = Commit.find_by_refid(params[:refid])
      @commit.update_attributes(:accepted => (params[:edit_type] == 'accept'), :is_new => false)
    end
    render :js => "codereview.#{params[:edit_type]}('#{params[:refid]}')"
  end

  def start_review
    c = Commit.find_by_refid(params[:refid])
    c.update_attributes(:started => true, :accepted => nil)
    render :js => "codereview.start_review('#{params[:refid]}')"
  end
  
  def sync
    Commit.sync
    redirect_to commits_path
  end
  
  def erase
    Commit.restart
    redirect_to commits_path
  end
end
