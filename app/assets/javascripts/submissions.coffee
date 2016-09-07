# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

uniqueId = (length=8) ->
    id = ""
    id += Math.random().toString(36).substr(2) while id.length < length
    id.substr 0, length

commentToRow = (obj) ->
  $new_row = $('<tr />', {id: "comment_"+obj.id, "data-comment_id": obj.id, "data-comment_for_file": obj.file_name, "data-comment_for_line": obj.line})
  $new_row.append($('<td />', {class: 'blob-num'}) )
  $new_row.append($('<td />', {class: 'blob-comment', text: obj.comment}) )
  if obj.comment == null
    return ""
  return $new_row

@add_row = (nr,fn,sid) ->
  ru = uniqueId()
  $new_row = $('<tr />', {id: ru})
  $('<td />', {class: '', text: "hi"}) 
  $new_row = $new_row.append($('<td />', {class: '', text: ""}) )
  u = uniqueId()
  console.log "do /linecomments/new.js?line="+nr+"&uid="+u+"&fn="+fn+"&sid="+sid
  $.ajax
    url: "/linecomments/new.js?line="+nr+"&uid="+u+"&fn="+fn+"&sid="+sid
    dataType: "html"
    error: (jqXHR, textStatus, errorThrown) ->
      $new_row = $new_row.append($(document.createElement("td")).append("failed"))
      console.log "AJAX Error: #{textStatus}"
    success: (data, textStatus, jqXHR) ->
      console.log "got form"
      console.log data
      $form = data
      $el = $($form)
      $el 
      .bind "ajax:success", (event, data, status, xhr) ->
        console.log "success"
        console.log "/linecomments/"+sid+".json?line="+nr+"&fn="+fn+"&sid="+sid
        $.ajax
          url: "/linecomments/"+sid+".json?line="+nr+"&fn="+fn+"&sid="+sid
          dataType: "json"
          success: (data2, textStatus, jqXHR) ->
            console.log data2
            $("[data-comment_for_file=\""+fn+"\"][data-comment_for_line=\""+nr+"\"]").remove()
            console.log "switch to comment"
            console.log data2.comment
            $("#"+ru).replaceWith(commentToRow(data2))
      .on "ajax:failure", (event, data, status, xhr) ->
        console.log "failed"
        console.log data
        console.log event
        console.log status
        console.log xhr
        {}
      $new_row = $new_row.append($('<td />', {class: 'inline-comment', html: $el}) )
      $("[data-comment_for_file=\""+fn+"\"][data-comment_for_line=\""+nr+"\"]").remove()
      

  $("[data-line-number=\""+nr+"\"][data-filename=\""+fn+"\"]").after($new_row);

@delete_row = (nr,fn,sid) ->
  $.ajax
    url: "/linecomments/"+sid+".js"
    dataType: "html"
    data: {"_method":"delete"}
    error: (jqXHR, textStatus, errorThrown) ->
      $new_row = $new_row.append($(document.createElement("td")).append("failed"))
      alert "AJAX Error: #{textStatus}"
    success: (data, textStatus, jqXHR) ->
      $("#"+ru).replaceWith(commentToRow(data2))
      $new_row = $new_row.append($new_row = $new_row.append($('<td />', {class: 'inline-comment', html: $el}) ))

  $("[data-line-number=\""+nr+"\"]").after($new_row);

  




  


  