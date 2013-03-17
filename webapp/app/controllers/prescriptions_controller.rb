class PrescriptionsController < ApplicationController
  def new
  	@prescription = Prescription.new
  end

  def create
    _date_list = params[:prescription][:start_date].split('-')
    params[:prescription][:start_date] = DateTime.new(_date_list[2].to_i, _date_list[0].to_i, _date_list[1].to_i)
    _date_list = params[:prescription][:end_date].split('-')
    params[:prescription][:end_date] = DateTime.new(_date_list[2].to_i, _date_list[0].to_i, _date_list[1].to_i)
    # return render :inline => _date_list.inspect
    # params[:prescription][:start_date] = params[:prescription][:start_date].to_date
    # return render :inline => params[:prescription][:start_date].inspect
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
