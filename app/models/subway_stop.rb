class SubwayStop < ApplicationRecord
  serialize :routes, Array

  def label
    "#{line_name} - #{stop_name}"
  end
end
