module ApplicationHelper
  def glink_to(name, glyph, path, options={})
    link_to "<span class=\"glyphicon glyphicon-#{glyph}\"></span> #{name}".html_safe, path, options
  end

  def mlink_to(name, glyph, path, options={})
    link_to "<i class=\"material-icons\">#{glyph}</i><span>#{name}</span>".html_safe, path, options
  end

  def badge_for_submission(submission, options={css: ""})

    css = options[:css]
    if submission.queued?
      "<span class=\"label label-warning #{css}\">progress</span>".html_safe
    elsif submission.failure?
      "<span class=\"label label-danger #{css}\">error</span>".html_safe
    elsif submission.finished?
      "<span class=\"label label-success #{css}\">finished</span>".html_safe
    else
      "<span class=\"label label-danger #{css}\">fatal</span>".html_safe
    end
  end

  def highest_role(user)
    Enrollment.roles[Enrollment.where(user: user).order(role: :desc).first.role]
  end

  def role_in_course(user, course)
    # in rails 5 this is "my_model.sale_info_before_type_cast"

    Enrollment.where(user: user, course: course).first[:role]
  end


  def result_of_submission_img(submission, options={css: "", size:"small"})
    css = options[:css]

    if submission.queued?
      image_path("unknown-case-#{options[:size]}.gif")
    else
      unless submission.log.nil?
        unless submission.log.empty?
          if submission.log.include?("Passed: false")
            image_path("bad-case-#{options[:size]}.png")
          else
            image_path("good-case-#{options[:size]}.png")
          end
        else
          image_path("bad-case-#{options[:size]}.png")
        end
      else
        image_path("bad-case-#{options[:size]}.png")
      end
    end
  end


  def markdown(text)

    unless text.nil?
      options = {
        filter_html:     true,
        hard_wrap:       true,
        link_attributes: { rel: 'nofollow', target: "_blank" },
        space_after_headers: true,
      }

      extensions = {
        autolink:           true,
        superscript:        true,
      }

      renderer = Redcarpet::Render::HTML.new(options)
      markdown = Redcarpet::Markdown.new(renderer, extensions)

      markdown.render(text).html_safe
    end
  end



  #   class ActionView::Helpers::FormBuilder
  #     # http://stackoverflow.com/a/2625727/1935918
  #     include ActionView::Helpers::FormTagHelper
  #     include ActionView::Helpers::FormOptionsHelper

  #     def date_picker(label, *args)
  #       options = args.extract_options!
  #       options.reverse_merge! label: nil
  #       options.reverse_merge! class: "date"
  #       args << options
  #       puts options
  #       # @template.content_tag("div", text_field(label, options) )
  #       @template.content_tag("div", text_field(label, options) )
  #     end

  #     # def date_picker2(name, title, addon, *args)
  #     #   options = args.extract_options!               # remove the option hashes
  #     #   options.reverse_merge! label: nil
  #     #   args << options                               # put them back into the array
  #     #   puts "##############"
  #     #   puts name
  #     #   puts "##############"
  #     #   @template.text_field(name,title,args)
  #     #   #send text_field(name,*args)

  #     #   # @template.content_tag(:div,
  #     #   #                       @template.text_field(name, *args) + @template.content_tag(:span, addon, class: 'input-group-addon'),
  #     #   #                       class: 'input-group date date-picker', data: {picker: "date-time"})
  #     # end
  #   end



end

# # def text_field(object_name, method, options = {})
# #         Tags::TextField.new(object_name, method, self, options).render
# #       end

# # <div class="form-group">
# #                 <div class='input-group date' id='datetimepicker2'>
# #                     <input type='text' class="form-control" />
# #                     <span class="input-group-addon">
# #                         <span class="glyphicon glyphicon-calendar"></span>
# #                     </span>
# #                 </div>
# #             </div>


# # <div class="form-group">
# # <label class="control-label" for="exercise_sheet_publish">
# # Publish</label>
# # <input class="form-control nil" type="text" value="2016-01-02 14:57:00 +0100" name="exercise_sheet[publish]" id="exercise_sheet_publish">
# # </div>
