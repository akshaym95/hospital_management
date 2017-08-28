class PatientsController < ApplicationController
  filter_access_to :destroy,:index,:edit,:update,:viewappointments,
  :newappointments,:showavailabledoctors,:save_appointments,:delete_appointments
  def create
    @patient=Patient.new(params[:patient])
    if @patient.save
      session[:current_user_id]=@patient.id
      redirect_to identifysession_users_path
    else
      @patient.password=nil
      render 'users/signup'
    end
  end
  
  def destroy
    @patient = Patient.find(params[:id])
  	@patient.destroy
		redirect_to patientview_admins_path
	end
  
  def index
    @patient=Patient.find(session[:current_user_id])
  end
  
  def edit
    @patient = Patient.find(params[:id])
  end
  
  def update
    @patient = Patient.find(params[:id])
    if @patient.update_attributes(params[:patient])
      redirect_to  patients_path
    else
      render 'patients/edit'
    end
  end

  def viewappointments
    @patient = Patient.find(params[:id])
    @appointments=@patient.appointments.all
  end
  def newappointments
    @departments=Department.all
    @patient = Patient.find(params[:id])
    @appointment=@patient.appointments.build
  end
  
  def showavailabledoctors
    @appointment_date=params[:appoinment_date]
    dept_id=params[:department_id]
    appointment_date= params[:appointment_date]
    end_date= params[:appointment_date].to_time+params[:duration].to_i.minutes
    @department=Department.find(params[:department_id])
    @current_appointments=Appointment.all(:conditions=>[" 
      ((? BETWEEN appointment_date AND end_date ) 
                         OR (? BETWEEN appointment_date AND end_date )
                         OR(appointment_date<=? AND end_date>=?)
                          OR(?<appointment_date AND ? >end_date))",
            appointment_date,end_date,appointment_date,
            end_date,appointment_date,end_date])
        
    @doctor_ids=@current_appointments.collect(&:doctor_id)
    if @doctor_ids.present?
      @doctors=Doctor.find(:all,
       :conditions=>["id NOT in (?) AND department_id = ?",@doctor_ids,dept_id])
    else
      @doctors=Doctor.all(:conditions=>["department_id = ?",dept_id])
    end
    render :partial=>'showdoctors',
     :locals=>{:patient_id=>params[:patient_id],
     :appointment_date=>params[:appointment_date],:dur=>params[:duration]}
  end
  
  def save_appointments
    @date=DateTime.new(params[:appointment]["appointment_date(1i)"].to_i,
      params[:appointment]["appointment_date(2i)"].to_i,
      params[:appointment]["appointment_date(3i)"].to_i,
      params[:appointment]["appointment_date(4i)"].to_i,
      params[:appointment]["appointment_date(5i)"].to_i)
    @patient = Patient.find(params[:id])
    @appointment=@patient.appointments.build(:doctor_id=>params[:appointment][:doctor_id],
      :appointment_date=>@date,:duration=>params[:appointment][:duration])
    if @appointment.save
      redirect_to   patients_path
    else
      render :text =>"Appointment Not fixed"
    end
  end
  def delete_appointments
    @appo = Appointment.find(params[:id])
  	@appo.destroy
    redirect_to viewappointments_patient_path(session[:current_user_id])
  end
end