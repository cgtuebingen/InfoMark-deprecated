# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  $("form").on("ajax:success", (e, data, status, xhr) ->
    if data['status'] == "ok"
      $("#grading_"+data['id']+"_feedback").attr('data-sync','sync');
      $("#grading_"+data['id']+"_points").attr('data-sync','sync');
    else
      alert("Fehlermeldung: "+ data['msg'])
  ).on "ajax:error", (e, xhr, status, error) ->
    alert('ups' + status+' '+error )


  $('textarea').on('keyup', () ->
    $(this).attr('data-sync','async');
  )
  $('.point_input').on('keyup', () ->
    $(this).attr('data-sync','async');
  )


