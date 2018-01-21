class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course


  enum role: [:student, :tutor, :supertutor, :admin]

  


  #http://stackoverflow.com/questions/26651811/rails-activerecord-has-many-through-association-on-unsaved-objects
end
