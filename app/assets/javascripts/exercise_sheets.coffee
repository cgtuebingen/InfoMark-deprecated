# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
`      function startTimer(publish, deadline, display, pgb) {
              var w =  Math.abs(deadline - publish) / 1000;
                setInterval(function () {
                  var now = new Date();
                  var delta = Math.abs(deadline - now) / 1000;
      
                  if(delta > 0){
                    var days = Math.floor(delta / 86400);
                    delta -= days * 86400;
                    var hours = Math.floor(delta / 3600) % 24;
                    delta -= hours * 3600;
                    var minutes = Math.floor(delta / 60) % 60;
                    delta -= minutes * 60;
                    var seconds = Math.floor(delta % 60);
      
      
                    days    = days    < 10 ? "0" + days    : days;
                    hours   = hours   < 10 ? "0" + hours   : hours;
                    minutes = minutes < 10 ? "0" + minutes : minutes;
                    seconds = seconds < 10 ? "0" + seconds : seconds;
      
                    var txt = '';
      
                    if(days > 0 )
                      txt += days + "d ";
                    if(hours > 0 )
                      txt += hours + "h ";
                    if(minutes > 0 )
                      txt += minutes + "m ";
                    if(seconds > 0 )
                      txt += seconds + "s ";
      
                    display.text(txt);
                    delta = Math.abs(deadline - now) / 1000;
                    pgb.css('width', 100-delta/w*100+'%').attr('aria-valuenow', delta);
                    pgb.text(Math.floor(100-delta/w*100) + '%');
                  }else{
      
      
                    display.text("abgelaufen");
                    delta = Math.abs(deadline - now) / 1000;
                    pgb.css('width', 100+'%').attr('aria-valuenow', delta);
                    pgb.text(Math.floor(100) + '%');
                  }
                }, 1000);
            }
      
            $(document).on('ready page:change', function () {
                var display = $('#timer');
                var pgb = $('#timer-pgb');
                var deadline = new Date(display.data("deadline"));
                var publish = new Date(display.data("publish"));
                pgb.attr('aria-valuemax', Math.abs(deadline - publish) / 1000);
                startTimer(publish, deadline, display, pgb);
            });
`