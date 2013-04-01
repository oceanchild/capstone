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
    @pillInstance = {}
    _myPatient.each do |_myPatient|
      @note[_myPatient.patient_id] = Note.find_by_sql(["select n.content, n.date_created, u.last_name, u.first_name from notes as n, users as u where n.patient_id = ? and u.id = n.author_id order by n.date_created desc", _myPatient.patient_id])
    end

    #the following code is not efficient, but it works well
    @noteAuthor = {}
    _allContact = User.all
    _allContact.each do |_contact|
      @noteAuthor[_contact.id] = _contact.first_name + " " + _contact.last_name
    end

    @primaryContact = {}
    _myPatient.each do |_myPatient|
      @primaryContact[_myPatient.patient_id] = User.find_by_sql(["select c.first_name, c.last_name, c.phone, c.address from users as c, associations as j where c.id=j.user_id and j.patient_id=? and c.usertype='Guardian'", _myPatient.patient_id])
    end

    @prescription = Prescription.find_by_sql(["select u.first_name, u.last_name, pa.first_name, pa.last_name, p.direction, p.servings_per_day, p.quantities_per_serving, p.start_date, p.end_date, pills.name from associations as a, users as u, patients as pa, prescriptions as p, pills where u.id=? and a.user_id=u.id and a.patient_id=pa.id and p.patient_id=pa.id and pills.id=p.pill_id",_current_id.to_i])
  
    @allPills = Pill.find_by_sql(["select id, name from pills"])

    # @heartRate = HeartRate.find_by_sql(["select h.pulse, time(m.last_updated) as last_updated from heart_rates as h, monitored_status as m, associations as a where h.monitored_status_id = m.id and m.patient_id = a.patient_id and a.user_id", _current_id.to_i]).collect{|x| [x.pulse, x.last_updated]}
    @heartRate = HeartRate.find_by_sql(["select m.patient_id, floor(avg(h.pulse)) as pulse, time(m.last_updated) as last_updated from heart_rates as h, monitored_status as m, associations as a where h.monitored_status_id = m.id and m.patient_id = a.patient_id and a.user_id = ? group by patient_id", _current_id.to_i])

    #doctor for each patient
    #if patient id cannot be found in doctorForPatient, then there is no doctor assigned to this patient
    @doctorForPatient = User.find_by_sql(["select temp.patient_id, a.user_id, u.first_name, u.last_name,u.usertype from (select a.user_id, a.patient_id from users as u, associations as a where u.id = ? and u.id=a.user_id) as temp, associations as a, users as u where a.patient_id = temp.patient_id and u.id=a.user_id and u.usertype<>'Guardian' and u.usertype= 'Doctor' order by temp.patient_id", _current_id.to_i])
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
