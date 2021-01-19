require 'rails_helper'

RSpec.describe Project, type: :model do

  it { should belong_to(:user) }

  %i[project_type name description logo].each do |field|
    it { should validate_presence_of(field) }
  end

end
