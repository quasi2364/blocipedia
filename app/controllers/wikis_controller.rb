class WikisController < ApplicationController
  def index
  	@wikis = Wiki.visible_to(current_user)
  end

  def show
  	@wiki = Wiki.find(params[:id])
  end

  def edit
  	@wiki = Wiki.find(params[:id])
  end

  def update
  	@wiki = Wiki.find(params[:id])
  	@wiki.update_attributes(wiki_params)
  	redirect_to @wiki
  end

  def new
  	@wiki = Wiki.new
  end

  def create
  	@wiki = Wiki.new(wiki_params)
  	@wiki.user = current_user
  	@wiki.save
  	redirect_to @wiki
  end

  def destroy
  	@wiki = Wiki.find(params[:id])
  	@wiki.destroy
  	redirect_to wikis_path
  end

  private

  def wiki_params
  	params.require(:wiki).permit(:title, :body, :private)
  end
end
