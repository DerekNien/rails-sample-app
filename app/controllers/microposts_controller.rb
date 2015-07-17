class MicropostsController < ApplicationController
  include MicropostsHelper
  before_action :logged_in_user, only: [:create, :destroy, :upvote, :downvote]
  before_action :correct_user, only: :destroy
  before_action :votable, only: [:upvote, :downvote]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  # def like
  #   @micropost = Micropost.find(params[:id])
  #   @micropost.upvote += 1
  #   if @micropost.save
  #     redirect_to root_url
  #   else
  #     render 'static_pages/home'
  #   end
  # end

  def upvote
    create_new_vote
    @vote.up_or_down = true
    @micropost.upvote += 1
    if @micropost.save && @vote.save
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def downvote
    create_new_vote
    @vote.up_or_down = false
    @micropost.downvote += 1
    if @micropost.save && @vote.save
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  private
    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

    def create_new_vote
      @micropost = Micropost.find(params[:id])
      @vote = Vote.new
      @vote.user = current_user
      puts @vote.inspect
      @vote.post_id = @micropost.id
      puts @vote.inspect
    end

    def votable
      unless votable?(params[:micropost_id])
        redirect_to root_url
      end
    end
end
