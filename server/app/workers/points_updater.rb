
class PointsUpdater

  @queue = :system_queue

  def self.perform(course_id)

    @course = Course.find(course_id)

    @course.exercise_sheets.each do |sheet|
      @course.course_groups.each do |group|
        group.users.each do |user|
          Resque.enqueue(PointsAccumulator, user.id, sheet.id)
        end
      end
    end

  end
end
