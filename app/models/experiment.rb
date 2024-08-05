class Experiment < ApplicationRecord
  has_many :scientist_experiments, dependent: :destroy
  has_many :scientists, through: :scientist_experiments

  def longest_running
    select.@experiments
    .where(num_months > 6)
    .order(num_months desc)
  end
end