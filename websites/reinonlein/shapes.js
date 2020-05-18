const canvas2 = d3.select('.canvas2');

// append the SVG container
const svg2 = canvas2.append('svg')
  .attr('width', 600)
  .attr('height', 600);

// create a group
const group2 = svg2.append('g')
  .attr('transform', 'translate(0, 100)');

// append the SVG elements to the SVG container
group2.append('rect')
  .attr('width', 150)
  .attr('height', 100)
  .attr('fill', 'blue')
  .attr('x', 20)
  .attr('y', 20);

group2.append('circle')
  .attr('r', 50)
  .attr('cx', 300)
  .attr('cy', 70)
  .attr('fill', 'green');

group2.append('line')
  .attr('x1', 370)
  .attr('x2', 600)
  .attr('y1', 20)
  .attr('y2', 120)
  .attr('stroke', 'red')
  .attr('stroke-width', 5);

svg2.append('text')
  .attr('x', 20)
  .attr('y', 200)
  .attr('fill', 'indigo')
  .text('Wat een gast!')
  .style('font-family', 'arial')
  .attr('transform', 'translate(0, -100)');