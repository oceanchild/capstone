class NotesController < ApplicationController
  def new
  	@note = Note.new
  end

  def create
  	@note = Note.new(params[:note])
  	@note.save
  	redirect_to :controller => 'users', :action => 'index'
  end
end
