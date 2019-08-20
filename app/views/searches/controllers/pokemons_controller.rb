class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all
  render json: @pokemons.to_json();
  end

  def create
    @pokemon = Pokemon.create(species: Faker::Games::Pokemon.name, nickname: Faker::Games::SuperSmashBros.fighter, trainer_id: params["trainer_id"])
    render json: @pokemon.to_json();
    # what you are sending back to the frontend
    # most languages can read JSON
  end

  def pokemon_params
    params.require(:pokemon).permit(:species, :nickname, :trainer_id)
  end


end
