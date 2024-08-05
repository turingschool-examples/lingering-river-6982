require "rails_helper"

RSpec.describe "Experiment Index Page", type: :feature do
  before :each do
    @experiment_1 = Experiment.create!(name: "Mr. Hyde", objective: "Change Bodies", num_months: 1)
    @experiment_2 = Experiment.create!(name: "Antidotes", objective: "Protect From Poisoning", num_months: 25)
    @experiment_3 = Experiment.create!(name: "Flubber", objective: "Flub It", num_months: 6)
    @experiment_4 = Experiment.create!(name: "Perpetual Motion", objective: "Save Energy", num_months: 13)
  end
  context "User Story #3" do
    it "displays names of experiments older than 6 months" do
      # When I visit the experiment index page
      visit "/experiments"

      # I see the names of all long running experiments (longer than 6 months),
      expect(page).to have_content("Antidotes")
      expect(page).to have_content("Flubber")
      expect(page).to have_content("Perpetual Motion")
      
      expect(page).to_not have_content("Mr. Hyde")

      # And I see the names are in descending order (longest to shortest)
      expect("Antidotes").to appear_before("Flubber")
      expect("Flubber").to appear_before("Perpetual Motion")
    end
  end
end