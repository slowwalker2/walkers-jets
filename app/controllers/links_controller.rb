class LinksController < ApplicationController
  before_action :set_link, only: [:show, :update, :delete]

  # GET /links
  def index
    @links = Link.scan

    render json: @links
  end

  # GET /links/1
  def show
    render json: @link
  end

  # POST /links
  def create
    @link = Service::OgpCollector.call(url: link_params[:url])

    if @link.replace
      render json: @link, status: :created
    else
      render json: @link.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /links/1
  def update
    @link = Link.new(link_params)

    if @link.replace
      render json: @link, status: :ok
    else
      render json: @link.errors, status: :unprocessable_entity
    end
  end

  # DELETE /links/1
  def delete
    Link.delete(params[:id])
    render json: {deleted: true}
  end

  def new
  end
  
  def edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def link_params
      params.require(:link).permit(:url).to_h
    end
end
