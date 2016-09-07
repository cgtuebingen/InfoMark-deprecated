module SubmissionsHelper
	def prettify(log)

# 		log_tmp = '<testsuite errors="0" failures="2" hostname="localhost" name="__unittest.myCalculatorTest" skipped="0" tests="7" time="0.104" timestamp="2016-04-26T08:24:48">
#   <test name="evaluateNumericalGradient" testpassed="true" />
#   <test name="evaluateMinus" testpassed="true" />
#   <test name="evaluateMultiply" testpassed="true" />
#   <test name="evaluateDivide" testpassed="true" />
#   <test name="evaluateAdd" testpassed="true" />
#   <test name="evaluateGgT" testpassed="false" type="failure" exctype="junit.framework.AssertionFailedError" message="ggT(30,4):  expected:&lt;2&gt; but was:&lt;26&gt;" />
#   <test name="evaluateKgV" testpassed="false" type="failure" exctype="junit.framework.AssertionFailedError" message="kgV(30,4):  expected:&lt;60&gt; but was:&lt;4&gt;" />
# </testsuite>'

        # log = "[\"<testsuite errors=\\\"0\\\" failures=\\\"0\\\" hostname=\\\"localhost\\\" name=\\\"__unittest.myCalculatorTest\\\" skipped=\\\"0\\\" tests=\\\"7\\\" time=\\\"0.093\\\" timestamp=\\\"2016-04-26T14:07:50\\\">\\n\", \"  <test name=\\\"evaluateNumericalGradient\\\" testpassed=\\\"true\\\" />\\n\", \"<test name=\\\"evaluateMinus\\\" testpassed=\\\"true\\\" />\\n\", \"<test name=\\\"evaluateMultiply\\\" testpassed=\\\"true\\\" />\\n\", \"<test name=\\\"evaluateDivide\\\" testpassed=\\\"true\\\" />\\n\", \"<test name=\\\"evaluateAdd\\\" testpassed=\\\"true\\\" />\\n\", \"<test name=\\\"evaluateGgT\\\" testpassed=\\\"true\\\" />\\n\", \"<test name=\\\"evaluateKgV\\\" testpassed=\\\"true\\\" />\\n\", \"</testsuite>\\n\"]"

        # log = "blulb"

		# log = "<testsuite errors=\"0\" failures=\"1\" hostname=\"localhost\" name=\"__unittest.Ue01privateTest\" skipped=\"0\" tests=\"7\" time=\"0.099\" timestamp=\"2016-04-26T14:07:52\">\n  <test name=\"evaluateNumericalGradient\" testpassed=\"true\" />\n<test name=\"evaluateMinus\" testpassed=\"true\" />\n<test name=\"evaluateMultiply\" testpassed=\"true\" />\n<test name=\"evaluateDivide\" testpassed=\"true\" />\n<test name=\"evaluateAdd\" testpassed=\"true\" />\n<test name=\"evaluateGgT\" testpassed=\"true\" />\n<test exectype=\"junit.framework.AssertionFailedError\" message=\"kgV(0,0): AritmeticExpection: (e.g. division by zero)\" name=\"evaluateKgV\" testpassed=\"false\" type=\"failure\" />\n</testsuite>\n"
		
		# log = "[\"<testsuite errors=\\\"0\\\" failures=\\\"10\\\" hostname=\\\"localhost\\\" name=\\\"__unittest.PublicGameOfLifeTest\\\" skipped=\\\"0\\\" tests=\\\"12\\\" time=\\\"0.12\\\" timestamp=\\\"2016-05-03T13:37:15\\\">\\n\", \"  <test exectype=\\\"junit.framework.AssertionFailedError\\\" message=\\\"cellReproduces(3) not as expected expected:&lt;true&gt; but was:&lt;false&gt;\\\" name=\\\"cellReproducesTest\\\" testpassed=\\\"false\\\" type=\\\"failure\\\" />\\n\", \"<test name=\\\"constructorTest\\\" testpassed=\\\"true\\\" />\\n\", \"<test exectype=\\\"junit.framework.AssertionFailedError\\\" message=\\\"isLivingNeighbor(22,10,23,10) not as expected expected:&lt;true&gt; but was:&lt;false&gt;\\\" name=\\\"isLivingNeighborTest\\\" testpassed=\\\"false\\\" type=\\\"failure\\\" />\\n\", \"<test exectype=\\\"junit.framework.AssertionFailedError\\\" message=\\\"isNeighbor(1,1,1,2) not as expected expected:&lt;true&gt; but was:&lt;false&gt;\\\" name=\\\"isNeighborTest\\\" testpassed=\\\"false\\\" type=\\\"failure\\\" />\\n\", \"<test exectype=\\\"junit.framework.AssertionFailedError\\\" message=\\\"isCellInGameField(99,99) not as expected expected:&lt;true&gt; but was:&lt;false&gt;\\\" name=\\\"isCellInGameFieldTest\\\" testpassed=\\\"false\\\" type=\\\"failure\\\" />\\n\", \"<test exectype=\\\"junit.framework.AssertionFailedError\\\" message=\\\"isOvercrowded(4) not as expected expected:&lt;true&gt; but was:&lt;false&gt;\\\" name=\\\"isOvercrowdedTest\\\" testpassed=\\\"false\\\" type=\\\"failure\\\" />\\n\", \"<test exectype=\\\"junit.framework.AssertionFailedError\\\" message=\\\"isLonely(0) not as expected expected:&lt;true&gt; but was:&lt;false&gt;\\\" name=\\\"isLonelyTest\\\" testpassed=\\\"false\\\" type=\\\"failure\\\" />\\n\", \"<test exectype=\\\"junit.framework.AssertionFailedError\\\" message=\\\"isSteady(2) not as expected expected:&lt;true&gt; but was:&lt;false&gt;\\\" name=\\\"isSteadyTest\\\" testpassed=\\\"false\\\" type=\\\"failure\\\" />\\n\", \"<test exectype=\\\"junit.framework.AssertionFailedError\\\" message=\\\"numberOfLivingNeighbors(0,2) not as expected expected:&lt;1&gt; but was:&lt;0&gt;\\\" name=\\\"numberOfLivingNeighborsTest\\\" testpassed=\\\"false\\\" type=\\\"failure\\\" />\\n\", \"<test name=\\\"objConsTest\\\" testpassed=\\\"true\\\" />\\n\", \"<test exectype=\\\"junit.framework.AssertionFailedError\\\" message=\\\"nextCellState(1,10) not as expected expected:&lt;true&gt; but was:&lt;false&gt;\\\" name=\\\"nextCellStateTest\\\" testpassed=\\\"false\\\" type=\\\"failure\\\" />\\n\", \"<test exectype=\\\"junit.framework.AssertionFailedError\\\" message=\\\"tick() does not work as expected. The result should be:&#10;false false false &#10;false false false &#10;false false false &#10;: arrays first differed at element [0][0]; expected:&lt;false&gt; but was:&lt;true&gt;\\\" name=\\\"tickTest\\\" testpassed=\\\"false\\\" type=\\\"failure\\\" />\\n\", \"</testsuite>\\n\"]"

		#private_log
		# log = "[\"<testsuite errors=\\\"0\\\" failures=\\\"10\\\" hostname=\\\"localhost\\\" name=\\\"__unittest.PrivateGameOfLifeTest\\\" skipped=\\\"0\\\" tests=\\\"12\\\" time=\\\"0.115\\\" timestamp=\\\"2016-05-10T10:00:42\\\">\\n\", \"  <test exectype=\\\"junit.framework.AssertionFailedError\\\" message=\\\"cellReproduces(3) not as expected expected:&lt;true&gt; but was:&lt;false&gt;\\\" name=\\\"cellReproducesTest\\\" testpassed=\\\"false\\\" type=\\\"failure\\\" />\\n\", \"<test name=\\\"constructorTest\\\" testpassed=\\\"true\\\" />\\n\", \"<test exectype=\\\"junit.framework.AssertionFailedError\\\" message=\\\"isLivingNeighbor(22,10,23,10) not as expected expected:&lt;true&gt; but was:&lt;false&gt;\\\" name=\\\"isLivingNeighborTest\\\" testpassed=\\\"false\\\" type=\\\"failure\\\" />\\n\", \"<test exectype=\\\"junit.framework.AssertionFailedError\\\" message=\\\"isNeighbor(1,1,1,2) not as expected expected:&lt;true&gt; but was:&lt;false&gt;\\\" name=\\\"isNeighborTest\\\" testpassed=\\\"false\\\" type=\\\"failure\\\" />\\n\", \"<test exectype=\\\"junit.framework.AssertionFailedError\\\" message=\\\"isCellInGameField(99,99) not as expected expected:&lt;true&gt; but was:&lt;false&gt;\\\" name=\\\"isCellInGameFieldTest\\\" testpassed=\\\"false\\\" type=\\\"failure\\\" />\\n\", \"<test exectype=\\\"junit.framework.AssertionFailedError\\\" message=\\\"isOvercrowded(4) not as expected expected:&lt;true&gt; but was:&lt;false&gt;\\\" name=\\\"isOvercrowdedTest\\\" testpassed=\\\"false\\\" type=\\\"failure\\\" />\\n\", \"<test exectype=\\\"junit.framework.AssertionFailedError\\\" message=\\\"isLonely(0) not as expected expected:&lt;true&gt; but was:&lt;false&gt;\\\" name=\\\"isLonelyTest\\\" testpassed=\\\"false\\\" type=\\\"failure\\\" />\\n\", \"<test exectype=\\\"junit.framework.AssertionFailedError\\\" message=\\\"isSteady(2) not as expected expected:&lt;true&gt; but was:&lt;false&gt;\\\" name=\\\"isSteadyTest\\\" testpassed=\\\"false\\\" type=\\\"failure\\\" />\\n\", \"<test exectype=\\\"junit.framework.AssertionFailedError\\\" message=\\\"numberOfLivingNeighbors(0,2) not as expected expected:&lt;1&gt; but was:&lt;0&gt;\\\" name=\\\"numberOfLivingNeighborsTest\\\" testpassed=\\\"false\\\" type=\\\"failure\\\" />\\n\", \"<test name=\\\"objConsTest\\\" testpassed=\\\"true\\\" />\\n\", \"<test exectype=\\\"junit.framework.AssertionFailedError\\\" message=\\\"nextCellState(1,10) not as expected expected:&lt;true&gt; but was:&lt;false&gt;\\\" name=\\\"nextCellStateTest\\\" testpassed=\\\"false\\\" type=\\\"failure\\\" />\\n\", \"<test exectype=\\\"junit.framework.AssertionFailedError\\\" message=\\\"tick() does not work as expected. The result should be:&#10;false false false &#10;false false false &#10;false false false &#10;: arrays first differed at element [0][0]; expected:&lt;false&gt; but was:&lt;true&gt;\\\" name=\\\"tickTest\\\" testpassed=\\\"false\\\" type=\\\"failure\\\" />\\n\", \"</testsuite>\\n\"]"


		begin
			log_tmp = ActiveSupport::JSON.decode("{ \"wrapper\": #{log} }")['wrapper'].join("")

		rescue JSON::ParserError
			log_tmp = log
		end
		doc = Nokogiri::XML(log_tmp)

		good_class 	= '<span class="good-case">'
		bad_class 	= '<span class="bad-case">'

		testsuite = doc.xpath('//testsuite')
	    txt = ""
	    if testsuite.length == 1
			failures = Integer(testsuite[0]["failures"])
			errors   = Integer(testsuite[0]["errors"])

	      	status = (failures == 0 && errors == 0)


	     	if status
	      		class_case = good_class
	    	else
	    		class_case = bad_class
	  		end

	  		txt += class_case
			txt += '<h3 style="font-size:150%;">'
			txt += "Summary: #{failures} failures | #{errors} errors</span>"
			txt += '</h3>'
			txt += "<br>"

	      	doc.xpath('//test').each do |test|
	        	
	        	test_case = "Test: " + test["name"] + " | Passed: " + test["testpassed"]

	        	if test["testpassed"] == 'true'
	        		class_case = good_class
	        	else
	        		class_case = bad_class
	        		test_case += '<br>'
					test_case += "Type: " + test["type"] + " | Message: " + CGI::escapeHTML(test["message"].to_s)
	        	end

	        	txt += class_case
	        	txt += test_case
	        	txt += "</span><br><br>"
	        end

        else
           txt = bad_class
           txt += '<p style="font-size:130%;">'
      	   txt += "testsuite error:"
      	   txt += '</p>'
      	   # txt += "<br>"
      	   txt += "Es war nicht möglich Ihre Abgabe automatisch zu testen.<br>"
      	   txt += "Vermutlich stimmt die Struktur Ihrer Abgabe nicht mit der vorgegebenen Struktur überein.</span><br><br>"

      	   txt += "Nichtsdestotrotz wurde Ihre Abgabe im System gespeichert und kann von Ihrem Tutor bewertet werden. <br>"
      	   txt += "Hinweis: Versuchen Sie es gerne weiter. Nur die jeweils letzte Abgabe jeder Aufgabe wird von ihrem Tutor bewertet. <br>"
      	   txt += ""
      	end

      	# txt += "<br>debug<br> #{log_tmp} "

		output = txt.html_safe
	end	  
end