const chart1 = document.querySelector('#chart1')
const chart2 = document.querySelector('#chart2')
const chart3 = document.querySelector('#chart3')


// chartist experiment
// Initialize a Line chart in the container with the ID chart1
new Chartist.Line(chart1, data = {
    labels: [1, 2, 3, 4],
    series: [[100, 120, 180, 200]]
  }, options={height: 300});
  
  // en zelf nummer 3 toegevoegd:
  var data = { series: [5, 3, 4] };
  var sum = function(a, b) { return a + b };
  new Chartist.Pie(chart2, data, {
  labelInterpolationFnc: function(value) {
    return Math.round(value / data.series.reduce(sum) * 100) + '%';
  } 
  });

  
// haal category counts binnen
fetch('https://www.wateengast.nl/wp-json/wp/v2/categories?per_page=10')
  .then(response => response.json())
  .then(json => console.log(json.map(item => item.name), json.map(item => item.count)));

/// en stop ze in een grafiek!
fetch('https://www.wateengast.nl/wp-json/wp/v2/categories?per_page=20')
  .then(response => response.json())
  .then(json => new Chartist.Bar('#chart3', {
    labels: json.map(item => item.name),
    series: [json.map(item => item.count)]
  }, options={ height: 400}));


  
