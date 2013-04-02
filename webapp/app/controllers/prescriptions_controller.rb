class PrescriptionsController < ApplicationController
  def new
  	@prescription = Prescription.new
  end

  def create
    _date_list = params[:prescription][:start_date].split('-')
    params[:prescription][:start_date] = DateTime.new(_date_list[2].to_i, _date_list[0].to_i, _date_list[1].to_i)
    _date_list = params[:prescription][:end_date].split('-')
    params[:prescription][:end_date] = DateTime.new(_date_list[2].to_i, _date_list[0].to_i, _date_list[1].to_i)
  	@prescription = Prescription.new(params[:prescription])
  	if @prescription.save
      render :inline => '<input type="hidden" id="return-status" value="success" />'
    else
      flash.now.alert = 'Destroy patient failed, please try again.'
      render :nothing => true
    end
  end

  def destroy
  end
end
