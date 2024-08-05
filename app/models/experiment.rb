class Experiment < ApplicationRecord
  has_many :scientists, through: scientist_experiments
end