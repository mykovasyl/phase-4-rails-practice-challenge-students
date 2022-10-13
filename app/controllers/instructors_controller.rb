class InstructorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  def index
    instructors = Instructor.all
    render json: instructors
  end

  def show
    instructor = find_instructor
    render json: instructor, with: InstructorWithStudentsSerializer
  end

  def create 
    new_instructor = Instructor.create!(instructor_params)
    render json: new_instructor, status: :created
  end

  def update
    instructor_to_update = find_instructor
    instructor_to_update.update(instructor_params)
    render json: instructor_to_update
  end

  def destroy
    instructor_to_destroy = find_instructor
    instructor_to_destroy.destroy
    head :no_content
  end

  private

  def find_instructor
    Instructor.find(params[:id])
  end

  def instructor_params
    params.permit(:name, :major, :age, :instructor_id)
  end

  def render_not_found
    render json: { error: "instructor not found" }, status: :not_found
  end

  def render_unprocessable_entity(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
