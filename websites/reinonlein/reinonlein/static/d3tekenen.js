const nieuwcanvas = d3.select('.d3tekenen');

// append the SVG container
const nieuwsvg = nieuwcanvas.append('svg')
  .attr('width', 800)
  .attr('height', 150);

nieuwsvg.append('rect')
  .attr('width', 200)
  .attr('height', 100)
  .attr('fill', 'blue')
  .attr('x', 20)
  .attr('y', 20);

nieuwsvg.append('circle')
  .attr('r', 50)
  .attr('cx', 300)
  .attr('cy', 70)
  .attr('fill', 'yellow');

nieuwsvg.append('line')
  .attr('x1', 370)
  .attr('x2', 500)
  .attr('y1', 20)
  .attr('y2', 120)
  .attr('stroke', 'green')
  .attr('stroke-width', 4);
