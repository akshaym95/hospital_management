class DoctorsController < ApplicationController
  filter_access_to :all
  def new
		@doctor = Doctor.new(params[:doctor])
	end
  
  def edit
    @doctor = Doctor.find(params[:id])
  end
  
  def update
    @doctor = Doctor.find(params[:id])
    if @doctor.update_attributes(params[:doctor])
      redirect_to doctors_path
    else
      render 'doctors/edit'
    end
  end
  
	def create
		 @doctor = Doctor.new(params[:doctor])
  	 if @doctor.save		   
  		 redirect_to doctorview_admins_path
     else    
       render 'doctors/new'
     end
	end
  
  def destroy
    @doctor = Doctor.find(params[:id])
  	@doctor.destroy
		redirect_to doctorview_admins_path
	end
  
  def index
    @doctor=Doctor.find(session[:current_user_id])
  end

  def appointmentsview
    @doctor=Doctor.find(params[:id])
    @appointments=@doctor.appointments.all(:order=>"appointment_date")
  end

end