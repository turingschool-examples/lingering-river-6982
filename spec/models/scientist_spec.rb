require 'rails_helper'

RSpec.describe Scientist do
  describe "relationships" do
    it { should belong_to :lab }
    it { should have_many :scientist_experiments}
    it { should have_many(:experiments).through(:scientist_experiments) }
  end

  describe "instance methods" do
    before :each do
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

    xit "removes an experiment from a scientist" do

    end
  end
end
