class CollaboratorsController < ApplicationController

  def new	
  	@wiki = Wiki.find(params[:wiki_id])
  	@collaborator = Collaborator.new
  end

  def create
    @wiki = params[:wiki_id]

    if params[:collaborators]
      create_collaborators(params[:collaborators])
      flash[:notice] = "Your collaborators were succesfully added!"
      redirect_to :back 
    else
      flash[:error] = "Please enter at least one email address"
      redirect_to :back
    end
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    if @collaborator.destroy
      flash[:notice] = "Collaborator was deleted succesfully"
      redirect_to :back
    else
      flash[:error] = "There was an error deleting the post."
      render :show
    end
  end
end

def create_collaborators(collaborators_emails_string)
  collaborators_emails_string.delete(' ').split(",").map do |collaborator_email|
    user = User.find_by(email: collaborator_email)
    collaborator = Collaborator.find_or_create_by(wiki_id: @wiki, user: user)
    unless collaborator.save
      flash[:error] = "There was an error creating one of your collaborators."  
    end    
  end
end