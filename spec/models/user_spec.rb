require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_presence_of :user_type }
  it { should validate_presence_of :name }
end
