class Attempt < ActiveRecord::Base
  attr_accessible :code  
  belongs_to :user
  belongs_to :problem
  mount_uploader :code, CodeUploader
end
