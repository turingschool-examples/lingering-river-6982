require "rails_helper"


RSpec.describe "Scientist Show Page", type: :feature do
  before :each do
    @lab_1 = Lab.create!(name: "The Lair")
    @lab_x = Lab.create!(name: "Rat Cage")
    
    @scientist_1 = Scientist.create!(name: "Dr. Jekyll", specialty: "Shape Shifting", university: "PhD in Morphology from the University of Oxford", lab: @lab_1)
    @scientist_2 = Scientist.create!(name: "Dr. Carl Sagan", specialty: "Astronomy", university: "PhD in Astrophysics from the University of Chicago", lab: @lab_1)
    @scientist_x = Scientist.create!(name: "Brain", specialty: "Ruminating", university: "PhD in Failed Escapes from the Maze College", lab: @lab_x)

    @experiment_1 = Experiment.create!(name: "Mr. Hyde", objective: "Change Bodies", num_months: 1)
    @experiment_2 = Experiment.create!(name: "Antidotes", objective: "Protect From Poisoning", num_months: 3)
    @experiment_x = Experiment.create!(name: "Gravity Waves", objective: "Float without Propulsion", num_months: 9)

    ScientistExperiment.create!(scientist: @scientist_1, experiment: @experiment_1)
    ScientistExperiment.create!(scientist: @scientist_1, experiment: @experiment_2)
    ScientistExperiment.create!(scientist: @scientist_x, experiment: @experiment_x) # For Sad Paths
    
    ScientistExperiment.create!(scientist: @scientist_2, experiment: @experiment_1)
    ScientistExperiment.create!(scientist: @scientist_2, experiment: @experiment_2)
  end
  context "User Story #1" do
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
      expect(page).to have_content("University: #{@scientist_1.university}")

      # Sad Path
      expect(page).to_not have_content("Name: #{@scientist_x.name}")
      expect(page).to_not have_content("Specialty: #{@scientist_x.specialty}")
      expect(page).to_not have_content("University: #{@scientist_x.university}")

      # And I see the name of the lab where this scientist works
      expect(page).to have_content("#{@scientist_1.lab.name}")
      
      expect(page).to_not have_content("#{@scientist_x.lab.name}")

      # And I see the names of all of the experiments this scientist is running
      # expect(page).to have_content("Mr. Hyde")
      # expect(page).to have_content("Antidotes")
      
      # I haven't been able to get this to work in the past.
        # Maybe I can get it this time.  It's more concise/dynamic.
          # Sweet! I got it to work!
      @scientist_1.experiments.each do |experiment|
        expect(page).to have_content(experiment.name)
      end
    end
  end

  context "User Story #2" do
    xit "removes experiment from a scientist's show page" do
      # When I visit a scientist's show page
      visit "/scientists/#{@scientist_1.id}"

      # Then next to each experiment's name, I see a button to remove that experiment from that scientist's work load
      expect(page).to have_content("Mr. Hyde")
      expect(page).to have_content("Antidotes")

      expect(page).to have_button "Remove Experiment"
      expect(page).to have_link("Remove Experiment", href: "/scientists/#{@scientist_1.id}")

      # When I click that button for one experiment
      all(:button, "Remove Experiment")[0].click  # Should click the first of 2 "Remove Experiment" buttons
      
      # I'm brought back to the scientist's show page
      expect(current_path).to eq("/scientists/#{@scientist_1.id}")
      
      # And I no longer see that experiment's name listed
      expect(page).to_not have_content("Mr. Hyde")  # Should no longer be visible
      expect(page).to have_content("Antidotes")   # Should remain as button was not clicked to remove
      
      expect(page).to have_button "Remove Experiment"  # Button belongs to "Antidotes", should remain unaffected

      # And when I visit a different scientist's show page that is working on that same experiment,
      visit "/scientists/#{@scientist_2.id}"
      
      # Then I see that the experiment is still on the other scientist's work load
      expect(page).to_not have_content("Mr. Hyde")
    end
  end
end