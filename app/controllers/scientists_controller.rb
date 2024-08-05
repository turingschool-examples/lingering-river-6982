class ScientistsController < ApplicationController
  def show
    @scientist = Scientist.find(params[:id])
  end

  def destroy
    # Find the scientist in question based on `experiment_id`
    @scientist = Scientist.find(params[:id])
    # If incoming params includes `experiment_id`
    if params[:experiment_id]
      # Sets `experiment` variable to instance of Experiment class
        # found by searching its ID
      experiment = Experiment.find(params[:experiment_id])
      # Calls specific instance of `experiment` from this scientist
        # and destroys it (destroys instance of scientist_experiment with this association)
      @scientist.experiments.delete(experiment)
      redirect_to "/scientists/#{@scientist.id}"
    else
      redirect_to "/scientists/#{@scientist.id}"
    end
  end
end