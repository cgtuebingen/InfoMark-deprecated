class DockerService


  def initialize(submission)
    @diary = Logger.new 'log/submission.log'


    @submission = submission
    @diary.debug "load Submission #{@submission.id} at #{DateTime.now}"


    if Rails.env.production?
      @config = {memory: "--memory-swap 1G -m 1G", cpus: "--cpuset-cpus 8-31", result_dir: "/data/results"}
    else
      @config = {memory: "", cpus: "", result_dir: "/data/results"}
    end
    @diary.debug "load config #{@config}"

    @submission_filename = @submission.file.path
    @unittest_public_fn  = @submission.exercise_task.public_test.path unless @submission.exercise_task.private_test.nil?
    @unittest_private_fn = @submission.exercise_task.private_test.path unless @submission.exercise_task.private_test.nil?

    @xml_public_fn       =  @submission.id.to_s+".xml"
    @xml_private_fn      =  "_"+@submission.id.to_s+".xml"


    @diary.debug "init done"
  end

  def no_public_test
    @submission.exercise_task.public_test.blank?
  end

  def no_private_test
    @submission.exercise_task.private_test.blank?
  end

  def public_xml
    "#{@config[:result_dir]}/#{@xml_public_fn}"
  end

  def private_xml
    "#{@config[:result_dir]}/#{@xml_private_fn}"
  end

  def run_public
    @diary.debug "start public"
    run_docker(@unittest_public_fn,@xml_public_fn, @config[:result_dir])
    @submission.log  = parseXmlResult("#{@config[:result_dir]}/#{@xml_public_fn}")
    @submission.raw_log  = File.readlines "#{@config[:result_dir]}/#{@xml_public_fn}"
    return @submission
  end

  def run_private
    @diary.debug "start private"
    run_docker(@unittest_private_fn,@xml_private_fn, @config[:result_dir])
    @submission.private_log  = File.readlines "#{@config[:result_dir]}/#{@xml_private_fn}"
    return @submission
  end

  def run_docker(framework_path,xml_path, results_dir)
    cmd =   "docker run --rm --net none #{@config[:cpus]} "\
      " #{@config[:memory]}"\
      " -v #{@submission_filename}:/data/submission.zip:ro "\
      " -v #{framework_path}:/data/unittest.zip:ro "\
      "-v #{results_dir}:/results  simple_ci_runner #{xml_path}"

    @diary.debug cmd


    if Rails.application.config.active_docker
      raw_out = `#{cmd}`
      File.open("#{results_dir}/#{xml_path}.log", "w+") do |f|
        f.write(raw_out)
      end
    else
      @diary.debug "just simulating docker because of \"Rails.application.config.active_docker\" "
    end
  end

  def parseXmlResult(filename)
    f = File.open(filename)
    doc = Nokogiri::XML(f)

    testsuite = doc.xpath('//testsuite')
    txt = ""
    if testsuite.length == 1

      failures = Integer(testsuite[0]["failures"])
      errors = Integer(testsuite[0]["errors"])

      status = 1
      if failures == 0 && errors == 0
        status = 2
      end

      doc.xpath('//test').each do |test|
        txt += "Test: " + test["name"] + " | Passed: " + test["testpassed"] + "\n"

        if test["testpassed"] == "false"
          txt += "Type: " + test["type"] + " | Message: " + test["message"].to_s + "\n"
        end
        txt += "\n"
      end
    else
      txt = "testsuite error, pls report to admin \n"
    end
    return txt
  end
end
