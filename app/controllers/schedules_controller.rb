# frozen_string_literal: true

class SchedulesController < ApplicationController
  def index
    @schedules = Schedule.all
  end

  def new
    @schedule = Schedule.new
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.save
    redirect_to schedules_path if @schedule.save
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])

    if @schedule.update(schedule_params)

    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    if @schedule.destroy
      notice 'Schedule deleted succesfully'
    else
      notice 'ERROR'
    end
  end

  private

  def schedule_params
    params.require(:schedule).permit(:week_day, :opening_time, :closing_time)
  end
end
