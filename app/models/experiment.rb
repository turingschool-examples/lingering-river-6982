class Experiment < ApplicationRecord
  has_many :scientist_experiments
  has_many :scientists, through: :scientist_experiments

  def long_running_experiments
    Experiment.where("num_months > 6")
  end
end