class PatientsController < ApplicationController
  def index
    redirect_to root_path
  end
  
  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(params[:patient])
    if @patient.save
      @patient.associations.create(:patient_id => @patient.id, :user_id => session[:user_id])
      render :inline => '<input type="hidden" id="return_patient_id" value="' + @patient.id.to_s + '" />'
    else
      flash.now.alert = 'Create patient failed, please try again.'
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
    # @ids = params[:patient_ids]
    # @ids.each do |id|
    # end
    if Patient.delete(params[:patient_ids])
      render :inline => '<input type="hidden" id="return-status" value="success" />'
    else
      flash.now.alert = 'Destroy patient failed, please try again.'
      render :nothing => true
    end
  end
end
