class Problem < ActiveRecord::Base
  attr_accesible :solution, :input, :output
  belongs_to :user
  mount_uploader :solution, SolutionUploader
  mount_uploader :input, InputUploader
  mount_uploader :output, OutputUploader
end
