require 'rails_helper'

RSpec.describe Product, type: :model do

  subject {
    described_class.new(name: "Anything", description: "Lorem ipsum",
                      expire_date: Date.today, price: 50.0, admin_approved: true, sku_id: SecureRandom.hex(6))
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a unique sku_id" do
    subject.sku_id = 'SKU_001'
    subject.save
    expect(subject).to_not be_valid
  end

  it "is not valid without a description" do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an expiry date" do
    subject.expire_date = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a price" do
    subject.price = nil
    expect(subject).to_not be_valid
  end
end
