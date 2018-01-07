require 'rails_helper'

RSpec.describe Payment, type: :model do
  let(:payment) { FactoryGirl.build  :payment }
  subject { payment }

  it { should validate_presence_of :payment_method }
  it { should validate_presence_of :proof }
  it { should validate_presence_of :order_id }
end
