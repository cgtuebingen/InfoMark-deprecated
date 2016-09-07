 //<![CDATA[

var ready;


// $(document).ready(ready);
// $(document).on('page:load', ready);
$(document).on('ready page:change', ready);

        ready = function() {
            // fun from Patrick
                // get the size of the window
                width = window.innerWidth;
                height = window.innerHeight;
                // select the svg object
                var svg = d3.select('svg').attr("width", width).attr("height", height);
                // start in the middle
                var target = {
                    x: width / 2,
                    y: height / 2
                }
                // distance between two points
                function getDistance(p1, p2) {
                    return Math.pow(p1.x - p2.x, 2) + Math.pow(p1.y - p2.y, 2);
                }
                var circle;

                function updatePoints(points) {

                    svg.selectAll('circle')
                        .data(points)
                        .transition().duration(50)
                        .attr('r', function(d) {
                            return d.r;
                        })
                        .attr("class",function(d){if(d.active==0)return ""; else return "active";})
                    .attr("fill",function(d){return 'rgba(165,30,55,' + d.active + ')'});

                    
                }

                var lines = [];

                function drawLines(p) {
                    if (!p.active) return;
                    for (var i in p.closest) {
                        svg.append('line')
                            .attr("x1", p.x)
                            .attr("y1", p.y)
                            .attr("x2",p.closest[i].x)
                            .attr("y2", p.closest[i].y)
                        .attr("stroke",'rgba(165,30,55,' + p.active*0.2 + ')');
                    }
                }

                function mouseMove(e) {
                    var posx = posy = 0;
                    if (e.pageX || e.pageY) {
                        posx = e.pageX;
                        posy = e.pageY;
                    } else if (e.clientX || e.clientY) {
                        posx = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
                        posy = e.clientY + document.body.scrollTop + document.documentElement.scrollTop;
                    }
                    target.x = posx;
                    target.y = posy;
                    animate(points);
                    
                }
            
            function tweenCircle(points){
              /*  console.log("hi");
                (function repeat() {
                    
                    svg.selectAll("circle").transition()
                        .duration(500)
                        .attr("stroke-width", 200)
                        .attr("r", 10)
                        .transition()
                        .ease('sine')
                        .each("end", repeat);
                    
         
			})();*/
            }

                function animate(points) {
                    d3.selectAll("line").remove();
                    for (var i in points) {
                        // detect points in range
                        if (Math.abs(getDistance(target, points[i])) < 4000) {
                            points[i].r = 3;
                            points[i].active = 0.6;
                        } else if (Math.abs(getDistance(target, points[i])) < 20000) {
                            points[i].r = 2;
                            points[i].active = 0.3;
                        } else if (Math.abs(getDistance(target, points[i])) < 40000) {
                            points[i].r = 1;
                            points[i].active = 0.1;
                        } else {
                            points[i].r = 0;
                            points[i].active = 0;
                        }
                        drawLines(points[i]);
                    }
                    updatePoints(points);
                      
                   
                }
                // create points
                points = [];
                for (var x = 0; x < width; x = x + width / 20) {
                    for (var y = 0; y < height; y = y + height / 20) {
                        var px = x + Math.random() * width / 20;
                        var py = y + Math.random() * height / 20;
                        var p = {
                            x: px,
                            originX: px,
                            y: py,
                            originY: py
                        };
                        var p = {
                            x: px,
                            originX: px,
                            y: py,
                            originY: py
                        };
                        points.push(p);
                    }
                }
                // find nearest 5 points
                for (var i = 0; i < points.length; i++) {
                    var closest = [];
                    var p1 = points[i];
                    for (var j = 0; j < points.length; j++) {
                        var p2 = points[j]
                        if (!(p1 == p2)) {
                            var placed = false;
                            for (var k = 0; k < 5; k++) {
                                if (!placed) {
                                    if (closest[k] == undefined) {
                                        closest[k] = p2;
                                        placed = true;
                                    }
                                }
                            }
                            for (var k = 0; k < 5; k++) {
                                if (!placed) {
                                    if (getDistance(p1, p2) < getDistance(p1, closest[k])) {
                                        closest[k] = p2;
                                        placed = true;
                                    }
                                }
                            }
                        }
                    }
                    p1.closest = closest;
                }

                

                circle = svg.selectAll('circle').data(points)
                    .enter().append('circle').attr({
                        r: 0,
                        cx: function(d, i) {
                            return d.x
                        },
                        cy: function(d, i) {
                            return d.y
                        },
                        fill: 'red'
                    })
                .each(tweenCircle);
                animate(points);
          tweenCircle(points);

                if (!('ontouchstart' in window)) {
                    window.addEventListener('mousemove', mouseMove);
                }
               
                
            } //]]>