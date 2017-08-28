class DepartmentsController < ApplicationController
  filter_access_to :all
  def new
    @department=Department.new
  end
  def create
    @department=Department.new(params[:department])
    if @department.save
      redirect_to departments_path
    else
      render  'departments/new'
    end
  end

  def edit
  end

  def index
    @departments=Department.all
  end

end