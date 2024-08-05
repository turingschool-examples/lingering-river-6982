require "rails_helper"

RSpec.describe Experiment, type: :model do
  it { should have_many :scientist_experiments }
  it { should have_many(:scientists).through(:scientist_experiments) }


  describe "class methods" do
    it "returns experiment instances older than 6 months in descending order" do
      experiment_1 = Experiment.create!(name: "Mr. Hyde", objective: "Change Bodies", num_months: 6)
      experiment_2 = Experiment.create!(name: "Antidotes", objective: "Protect From Poisoning", num_months: 25)
      experiment_3 = Experiment.create!(name: "Flubber", objective: "Flub It", num_months: 7)
      experiment_4 = Experiment.create!(name: "Perpetual Motion", objective: "Save Energy", num_months: 13)

      long_running_experiments = [experiment_2, experiment_4, experiment_3]
      expect(Experiment.where("num_months > 6").order(num_months: :desc)).to eq(long_running_experiments)
    end
  end
end
