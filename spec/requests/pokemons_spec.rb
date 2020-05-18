require 'rails_helper'

RSpec.describe "/pokemons", type: :request do
  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # PokemonsController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Pokemon.create! attributes_for(:pokemon)
      get pokemons_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      pokemon = Pokemon.create! attributes_for(:pokemon)
      get pokemon_url(pokemon), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Pokemon" do
        expect {
          post pokemons_url,
               params: { pokemon: attributes_for(:pokemon) }, headers: valid_headers, as: :json
        }.to change(Pokemon, :count).by(1)
      end

      it "renders a JSON response with the new pokemon" do
        post pokemons_url,
             params: { pokemon: attributes_for(:pokemon) }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Pokemon" do
        invalid_attributes = attributes_for(:pokemon)
        invalid_attributes[:type_1] = nil
        expect {
          post pokemons_url,
               params: { pokemon: invalid_attributes }, as: :json
        }.to change(Pokemon, :count).by(0)
      end

      it "renders a JSON response with errors for the new pokemon" do
        invalid_attributes = attributes_for(:pokemon)
        invalid_attributes[:type_1] = nil
        post pokemons_url,
             params: { pokemon: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      it "updates the requested pokemon" do
        pokemon = Pokemon.create! attributes_for(:pokemon)
        update_attributes = attributes_for(:pokemon)
        update_attributes[:name] = "Drako"
        patch pokemon_url(pokemon),
              params: { pokemon: update_attributes }, headers: valid_headers, as: :json
        pokemon.reload
        expect(pokemon.name).to eq("Drako")
      end

      it "renders a JSON response with the pokemon" do
        pokemon = Pokemon.create! valid_attributes
        patch pokemon_url(pokemon),
              params: { pokemon: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the pokemon" do
        pokemon = Pokemon.create! valid_attributes
        patch pokemon_url(pokemon),
              params: { pokemon: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested pokemon" do
      pokemon = Pokemon.create! valid_attributes
      expect {
        delete pokemon_url(pokemon), headers: valid_headers, as: :json
      }.to change(Pokemon, :count).by(-1)
    end
  end
end
