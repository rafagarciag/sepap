class Attempt < ActiveRecord::Base
  attr_accessible :code, :numero_problema, :resultado

  belongs_to :user
  belongs_to :problem

  mount_uploader :code, CodeUploader
end
