class DockerService
  def initialize(params)
    @diary = @diary.new 'log/submission.log'

    @id = params[:id]
    puts @id
    # @submission = Submission.find_by(id: @id)
    # @diary.debug "loaded Submission #{@submission.id} at #{DateTime.now}"

    # config = {memory: "1G", cpus: "8-31", result_dir: "/data/results"}

    # @submission_filename = @current_submission.file.path
    # # path to testing framework
    # @unittest_public_fn  = @current_submission.exercise_task.public_test.path unless @current_submission.exercise_task.private_test.nil?
    # @unittest_private_fn = @current_submission.exercise_task.private_test.path unless @current_submission.exercise_task.private_test.nil?

    # @xml_public_fn       =  @current_submission.id.to_s+".xml"
    # @xml_private_fn      =  "_"+@current_submission.id.to_s+".xml"

  end

  def has_public_test
  	@current_submission.exercise_task.public_test.present?
  end

  def has_private_test
  	@current_submission.exercise_task.private_test.present?
  end

  def run_docker
    # path to student submission
    submission_filename = @current_submission.file.path
    # path to testing framework
    unittest_public_fn  = @current_submission.exercise_task.public_test.path unless @current_submission.exercise_task.private_test.nil?
    unittest_private_fn = @current_submission.exercise_task.private_test.path unless @current_submission.exercise_task.private_test.nil?
    # path to output directory

    # generated result stub
    xml_public_fn       =  @current_submission.id.to_s+".xml"
    xml_private_fn      =  "_"+@current_submission.id.to_s+".xml"



    @diary.debug "docker run --rm --net none --cpuset-cpus #{config[:cpus]} -m #{config[:memory]} --memory-swap #{config[:memory]} -v #{submission_filename}:/data/submission.zip:ro -v #{unittest_public_fn}:/data/unittest.zip:ro -v #{results_dir}:/results  simple_ci_runner #{xml_public_fn}"


    # # are we in production mode?
    # if Rails.env.production? or Rails.env.staging?
    #   @diary.debug "production environment recognized"
    #   # public
    #   unless unittest_public_fn.nil?
    #     system("docker run --rm --net none --cpuset-cpus #{cpus} -m #{memory} --memory-swap #{memory} -v #{submission_filename}:/data/submission.zip:ro -v #{unittest_public_fn}:/data/unittest.zip:ro -v #{results_dir}:/results  simple_ci_runner #{xml_public_fn}")
    #     ans_public  = File.readlines "#{results_dir}/#{xml_public_fn}"


    #     # --------------------------------------------------
    #     f = File.open("#{results_dir}/#{xml_public_fn}")
    #     doc = Nokogiri::XML(f)

    #     testsuite = doc.xpath('//testsuite')

    #     log = ""
    #     if testsuite.length == 1

    #       failures = Integer(testsuite[0]["failures"])
    #       errors = Integer(testsuite[0]["errors"])

    #       status = 1
    #       if failures == 0 && errors == 0
    #         status = 2
    #       end

    #       doc.xpath('//test').each do |test|
    #         log += "Test: " + test["name"] + " | Passed: " + test["testpassed"] + "\n"

    #         if test["testpassed"] == "false"
    #           log += "Type: " + test["type"] + " | Message: " + test["message"].to_s + "\n"
    #         end
    #         log += "\n"
    #       end
    #     else
    #       log = "testsuite error, pls report to admin \n"
    #     end
    #     ans_display = log
    #     f.close()

    #     # --------------------------------------------------



    #     ans_public  = ans_public.join("")
    #   else
    #     ans_display = "no public test"
    #     ans_public  = "no public test"
    #   end
    #   # private
    #   unless unittest_private_fn.nil?
    #     system("docker run --rm --net none --cpuset-cpus #{cpus} -m #{memory} --memory-swap #{memory} -v #{submission_filename}:/data/submission.zip:ro -v #{unittest_public_fn}:/data/unittest.zip:ro -v #{results_dir}:/results  simple_ci_runner _#{xml_public_fn}")
    #     ans_private = File.readlines "#{results_dir}/_#{xml_public_fn}"
    #     ans_private = ans_private.join("")
    #   else
    #     ans_private = "no private test"
    #   end

    # else
    #   # use some dummy stuff
    #   xml_public_fn =  "/home/wieschol/code/ruby/automark/public/local/test.xml"


    #   ans_public  = File.readlines xml_public_fn
    #   ans_private = File.readlines xml_public_fn
    # end

    # else
    #   ans_private = "empty submission"
    #   ans_public  = "empty submission"
    #   ans_display = "empty submission"
    # end

  end

  def run
    puts "TestSubmission"
  end
end
