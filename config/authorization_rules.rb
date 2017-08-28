authorization do
 role :admin do
 	has_permission_on :admins, :to => [:index,:doctorview,:patientview,:bedview,:registration,:deletebed,:newbed,:newbedsave,:newward,:newwardsave,:deleteroom,:newregistration,:saveregistration,:deleteregistration,:ajax_view_beds]
  has_permission_on [:departments], :to=>[:new,:create,:index]
  has_permission_on [:doctors], :to=>[:new,:create,:destroy]
  has_permission_on [:patients], :to=>[:destroy]
   has_permission_on [:users], :to=>[:logout]
 end
 
 role :patient do
   	has_permission_on :patients, :to => [:index,:edit,:update,:viewappointments,:newappointments,:showavailabledoctors,:save_appointments,:delete_appointments]
    has_permission_on [:users], :to=>[:logout]
   
 end
 role :doctor do
   has_permission_on :doctors, :to => [:index,:edit,:update,:appointmentsview]
    has_permission_on [:users], :to=>[:logout]
 end
end
