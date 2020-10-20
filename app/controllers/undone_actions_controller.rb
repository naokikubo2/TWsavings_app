class UndoneActionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_undone_action, only: [:edit, :update, :destroy]
    before_action :check_role, only: [:edit, :update, :destroy]

    def new
        @undone = current_user.undone_actions.build
    end
    def create
        @undone = current_user.undone_actions.build(undone_actions_params)
        if @undone.save
            flash[:notice] = "不要行動の登録に成功しました"
            redirect_to root_url
        else
            flash[:error] = "不要行動の登録に失敗しました"
            render 'new'
        end
    end
    def edit
    end
    def update
        if @undone.update(undone_actions_params)
            flash[:notice] = "不要行動の更新に成功しました"
            redirect_to root_url
        else
            flash[:error] = "不要行動の更新に失敗しました"
            render 'edit'
        end
    end
    def destroy
        @undone.destroy
        flash[:notice] = "不要行動の削除に成功しました"
        redirect_to root_url
    end



    private

    def set_undone_action
        @undone = UndoneAction.find(params[:id])
    end

    def check_role
      redirect_to root_url unless @undone.user_id == current_user.id
    end

    def undone_actions_params
      params.require(:undone_action).permit(:action_name, :default_time).merge({ user_id: current_user.id })
    end

end
