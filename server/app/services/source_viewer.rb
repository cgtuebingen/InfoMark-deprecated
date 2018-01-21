require 'simplabs/highlight'

class SourceViewer
 

  def highlight(can_comment, current_user, language, code, filename, submission_id)

    submission = Submission.find(submission_id)

    comments = Linecomment.where(file_name: filename, submission_id: Submission.deobfuscate_id(submission_id)).pluck(:line, :comment, :id)
    # comments = Linecomment.where(file_name: "lib.java", submission_id: 53)

    # highlight code
    lines = Simplabs::Highlight.highlight(language, code).split("\n")

    # check permission

    #Grading.where(submission_id: 5).first.ready?
    # get view with line numbers
    nr = 0;
    out = []

    out << "<table>"
    out << "<tbody>"
    lines.each do |line|
      out << "<tr data-filename=\""<<filename<<"\" data-submission=\""<<submission_id<<"\" data-line-number=\""<< nr<<"\">"
      out << "<td class=\"blob-num\">" << nr << "</td>"
      out << "<td class=\"blob-code-inner\">" 
      if can_comment
        out << '<span class="add-line-comment" onclick="add_row(\'' << nr <<'\', \'' << filename <<'\', \'' << submission_id <<'\');" > ' 
      end
      out << '<svg aria-hidden="true" class="line-plus" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path stroke="white" fill="white" d="M12 9H7v5H5V9H0V7h5V2h2v5h5v2z"></path></svg>' 
      out << "</span>"
      out << line << "</td>"
      out << "</tr>"


      # unless comments[nr].nil?
      unless comments.select{ |c_nr, c_txt, c_id| c_nr == nr}.empty?
        local = comments.select{ |c_line, c_comment, c_id| c_line == nr}[0]
        out << "<tr data-comment_for_file=\""<< filename << "\" data-comment_for_line=\""<< local[0] << "\" data-comment-id=\""<< local[2] << "\">"
        out << "<td class=\"blob-num\">"  << "</td>"
        out << "<td class=\"blob-comment\">" << local[1] << "</td>"
        out << "</tr >"
      end

      nr = nr +1
    end
    out << "</tbody>"
    out << "</table>"
    out.join("").html_safe
  end

  
end
