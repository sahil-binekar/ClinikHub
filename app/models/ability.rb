# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    case user.role
    when 'Receptionist'
      can :manage, Patient  # Full CRUD access to patients
    when 'Doctor'
      can :read, Patient  # Doctors can only view patients
    end
  end
end
