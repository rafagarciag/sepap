class Problem < ActiveRecord::Base
  attr_accessible :solution, :input, :output
  belongs_to :user
  mount_uploader :solution, SolutionUploader
  mount_uploader :input, InputUploader
  mount_uploader :output, OutputUploader
end
