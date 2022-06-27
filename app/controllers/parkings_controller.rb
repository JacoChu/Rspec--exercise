class ParkingsController < ApplicationController
  before_action :find_parking, only: %i[show update]
  
  def new
    @parking = Parking.new
  end
  
  def create
    @parking = Parking.new(start_at: Time.now )

    if current_user
      @parking.parking_type = params[:parking][:parking_type]
      @parking.user = current_user
    else
      @parking.parking_type = "guest"
    end
    
    @parking.save!
    redirect_to parking_path(@parking)
  end

  def show
  end
  
  def update
    @parking.end_at = Time.now
    @parking.calculate_amount 
    @parking.save!
    redirect_to parking_path(@parking)
  end

  private
  
  def find_parking
    @parking = Parking.find(params[:id])
  end
end
