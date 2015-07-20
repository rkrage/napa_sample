require 'spec_helper'

describe CheckIn do

  it 'can be created' do
    check_in = create :check_in
    expect(check_in).to_not be_nil
  end

  it 'can be created with lat/lng' do
    check_in = create :check_in_with_coordinates
    expect(check_in).to_not be_nil
  end

  [:name, :message].each do |param|

    it "is not valid without param #{param}" do
      check_in_hash = attributes_for :check_in
      check_in_hash.delete param
      check_in = CheckIn.new check_in_hash
      expect(check_in.valid?).to be false
    end

  end

  ['invalid_number', 100, -100].each do |invalid_lat|

    it "is not valid with lat '#{invalid_lat}'" do
      check_in_hash = attributes_for :check_in_with_coordinates
      check_in_hash[:lat] = invalid_lat
      check_in = CheckIn.new check_in_hash
      expect(check_in.valid?).to be false
    end

  end

  ['invalid_number', 200, -200].each do |invalid_lng|

    it "is not valid with lng '#{invalid_lng}'" do
      check_in_hash = attributes_for :check_in_with_coordinates
      check_in_hash[:lng] = invalid_lng
      check_in = CheckIn.new check_in_hash
      expect(check_in.valid?).to be false
    end

  end


end
