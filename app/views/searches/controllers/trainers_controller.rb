class TrainersController < ApplicationController

  def index
    @trainers = Trainer.all

    render json: @trainers.to_json();
    # render json: trainers, include: [:bird, :location]

  end
end
