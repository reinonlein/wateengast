const lijstjes1 = document.querySelector('.lijstjes1');
const lijstjes2 = document.querySelector('.lijstjes2');
const lijstjes3 = document.querySelector('.lijstjes3');
const lijstjes4 = document.querySelector('.lijstjes4');
const lijstjes5 = document.querySelector('.lijstjes5');
const lijstjes6 = document.querySelector('.lijstjes6');
const lijstjes7 = document.querySelector('.lijstjes7');


// Beetje stoeien met data van mijn blog ophalen

let posts = fetch('https://www.wateengast.nl/wp-json/wp/v2/posts?page=2&per_page=100')
  .then(response => response.json())
  .then(json => lijstjes1.innerHTML += `<h5>Title: ${json[7].title.rendered}</h5>`)


fetch('https://www.wateengast.nl/wp-json/wp/v2/categories?per_page=10')
  .then(response => response.json())
  .then(json => lijstjes2.innerHTML += `<h5>De categorie "${json[5].name}" heeft ${json[5].count} posts</h5>`)


fetch('https://www.wateengast.nl/wp-json/wp/v2/categories?per_page=10')
.then(response => response.json())
.then(data => data.forEach(item => lijstjes3.innerHTML += `<p>${item.name} heeft ${item.count} posts</p>`));
    

const getCategoryNames2 = async () => {
  const response = await fetch('https://www.wateengast.nl/wp-json/wp/v2/categories?per_page=10')
  const data = await response.json();
  return data;
};
getCategoryNames2().then(data => data.forEach(item => lijstjes4.innerHTML += `<li>${item.name} heeft ${item.count} posts</li>`));

fetch('https://www.wateengast.nl/wp-json/wp/v2/categories?per_page=10')
  .then(response => response.json())
  .then(json => lijstjes7.innerHTML += `<p>Het totaal aantal posts uit deze selectie is: ${json.map(item => item.count).reduce((a, b) => a + b, 0)}</p>`);

///////////// FIREBASE /////////////

db.collection('rein').get().then((snapshot) => {
  console.log(snapshot.docs[0].data())
  lijstjes5.innerHTML += `<p>Print age: ${snapshot.docs[0].data().Age}</p>
                          <p>Employers: ${Object.entries(snapshot.docs[0].data().Employers)}</p>
                          <p>En door: ${Object.keys(snapshot.docs[0].data().Employers)}</p>`;
}).catch((err) => {
  console.log(err);
});


// websites lijstje
db.collection('websites').get().then((snapshot) => {
  snapshot.docs.forEach(doc => {
    lijstjes6.innerHTML += `<p>Website name: ${doc.data().name}, ${doc.data().description}</p>`;
    console.log(doc.data())
  });
}).catch((err) => {
  console.log(err);
});











