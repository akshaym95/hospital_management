class AdminsController < ApplicationController
  filter_access_to :all
  def index
  end
  
  def doctorview
    @doctors=Doctor.all
	end
  
  def patientview
    @patients=Patient.all
	end
  
  def bedview
    @rooms=Room.all
    @beds=Bed.all
	end
  
	def registration
      @registration=Registration.all
      
  end
  
  def deletebed
    @bed = bed.find(params[:id])
    bed.destroy
    redirect_to bedview_admins_path
  end
  
  def newbed
    @bed = Bed.new
 	end
  
  def newbedsave
    @bed = Bed.new(params[:bed])
  	if @bed.save		   
  	  redirect_to bedview_admins_path
   	else
      render 'admins/newbed'
    end
	end
  
  def newward
    @room=Room.new
  end
  
  def newwardsave
    @room = Room.new(params[:room])
  	if @room.save
  	  redirect_to bedview_admins_path
    else
      render 'admins/newward'
    end
	end
  
  def deleteroom
    @room = Room.find(params[:id])
  	@room.destroy
    redirect_to bedview_admins_path
  end
  
  def newregistration
    @registration=Registration.new
    @patients=Patient.all
    @rooms=Room.all
  end
  def saveregistration
    start_date=DateTime.new(params[:registration]["start_time(1i)"].to_i,
      params[:registration]["start_time(2i)"].to_i,
      params[:registration]["start_time(3i)"].to_i,
      params[:registration]["start_time(4i)"].to_i,
      params[:registration]["start_time(5i)"].to_i)
    end_date=DateTime.new(params[:registration]["end_time(1i)"].to_i,
      params[:registration]["end_time(2i)"].to_i,
      params[:registration]["end_time(3i)"].to_i,
      params[:registration]["end_time(4i)"].to_i,
      params[:registration]["end_time(5i)"].to_i)
    @registration=Registration.new(:patient_id=>params[:registration][:patient_id],
      :bed_id=>params[:registration][:bed_id],
      :start_time=>start_date,:end_time=>end_date)
    if @registration.save
      redirect_to registration_admins_path
    else
      render 'admins/newregistration'
    end
  end
  
  def deleteregistration
    @reg = Registration.find(params[:id])
  	@reg.destroy
    redirect_to registration_admins_path
  end
  def ajax_view_beds
    room_id=params[:room_id]
    start_time= params[:start_time]
    end_time= params[:end_time]
    @currentregistration= Registration.all(:conditions => [ "
      ((? BETWEEN start_time AND end_time )OR (? BETWEEN start_time AND end_time)
      OR(start_time<=? AND end_time>=?)OR(?<=start_time AND ? >=end_time))",
      start_time,end_time,start_time,end_time,start_time,end_time])
    @bed_ids=@currentregistration.collect(&:bed_id)
    if @bed_ids.present?
      @beds=Bed.find(:all,:conditions=>["id NOT in (?) AND room_id in (?)",
             @bed_ids,room_id])
    else
      @beds=Bed.all(:conditions=>["room_id in (?)",room_id])
    end
    render :partial=>'showfreebeds',:locals=>{:patient_id=>params[:patient_id]}
  end
 
end