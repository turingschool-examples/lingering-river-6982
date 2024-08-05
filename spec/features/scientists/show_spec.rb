require "rails_helper"


RSpec.describe "Scientist Show Page", type: :feature do
  describe "User Story #1" do
    before :each do
      @lab_1 = Lab.create!(name: "The Lair")
      @lab_x = Lab.create!(name: "Rat Cage")
      
      @scientist_1 = Scientist.create!(name: "Dr. Jekyll", specialty: "Shape Shifting", university: "PhD in Morphology from the University of Oxford", lab: @lab_1)
      @scientist_x = Scientist.create!(name: "Brain", specialty: "Ruminating", university: "PhD in Failed Escapes from the Maze College", lab: @lab_x)

      @experiment_1 = Experiment.create!(name: "Mr. Hyde", objective: "Change Bodies", num_months: 1)
      @experiment_2 = Experiment.create!(name: "Antidotes", objective: "Protect From Poisoning", num_months: 3)
      @experiment_x = Experiment.create!(name: "Gravity Waves", objective: "Float without Propulsion", num_months: 9)

      ScientistExperiment.create!(scientist: @scientist_1, experiment: @experiment_1)
      ScientistExperiment.create!(scientist: @scientist_1, experiment: @experiment_2)
      ScientistExperiment.create!(scientist: @scientist_x, experiment: @experiment_x) # For Sad Paths
    end

    it "displays a scientist's information" do
      # As a visitor
      # When I visit a scientist's show page
      visit "/scientists/#{@scientist_1.id}"

      # I see all of that scientist's information including:
      # - name
      # - specialty
      # - university where they got their degree
      expect(page).to have_content("Name: #{@scientist_1.name}")
      expect(page).to have_content("Specialty: #{@scientist_1.specialty}")
      expect(page).to have_content("Degree From: #{@scientist_1.university}")

      # And I see the name of the lab where this scientist works
      expect(page).to have_content("#{@scientist_1.lab.name}")

      # And I see the names of all of the experiments this scientist is running
      expect(page).to have_content("Mr. Hyde")
      expect(page).to have_content("Antidotes")
      
      # I haven't been able to get this to work in the past.
        # Maybe I can get it this time.  It's more concise/dynamic.
      # @scientist_1.experiments.each do |experiment|
      #   expect(page).to have_content(experiment.name)
      end
    end
  end
end