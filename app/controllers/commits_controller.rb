class CommitsController < ApplicationController
  def index
    @new_commits      = Commit.new_commits
    @rejected_commits = Commit.rejected
  end

  def edit
    action, refid = params.values_at(:edit_type, :refid)
    if commit = Commit.find_by_refid(params[:refid])
      commit.send(:"#{action}!")
    end
    render :js => "codereview.#{action}('#{refid}')"
  end

  def start_review
    refid = params[:refid]
    if commit = Commit.find_by_refid(refid)
      commit.review!
    end
    render :js => "codereview.start_review('#{refid}')"
  end
  
  def sync
    Commit.sync
    redirect_to commits_path
  end
  
  def erase
    Commit.restart
    Commit.sync
    redirect_to commits_path
  end
end
