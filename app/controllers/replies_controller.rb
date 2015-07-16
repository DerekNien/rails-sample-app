class RepliesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @reply = @micropost.replies.build(reply_params)
    if @reply.save
      flash[:success] = "Reply created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @reply.destroy
    flash[:success] = "Reply deleted"
    redirect_to request.referrer || root_url
  end

  private
  def reply_params
    params.require(:reply).permit(:content)
  end

  def correct_user
    @reply = current_user.replies.find_by(id: params[:id])
    redirect_to root_url if @reply.nil?
  end
end
