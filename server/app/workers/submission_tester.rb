
class SubmissionTester
  @queue = :submission_queue



  def self.perform(submission_id)
    @diary = Logger.new 'log/submission.log'
    @diary.debug "request #{submission_id}"

    # Task: send submission to docker service for testing and write back the testing result
    # When: after student submission

    @submission = Submission.find(submission_id)

    unless @submission.file.path.nil?
      
      dockerObj = DockerService.new(@submission)

      unless dockerObj.no_public_test
        @submission = dockerObj.run_public
        @submission.save!
      else
        @submission.log     = "no public test"
        @submission.raw_log = "no public test"
      end

      dockerObj = DockerService.new(@submission)
      unless dockerObj.no_private_test
        @submission = dockerObj.run_private
        @submission.save!
      else
        @submission.private_log = "no private test"
      end
    end


    # write everything into the database
    @submission.status      = 2
    @submission.save!

    @diary = Logger.new 'log/submission.log'
    @diary.debug "submission #{@submission.id} --> done"

  rescue StandardError => e
    @diary = Logger.new 'log/submission.log'
    @diary.debug e

    @submission = Submission.find(submission_id)

    #setze auf Fehler
    @submission.update_attribute(:status, 1)
  end
end

