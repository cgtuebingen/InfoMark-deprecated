module SlidesHelper
  def course_list()
    # returns all users with subscription to current course but no students
    Course.all.map{ |r| [r.title, r.id]}
  end
end
