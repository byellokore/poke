require 'rails_helper'

RSpec.describe "/pokemons", type: :request do
  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # PokemonsController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    {}
  }

  let(:pagination_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      get api_v1_pokemons_url, headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(response.header["Current-Page"]).to match("1")
      expect(response.header["Page-Items"]).to match("25")
    end
  end

  describe "GET /index?page=2" do
    it "renders a successful response of page 2" do
      get "/api/v1/pokemons?page=2", headers: valid_headers, as: :json
      expect(response).to be_successful
      expect(response.header["Current-Page"]).to match("2")
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      puts attributes_for(:pokemon)
      pokemon = Pokemon.create! attributes_for(:pokemon)
      get api_v1_pokemon_url(pokemon), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Pokemon" do
        expect {
          post api_v1_pokemons_url,
               params: { pokemon: attributes_for(:pokemon) }, headers: valid_headers, as: :json
        }.to change(Pokemon, :count).by(1)
      end

      it "renders a JSON response with the new pokemon" do
        post api_v1_pokemons_url,
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
          post api_v1_pokemons_url,
               params: { pokemon: invalid_attributes }, as: :json
        }.to change(Pokemon, :count).by(0)
      end

      it "renders a JSON response with errors for the new pokemon" do
        invalid_attributes = attributes_for(:pokemon)
        invalid_attributes[:type_1] = nil
        post api_v1_pokemons_url,
             params: { pokemon: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      it "updates the requested pokemon name" do
        pokemon = Pokemon.create! attributes_for(:pokemon)
        update_attributes = attributes_for(:pokemon)
        update_attributes[:name] = "Drako"
        patch api_v1_pokemon_url(pokemon),
              params: { pokemon: update_attributes }, headers: valid_headers, as: :json
        pokemon.reload
        expect(pokemon.name).to eq("Drako")
      end

      it "renders a JSON response with the pokemon" do
        pokemon = Pokemon.create! attributes_for(:pokemon)
        update_attributes = attributes_for(:pokemon)
        patch api_v1_pokemon_url(pokemon),
              params: { pokemon: update_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the pokemon" do
        pokemon = Pokemon.create! attributes_for(:pokemon)
        update_attributes = attributes_for(:pokemon)
        update_attributes[:name] = nil
        patch api_v1_pokemon_url(pokemon),
              params: { pokemon: update_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested pokemon" do
      pokemon = Pokemon.create! attributes_for(:pokemon)
      expect {
        delete api_v1_pokemon_url(pokemon), headers: valid_headers, as: :json
      }.to change(Pokemon, :count).by(-1)
    end
  end
end
