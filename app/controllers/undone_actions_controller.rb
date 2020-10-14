class UndoneActionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_undone_action, only: [:show, :edit, :update, :destroy]
    before_action :check_role, only: [:edit, :update, :destroy]

    def new
        @undone = current_user.undone_actions.build
    end
    def create
        @undone = current_user.undone_actions.build(undone_actions_params)
        if @undone.save
            flash[:notice] = "UndoneAction was successfully created"
            redirect_to root_url
        else
            render 'new'
        end
    end
    def edit
        @undone = current_user.undone_actions.find_by(id: params[:id])
    end
    def update
        @undone = current_user.undone_actions.find_by(id: params[:id])
        @undone.update(undone_actions_params)
        if @undone.save
            redirect_to root_url
        else
            render 'show'
        end
    end
    def destroy
        @undone = current_user.undone_actions.find_by(id: params[:id])
        @undone.destroy
        flash[:notice] = "UndoneAction was successfully destroyed"
        redirect_to root_url
    end



    private

    def set_undone_action
        @undone = UndoneAction.find_by(id: params[:id])
    end

    def check_role
      redirect_to root_url unless @undone.user_id == current_user.id
    end

    def undone_actions_params
      params.require(:undone_action).permit(:action_name, :default_time).merge({ user_id: current_user.id })
    end

end
