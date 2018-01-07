require 'rails_helper'

RSpec.describe Shipment, type: :model do
  let(:shipment) { FactoryGirl.build  :shipment }
  subject { shipment }

  it { should validate_presence_of :status }
  it { should validate_presence_of :order_id }
end
