class Payment < ActiveRecord::Base
  belongs_to :consumer
end
