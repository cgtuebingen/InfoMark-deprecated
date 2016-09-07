
# SOLVER = "/home/wieschol/scratch/symphony/bin/symphony"
# MODEL = "/home/wieschol/scratch/symphony/model.txt"
# DATA = "/home/wieschol/scratch/symphony/data.txt"

# ans = system("#{SOLVER} -F #{MODEL} -D #{DATA} | grep -oP '\\[\\d*,\\d*\\]' > run.txt")
# # data =  File.readlines "run.txt"
# data = File.open("run.txt") do |f|
#   f.each_line do |line|
#     l = line.sub("[","").sub("]","").split(",")
#     puts "user #{l[0]} choose #{l[1]}"

#   end
#   f.close()
# end

# groups      = Course.find(1).course_groups.map(&:id)
# puts groups
# students    = Enrollment.where(course_id: 1, role: 0)
# enrollments = GroupEnrollmentPreference.where(course_group_id: groups, user:students.map(&:user_id))
# # # # #enrollments.delete

# puts "set group:=   " + groups.join(" ")   +";"
# puts "set student:= " + students.map(&:user_id).join(" ") +";"
# puts ""
# puts "param pref:"+ groups.join(" ")+":="
# # puts "     "

# students.each do |student|

#    ratings = GroupEnrollmentPreference.where(user: student, course_group_id: groups).order(:course_group_id) #.map(&:rating).join(" ")
#    puts ratings
#    puts student.id 
# end