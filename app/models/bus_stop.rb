class BusStop < ApplicationRecord
  def label
    "#{code} - #{name} - #{direction}"
  end
end
