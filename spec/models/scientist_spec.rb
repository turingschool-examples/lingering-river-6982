require 'rails_helper'

RSpec.describe Scientist do
  it { should belong_to :lab }
end
