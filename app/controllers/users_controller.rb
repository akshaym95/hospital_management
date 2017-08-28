class UsersController < ApplicationController
  before_filter :identifysession, :only=>:index
  
  def index
    @user=User.new
  end

  def validation
    @user = User.first(:conditions => ["username = ?", params[:user][:username]])
    if @user.present?
      hash = @user.password_hash.to_s
      hash=BCrypt::Password.new(hash)
      if hash == params[:user][:password]
        session[:current_user_id]=@user.id
        if session[:current_user_id].present?
          @user=User.find(session[:current_user_id])
          if @user.type.to_s=="Patient"
            redirect_to patients_path
          else if @user.type.to_s=="Doctor"
                  redirect_to doctors_path
               else if @user.type.to_s=="Admin"
                  redirect_to admins_path     
                    else
                  redirect_to users_path
                    end
               end 
          end
        end
      else
        flash[:notice]=" Invalid Password"
        redirect_to users_path
      end
    else
      flash[:notice]="Invalid Username"
      redirect_to users_path
    end
  end
  
  def signup
    @patient=Patient.new
  end
  
  def identifysession
    if session[:current_user_id].present?
      @user=User.find(session[:current_user_id])
      if @user.type.to_s=="Patient"
        redirect_to patients_path
      else if @user.type.to_s=="Doctor"
              redirect_to doctors_path
           else if @user.type.to_s=="Admin"
                redirect_to admins_path
                end
           end
      end
    end
  end
     
  def logout
    session[:current_user_id]=nil
    redirect_to users_path
  end
  
end