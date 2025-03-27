class PatientsController < ApplicationController
  load_and_authorize_resource

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      success_response({patient: @patient.as_json(except: [:created_at, :updated_at])}, 200)
    else
      error_response(@patient.errors.as_json, 422)
    end
  end

  def update
    if @patient.update(patient_params)
      success_response({patient: @patient.as_json(except: [:created_at, :updated_at])}, 200)
    else
      error_response(@patient.errors.as_json, 422)
    end
  end

  def show
    success_response({patient: @patient.as_json(except: [:created_at, :updated_at])}, 200)
  end

  def index
    success_response({patient: @patients.as_json(except: [:created_at, :updated_at])}, 200)
  end

  def destroy
    
  end

  private

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :age, :contact, :problem)
  end
end

