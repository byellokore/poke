module Api
  module V1
    class PokemonsController < ApplicationController
      include Pagy::Backend
      before_action :set_pokemon, only: [:show, :update, :destroy]
      after_action { pagy_headers_merge(@pagy) if @pagy }

      def index
        @pagy, @pokemons = pagy(Pokemon.all, page: params[:page], items: 25)
        @pokemons_serialized = PokemonSerializer.new(@pokemons).serialized_json
        render json: @pokemons_serialized
      end

      def show
        @pokemon_serialized = PokemonSerializer.new(@pokemon).serialized_json
        render json: @pokemon_serialized
      end

      def create
        @pokemon = Pokemon.new(pokemon_params)
        if @pokemon.save
          render json: PokemonSerializer.new(@pokemon).serialized_json, status: :created, location: api_v1_pokemon_url(@pokemon)
        else
          render json: { data: @pokemon.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @pokemon.update(pokemon_params)
          render json: PokemonSerializer.new(@pokemon).serialized_json
        else
          render json: { data: @pokemon.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @pokemon.destroy
      end

      private

      def set_pokemon
        @pokemon = Pokemon.find(params[:id])
      end

      def pokemon_params
        params.require(:pokemon).permit(:page, :name, :type_1, :type_2, :total, :hp, :attack, :defense, :sp_atk, :sp_def, :speed, :generation, :legendary)
      end
    end
  end
end
