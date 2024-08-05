class ScientistExperimentsController < ApplicationController
  def destroy
    @scientist = Scientist.find(params[:scientist_id])
    @experiment = Experiment.find(params[:id])

    scientist_experiment = ScientistExperiment.find_by(scientist: @scientist, experiment: @experiment)
    scientist_experiment.destroy
    redirect_to scientist_path(@scientist)
  end
end
