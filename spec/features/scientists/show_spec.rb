require 'rails_helper'

RSpec.describe "Scientists Show Page:" do
  before :each do
    @lab1 = Lab.create!(name: "The Turtle Stomping Research Institute")
    @lab2 = Lab.create!(name: "The Institute of Kidnapping Princesses")
    
    @scientist1 = Scientist.create!(name: "Mario", specialty: "Plumbing", university: "Brooklyn Community College", lab_id: "#{@lab1.id}")
    @scientist2 = Scientist.create!(name: "Luigi", specialty: "Plumbing", university: "Brooklyn Community College", lab_id: "#{@lab1.id}")
    @scientist3 = Scientist.create!(name: "Peach", specialty: "Princessing", university: "Mushroom Kingdom University", lab_id: "#{@lab1.id}")
    @scientist4 = Scientist.create!(name: "Toad", specialty: "Physics", university: "Mushroom Kingdom University", lab_id: "#{@lab1.id}")
    @scientist5 = Scientist.create!(name: "Bowser", specialty: "Subjugation", university: "Bowser University", lab_id: "#{@lab2.id}")

    @experiment1 = Experiment.create!(name: "Pipe Travel", objective: "To study and understand the physical mechanisms that allow for near instantaneous travel over long distances through pipes.", num_months: 420)
    @experiment2 = Experiment.create!(name: "Fire Flowers", objective: "To study and understand the biological transformation caused by ingesting a fire flower.", num_months: 333)
    @experiment3 = Experiment.create!(name: "Breathing Fire", objective: "To amplify the destructive power of Bowser's fire breath.", num_months: 666)
    @experiment4 = Experiment.create!(name: "Invincibility Stars", objective: "To study and harness the omnipotent power of the invincibility star.", num_months: 777)

    @se_1 = ScientistExperiment.create!(scientist_id: @scientist1.id, experiment_id: @experiment1.id)
    @se_2 = ScientistExperiment.create!(scientist_id: @scientist1.id, experiment_id: @experiment2.id)
    @se_3 = ScientistExperiment.create!(scientist_id: @scientist1.id, experiment_id: @experiment4.id)
    @se_4 = ScientistExperiment.create!(scientist_id: @scientist5.id, experiment_id: @experiment1.id)
    @se_5 = ScientistExperiment.create!(scientist_id: @scientist5.id, experiment_id: @experiment3.id)
    @se_6 = ScientistExperiment.create!(scientist_id: @scientist5.id, experiment_id: @experiment4.id)
  end

  context "As a visitor" do
    describe "when I visit a scientist's show page," do
      it "I see all of that scientist's information (name, specialty, alma mater)," do
        visit scientist_path(@scientist1)

        within("#scientist_info")

        expect(page).to have_content("Name: #{@scientist1.name}")
        expect(page).to have_content("Specialty: #{@scientist1.specialty}")
        expect(page).to have_content("Alma Mater: #{@scientist1.university}")

        expect(page).to_not have_content("Name: #{@scientist5.name}")
        expect(page).to_not have_content("specialty: #{@scientist5.specialty}")
        expect(page).to_not have_content("Alma Mater: #{@scientist5.university}")
      end

      it "I see the name of the lab where this scientist works," do
        visit scientist_path(@scientist1)

        within("#scientist_info")

        expect(page).to have_content("Lab: #{@scientist1.lab.name}")
        expect(page).to_not have_content("Lab: #{@scientist5.lab.name}")
      end

      it "and I see the names of all of the experiments this scientist is running." do
        visit scientist_path(@scientist1)

        within("#scientist_experiments")

        expect(page).to have_content("#{@experiment1.name}")
        expect(page).to have_content("#{@experiment2.name}")
        expect(page).to have_content("#{@experiment4.name}")

        expect(page).to_not have_content("#{@experiment3.name}")

      end

      it "Then next to each experiment's name, I see a button to remove that experiment from that scientist's work load" do
        visit scientist_path(@scientist1)
        
        expect(page).to have_button("Remove")
      end

      it "When I click that button for one experiment, I'm brought back to the scientist's show page, and I no longer see that experiment's name listed" do
        visit scientist_path(@scientist1)
        within("#scientist_experiment")
        expect(page).to have_content("#{@experiment1.name}")

        within("experiment-#{@experiment1.id}")
        click_button "Remove #{@experiment1.name}"
        
        expect(page).to_not have_content("#{@experiment1.name}")
      end

      it "And when I visit a different scientist's show page that is working on that same experiment, then I see that the experiment is still on the other scientist's work load" do
        visit scientist_path(@scientist5)
        within("#scientist_experiment")
        expect(page).to have_content("#{@experiment1.name}")
      end      
    end
  end
end