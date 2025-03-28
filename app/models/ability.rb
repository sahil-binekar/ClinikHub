# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    case user.role
    when 'Receptionist'
      can [:create, :update, :show, :index, :destroy], Patient  # Full CRUD access to patients
    when 'Doctor'
      can :index, :show, Patient  # Doctors can only view patients
      can :patient_graph, Patient  # Only Doctors can only view patient's graph
    end
  end
end
