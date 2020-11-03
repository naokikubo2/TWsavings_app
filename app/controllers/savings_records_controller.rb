class SavingsRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_savings_record, only: [:destroy]
  before_action :check_role, only: [:destroy]

  def new
    @savings_record = current_user.savings_records.build
  end

  def create
    @savings_record = current_user.savings_records.build(savings_records_params)
    @savings_record.savings_date = Date.today
      if @savings_record.save
          flash[:notice] = "貯金に成功しました"
          redirect_to new_savings_record_url
      else
          flash[:error] = "貯金に失敗しました"
          render 'new'
      end
  end

  def index
    @savings_records = SavingsRecord.where(user_id: current_user.id).order(created_at: :desc)
  end

  def destroy
    @savings_record.destroy
    flash[:notice] = "貯金履歴の削除に成功しました"
    redirect_to savings_records_url
  end

  private

  def set_savings_record
    @savings_record = SavingsRecord.find(params[:id])
  end

  def check_role
    redirect_to root_url unless @savings_record.user_id == current_user.id
  end

  def savings_records_params
    params.require(:savings_record).permit(:savings_name, :earned_time).merge({ user_id: current_user.id })
  end

end
