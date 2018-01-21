
class PointsAccumulator
  # used here:   grep -nr "PointsAccumulator" .

  @queue = :system_queue
  def self.perform(user_id, sheet_id)
    # Task: accumulate points for each user&sheet for faster access using cache
    # When: after submitting a grading

    log = Logger.new 'log/resque.log'
    log.debug "compute points cachefor user #{user_id} and sheet #{sheet_id}"

    points = Grading.where(user_id: user_id, exercise_sheet_id:sheet_id).sum(:points)
    log.debug "new points #{points}"


    cache = PointsCache.where(user_id: user_id, exercise_sheet_id: sheet_id).first_or_create 

    unless cache.nil?
      cache.points = points
      cache.save!
      log.debug "update success"
    end
  end
end

