class WeightlossesController < ApplicationController
  def index
    @weightlosses = Weightloss.all
  end
end
