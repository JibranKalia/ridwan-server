class ClassroomsController < ApplicationController
  def index
    @classrooms = policy_scope(Classroom)
    render json: @classrooms
  end

  def show
    @classroom = Classroom.find(params[:id])
    authorize @classroom
    render json: @classroom
  end

  def create
    @classroom = Classroom.new(resource_params)
    authorize @classroom
    @classroom.save
    render json: @classroom
  end

  def destroy
    @classroom = Classroom.find(params[:id])
    authorize @classroom
    @classroom.destroy
    render json: @classroom
  end

  private

  def permitted_attributes
    %i[name user]
  end

  def resource_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: permitted_attributes)
  end
end
