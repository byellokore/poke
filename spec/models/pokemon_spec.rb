require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  before(:all) do
    @pokemon_one = build(:pokemon)
  end

  it 'cannot be valid without any attribute' do
    expect(Pokemon.new).to_not be_valid
  end

  it 'must be valid with all attributes' do
    expect(@pokemon_one).to be_valid
  end

  context "Attributes validation" do
    before(:each) do
      @pokemon_one = build(:pokemon)
    end

    it 'is not valid without name' do
      @pokemon_one.name = nil
      expect(@pokemon_one).to_not be_valid
    end

    it 'is not valid without type_1' do
      @pokemon_one.type_1 = nil
      expect(@pokemon_one).to_not be_valid
    end

    it 'is valid without type_2' do
      @pokemon_one.type_2 = nil
      expect(@pokemon_one).to be_valid
    end

    it 'is not valid without total' do
      @pokemon_one.total = nil
      expect(@pokemon_one).to_not be_valid
    end

    it 'is not valid without hp' do
      @pokemon_one.hp = nil
      expect(@pokemon_one).to_not be_valid
    end

    it 'is not valid without attack' do
      @pokemon_one.attack = nil
      expect(@pokemon_one).to_not be_valid
    end

    it 'is not valid without defense' do
      @pokemon_one.defense = nil
      expect(@pokemon_one).to_not be_valid
    end

    it 'is not valid without sp_atk' do
      @pokemon_one.sp_atk = nil
      expect(@pokemon_one).to_not be_valid
    end

    it 'is not valid without sp_def' do
      @pokemon_one.sp_def = nil
      expect(@pokemon_one).to_not be_valid
    end

    it 'is not valid without speed' do
      @pokemon_one.speed = nil
      expect(@pokemon_one).to_not be_valid
    end

    it 'is not valid without generation' do
      @pokemon_one.generation = nil
      expect(@pokemon_one).to_not be_valid
    end

    it 'is not valid without legendary' do
      @pokemon_one.legendary = nil
      expect(@pokemon_one).to_not be_valid
    end
  end
end
