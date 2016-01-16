class WikisController < ApplicationController
  before_action :authenticate_user!
  
  def index
  	@wikis = policy_scope(Wiki)
  end

  def show
  	@wiki = Wiki.find(params[:id])
    @collaborator = Collaborator.new
  end

  def edit
  	@wiki = Wiki.find(params[:id])
    @collaborators = @wiki.collaborators
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
    if @wiki.save
      if params[:collaborators]
        create_collaborators(params[:collaborators])
      end
      flash[:notice] = "Your Wiki was successfully created!"
      redirect_to @wiki 
    else
      flash[:error] = "There was an error saving your Wiki. Please try again"
      render :new
    end
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

  def create_collaborators(collaborators_emails_string)
    collaborators_emails_string.delete(' ').split(",").map do |collaborator_email|
      user = User.find_by(email: collaborator_email)
      Collaborator.find_or_create_by(wiki: @wiki, user: user)
    end
  end

  def emails_string_to_users_array(emails_string)
    emails_string.split(',').map do |email|
      User.find_by(email: email)
    end
  end
end
