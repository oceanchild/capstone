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

    @note = []
    @pillInstance = []
    _myPatient.each do |_myPatient|
      @note[_myPatient.patient_id] = Note.find_by_sql(["select * from notes where patient_id = ? order by date_created", _myPatient.patient_id])
    end

    #the following code is not efficient, but it works well
    @noteAuthor = []
    _allContact = User.all
    _allContact.each do |_contact|
      @noteAuthor[_contact.id] = _contact.first_name + " " + _contact.last_name
    end

    @primaryContact = []
    _myPatient.each do |_myPatient|
      @primaryContact[_myPatient.patient_id] = User.find_by_sql(["select c.first_name, c.last_name, c.phone, c.address from users as c, associations as j where c.id=j.user_id and j.patient_id=? and c.usertype='Guardian'", _myPatient.patient_id])
    end

    @prescription = Prescription.find_by_sql(["select p.direction, p.servings_per_day, p.quantities_per_serving, p.start_date, p.end_date, s.name, u.first_name, u.last_name from prescriptions as p, pills as s, users as u where p.pill_id = s.id and p.doctor_id = u.id"])
  
    @allPills = Pill.find_by_sql(["select id, name from pills"])
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
  end

  def destroy
  end
end
