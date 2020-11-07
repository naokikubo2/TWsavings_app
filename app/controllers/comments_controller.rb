class CommentsController < ApplicationController

  before_action :set_savings_record

  def create
    @savings_record.comments.new(comment_params).save
    render :remote_js
  end

  def destroy
    @savings_record.comments.destroy(params[:id])
    render :remote_js
  end

  private

    def set_savings_record
      @savings_record = SavingsRecord.find_with_comments(params[:savings_record_id])
    end

    def comment_params
      params.require(:comment).permit(:content).merge(user_id: current_user.id)
    end


end
