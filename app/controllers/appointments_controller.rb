# frozen_string_literal: true

# Appointment class controller
class AppointmentsController < ApplicationController
  before_action :authenticate_patient!
  skip_before_action :authenticate_patient!, only: [:search]

  def index
    @pagy, @appointments = pagy(Appointment.order(date_time: :desc), items: 50)
  end

  def search
    @pagy, @appointments = pagy(Appointment.order(date_time: :desc), items: 50)
  end

  def new
    @appointment = Appointment.new
  end

  def show
    appointment
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      redirect_to appointments_path, notice: 'New appointment created successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    appointment
  end

  def update
    appointment

    if @appointment.update(appointment_params)
      redirect_to appointments_path, notice: 'Appointment was edited successfully'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    appointment
    if @appointment.destroy
      redirect_to appointments_path, notice: 'Appointment was deleted successfully'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(
      :date_time,
      :reason,
      :service_id,
      :patient_id,
      :user_id,
      :status,
      :payment_status,
      :score,
      :review
    )
  end
end
