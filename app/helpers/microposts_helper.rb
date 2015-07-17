module MicropostsHelper
  def votable?(micropost_id)
    @vote = Vote.find_by_user_id_and_post_id(current_user.id, micropost_id)
    @vote.nil?
  end
end
