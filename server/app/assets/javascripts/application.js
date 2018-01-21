// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.easy-pie-chart
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .
//= require twitter/bootstrap/rails/confirm
//= require codemirror
//= require codemirror/modes/markdown
//= require moment
//= require bootstrap-datetimepicker
//= require jquery.raty
//= require ratyrate
//= require palette
//= require nprogress
//= require nprogress-turbolinks
//= require Chart

$(document).on('page:change', function () {
  
  // Actions to do
  $(".markdown-area").each(function() {
    CodeMirror.fromTextArea($(this).get(0), {
      lineNumbers: true,
      mode: $(this).attr('data-lang')
    });
  });

});