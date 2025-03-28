class PatientsController < ApplicationController
  load_and_authorize_resource

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      success_response({patient: @patient.as_json(except: [:created_at, :updated_at, :deleted])}, 200)
    else
      error_response(@patient.errors.as_json, 422)
    end
  end

  def update
    if @patient.update(patient_params)
      success_response({patient: @patient.as_json(except: [:created_at, :updated_at, :deleted])}, 200)
    else
      error_response(@patient.errors.as_json, 422)
    end
  end

  def show
    success_response({patient: @patient.as_json(except: [:created_at, :updated_at, :deleted])}, 200)
  end

  def index
    success_response({patient: @patients.as_json(except: [:created_at, :updated_at, :deleted])}, 200)
  end

  def destroy # Soft delete without actually deleting record
    if @patient.update_attribute(:deleted, true)
      success_response({}, 200, "Patient deleted successfully")
    else
      error_response({error_key: "Something went wrong" }, 422)
    end
  end

  def patient_graph
    start_date = params[:start_date] || 1.month.ago
    end_date = params[:end_date] || Time.current

    patient_count = Patient.where(created_at: start_date..end_date)
                          .group_by_day(:created_at)
                          .count
    success_response({statistics: patient_count})
  end

  private

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :age, :contact, :problem, :appointment)
  end
end

