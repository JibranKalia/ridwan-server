# frozen_string_literal: true

class LessonsController < ApplicationController
  def index
    @lessons = policy_scope(Lesson)
    @lessons.order(name: :desc)
    render json: @lessons
  end

  def show
    @lesson = Lesson.find(params[:id])
    authorize @lesson
    render json: @lesson, include: %i[enrollments students]
  end

  def create
    @lesson = Lesson.new(resource_params)
    authorize @lesson
    if @lesson.save
      render json: @lesson
    else
      render json: @lesson, status: :unprocessable_entity, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  def update
    @lesson = Lesson.find(params[:id])
    authorize @lesson
    if @lesson.update(resource_params)
      render json: @lesson
    else
      render json: @lesson, status: :unprocessable_entity, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  def destroy
    @lesson = Lesson.find(params[:id])
    authorize @lesson
    @lesson.destroy
    render json: @lesson
  end

  private

  def permitted_attributes
    %i[date enrollment]
  end

  def resource_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: permitted_attributes)
  end
end
