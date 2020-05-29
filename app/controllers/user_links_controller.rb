class UserLinksController < ApplicationController
  include UserLinksHelper

  before_action :set_user_link, only: [:show, :update, :delete]

  def index
    @user_links = UserLink.eager_load(:user_link_tags, :tags, :link, :user, :user_link_stars).order(created_at: :desc).page(params[:page]).per(PER)
    render json: to_responses(@user_links)
  end

  # GET /user_links/1
  def show
    render json: to_response(@user_link)
  end

  # POST /user_links
  def create
    url = user_link_params[:url]
    url = "https://#{url}" unless url&.starts_with?('http') 
    @user_link = ::Service::LinkRegister.call(url: url)
    if @user_link.save
      render json: @user_link, status: :created
    else
      render json: @user_link.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_links/1
  def delete
    @user_link.destroy
    render json: {deleted: true}
  end

  def rating
    user_link_star = UserLinkStar.find_or_initialize_by(user_link_id: params[:id])
    user_link_star.kind = 1
    user_link_star.value = params[:user_link][:value]
    user_link_star.save
    render json: {}, status: :ok
  end

  def note
    user_link_note = UserLinkNote.find_or_initialize_by(user_link_id: params[:id])
    user_link_note.body = params[:user_link][:note]
    user_link_note.save
    render json: {}, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_link
      @user_link = UserLink.eager_load(:user_link_tags, :tags, :user_link_note, :user_link_stars, :link, :user).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_link_params
      params.require(:user_link).permit(:url)
    end
end
