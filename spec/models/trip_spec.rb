require 'rails_helper'

RSpec.describe Trip, type: :model do
  it { should validate_presence_of(:destination) }
  it { should validate_presence_of(:start_date) }
end
