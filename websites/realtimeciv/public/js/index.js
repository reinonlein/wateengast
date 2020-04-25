const buildingForm = document.querySelector('#building-form');
const buildingList = document.querySelector('#buildings-list');
const buildingTable = document.querySelector('#buildings-table-body');
const cardholder = document.querySelector('.cardholder');


const addBuilding = (building, id) => {
  let html = `
    <li data-id="${id}">
      <div>${building.name}</div>
      <div>${building.price}</div>
      <div><small>Created at: ${building.created_at.toDate().toISOString().split('T')[0]}</small></div>
      <button class="btn grey">delete</button>
    </li>
  `;
  buildingList.innerHTML += html;

  tablehtml = ` 
            <tr>
              <td>${building.name}</td>
              <td>${building.description}</td>
              <td>${building.price}</td>
              <td>${building.created_at.toDate().toISOString().split('T')[0]}</td>
              <tb><a class="btn-floating btn-small waves-effect waves-light grey"><i class="material-icons">add</i></a></td>
            </tr>`

  buildingTable.innerHTML += tablehtml;
};

const deleteBuilding = (id) => {
  const buildings = document.querySelectorAll('li');
  buildings.forEach(building => {
    if(building.getAttribute('data-id') === id){
      building.remove();
    }
  });
};

// real-time listener
const unsub = db.collection('buildings').onSnapshot(snapshot => {
  snapshot.docChanges().forEach(change => {
    const doc = change.doc;
    if(change.type === 'added'){
      addBuilding(doc.data(), doc.id)
    } else if (change.type === 'removed'){
      deleteBuilding(doc.id);
    }
  });
});

// save documents
buildingForm.addEventListener('submit', e => {
  e.preventDefault();

  const now = new Date();
  const building = {
    name: buildingForm['building-name'].value,
    description: buildingForm['building-description'].value,
    imageUrl: buildingForm['building-url'].value,
    price: buildingForm['building-cost'].value,
    created_at: firebase.firestore.Timestamp.fromDate(now)
  };

  db.collection('buildings').add(building).then(() => {
    //console.log('recipe added');
    buildingForm.reset();
  }).catch(err => {
    console.log(err);
  });
});

// deleting data
buildingList.addEventListener('click', e => {
  if(e.target.tagName === 'BUTTON'){
    const id = e.target.parentElement.getAttribute('data-id');
    db.collection('buildings').doc(id).delete().then(() => {
      // console.log('recipe deleted');
    });
  }
});


// setup materialize components
document.addEventListener('DOMContentLoaded', function() {

    var modals = document.querySelectorAll('.modal');
    M.Modal.init(modals);

    var elems = document.querySelectorAll('.parallax');
    M.Parallax.init(elems);
  
});





// add building to list
buildingForm.addEventListener('submit', (e) => {
  e.preventDefault();
  

  tablehtml = ` 
            <tr>
              <td>${buildingForm['building-name'].value}</td>
              <td>${buildingForm['building-cost'].value}</td>
              <td>${buildingForm['building-description'].value}</td>
            </tr>`

  buildingTable.innerHTML += tablehtml;

  cardhtml = `
      <div class="col s12 m3">
        <div class="card">
          <div class="card-image">
            <img src="${buildingForm['building-url'].value}" style="height: 10em">
            <span class="card-title">${buildingForm['building-name'].value}</span>
            <a class="btn-floating halfway-fab waves-effect waves-light red"><i class="material-icons">add</i></a>
          </div>
          <div class="card-content">
            <p>${buildingForm['building-description'].value}</p>
          </div>
          <div class="card-action">
            <a href="#">Build for ${buildingForm['building-cost'].value} credits</a>
          </div>
        </div>
      </div>
    </div>`

  cardholder.innerHTML += cardhtml;
})

