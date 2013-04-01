class NotesController < ApplicationController
  def new
  	@note = Note.new
  end

  def create
  	@note = Note.new(params[:note])
  	if @note.save
      render :inline => '<input type="hidden" id="return-status" value="success" />'
    else
      flash.now.alert = 'Destroy patient failed, please try again.'
      render :nothing => true
    end
  end
end
