class UsersController < ApplicationController
  def index
    if session[:user_id]==nil
      return redirect_to root_path
    end
    
    _current_id = session[:user_id]
    @user = User.find(_current_id)

    _myPatient = Association.find_by_sql(["select patient_id from associations where user_id = ?", _current_id.to_i])
    @patient = Patient.find_by_sql(["select * from patients, associations where patients.id=associations.patient_id and associations.user_id = ? order by id", _current_id.to_i])

    @numPatient = @patient.count

    @note = {}
    _myPatient.each do |_myPatient|
      @note[_myPatient.patient_id] = Note.find_by_sql(["select n.content, n.date_created, u.last_name, u.first_name, n.author_id, u.avatar from notes as n, users as u where n.patient_id = ? and u.id = n.author_id order by n.date_created asc", _myPatient.patient_id])
    end

    @primaryContact = {}
    _myPatient.each do |_myPatient|
      @primaryContact[_myPatient.patient_id] = User.find_by_sql(["select c.first_name, c.last_name, c.phone, c.address from users as c, associations as j where c.id=j.user_id and j.patient_id=? and c.usertype='Guardian'", _myPatient.patient_id])
    end

    @prescription={}
    _myPatient.each do |_myPatient|
      @prescription[_myPatient.patient_id] = Prescription.find_by_sql(["select u.first_name as ufn, u.last_name as uln, pa.first_name as pfn, pa.last_name as pln, p.direction, p.servings_per_day, p.quantities_per_serving, p.start_date, p.end_date, pills.name from users as u, patients as pa, prescriptions as p, pills where p.doctor_id=u.id and p.patient_id=pa.id and pills.name=p.pill_name and pa.id=?", _myPatient.patient_id])
    end

    @allPills = Pill.find_by_sql(["select name from pills"])

    # @heartRate = HeartRate.find_by_sql(["select h.pulse, time(m.last_updated) as last_updated from heart_rates as h, monitored_status as m, associations as a where h.monitored_status_id = m.id and m.patient_id = a.patient_id and a.user_id", _current_id.to_i]).collect{|x| [x.pulse, x.last_updated]}
    @heartRate = HeartRate.find_by_sql(["select m.patient_id, floor(avg(h.pulse)) as pulse, time(m.last_updated) as last_updated from heart_rates as h, monitored_status as m, associations as a where h.monitored_status_id = m.id and m.patient_id = a.patient_id and a.user_id = ? group by patient_id", _current_id.to_i])

    #doctors for each patient
    @doctorForPatient={}
    _myPatient.each do |_myPatient|
      @doctorForPatient[_myPatient.patient_id] = User.find_by_sql(["select u.first_name, u.last_name from associations as a, users as u where patient_id = ? and a.user_id = u.id and u.usertype = 'Doctor'", _myPatient.patient_id])
    end

  end

  def new
    if session[:user_id]!=nil
      redirect_to root_path
    end
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash.now.alert = "Registration failed, please try again."
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    @user = User.find(session[:user_id])
    @user.update_attributes(params[:user])
    redirect_to root_path
  end

  def destroy
  end
end
