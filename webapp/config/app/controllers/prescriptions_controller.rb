class PrescriptionsController < ApplicationController
  def new
  	@prescription = Prescription.new
  end

  def create
  	@prescription = Prescription.new(params[:prescription])
  	@prescription.save
  	redirect_to :controller => 'users', :action => 'index'

	# @patient = Patient.new(params[:patient])
 #    if @patient.save
 #      @patient.associations.create(:patient_id => @patient.id, :user_id => session[:user_id])
 #      render :inline => '<input type="hidden" id="return_patient_id" value="' + @patient.id.to_s + '" />'
 #    else
 #      flash.now.alert = 'Create patient failed, please try again.'
 #      render 'new'
 #    end
  end

  def destroy
  end
end
