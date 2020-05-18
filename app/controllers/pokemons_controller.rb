class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :update, :destroy]

  # GET /pokemons
  def index
    @pokemons = Pokemon.all
    @pokemons_serialized = PokemonSerializer.new(@pokemons).serialized_json
    render json: @pokemons_serialized
  end

  # GET /pokemons/1
  def show
    @pokemon_serialized = PokemonSerializer.new(@pokemon).serialized_json
    render json: @pokemon_serialized
  end

  # POST /pokemons
  def create
    @pokemon = Pokemon.new(pokemon_params)
    if @pokemon.save
      render json: PokemonSerializer.new(@pokemon).serialized_json, status: :created, location: @pokemon
    else
      render json: @pokemon.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pokemons/1
  def update
    if @pokemon.update(pokemon_params)
      render json: PokemonSerializer.new(@pokemon).serialized_json
    else
      render json: @pokemon.errors, status: :unprocessable_entity
    end
  end

  # DELETE /pokemons/1
  def destroy
    @pokemon.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokemon
      @pokemon = Pokemon.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def pokemon_params
      params.require(:pokemon).permit(:name, :type_1, :type_2, :total, :hp, :attack, :defense, :sp_atk, :sp_def, :speed, :generation, :legendary)
    end
end
