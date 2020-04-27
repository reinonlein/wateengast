const buildingForm = document.querySelector('#building-form');
const buildingList = document.querySelector('#buildings-list');
const buildingTable = document.querySelector('#buildings-table-body');
const cardholder = document.querySelector('.cardholder');
const welcome = document.querySelector('.welcome');
const balance = document.querySelector('#balance');

const loggedOutLinks = document.querySelectorAll('.logged-out');
const loggedInLinks = document.querySelectorAll('.logged-in');
const accountDetails = document.querySelector('.account-details');



const setupUI = (user) => {
  if (user) {
    // show account info
    db.collection('players').doc(user.uid).get().then(doc => {

      const welcomeHTML = `
      <h5 class="grey-text">Welcome back ${doc.data().player}!</h5>
      `;
      welcome.innerHTML = welcomeHTML;

      const balanceHTML = `
      <div>Gold: ${dateFns.differenceInMinutes(Date(), doc.data().startdate.toDate())}</div> 
      `;
      balance.innerHTML = balanceHTML;
      
      const html = `
      <div>Logged in as ${user.email}</div>
      <div>This is your username: ${doc.data().player}</div>
      <div>You founded your civ on: ${dateFns.format(doc.data().startdate.toDate(), 'DD-M-YYYY')}</div>
      <div>Your current balance: ${dateFns.differenceInMinutes(Date(), doc.data().startdate.toDate())} gold</div>
      `;
      accountDetails.innerHTML = html;

    });
    

    // toggle UI elements
    loggedInLinks.forEach(item => item.style.display = 'block');
    loggedOutLinks.forEach(item => item.style.display = 'none');
  } else {
    // hide account info
    accountDetails.innerHTML = '';
    loggedInLinks.forEach(item => item.style.display = 'none');
    loggedOutLinks.forEach(item => item.style.display = 'block');
  }
}





const addBuilding = (building, id) => {
  let html = `
    <li data-id="${id}">
      <div class="row valign-wrapper center z-depth-1" style="padding: 10px">
        <div class="col s2">${building.name}</div>
        <div class="col s2">${building.price}</div>
        <div class="col s3">${building.description}</div>
        <div class="col s3"><small>Created at: ${dateFns.distanceInWordsToNow(building.created_at.toDate(),{ addSuffix:true })}</small></div>
        <button class="btn">delete</button>
      </div>    
    </li>
  `;
  buildingList.innerHTML += html;

  tablehtml = ` 
            <tr>
              <td>${building.name}</td>
              <td>${building.description}</td>
              <td>${building.price}</td>
              <td>${dateFns.format(building.created_at.toDate(), 'DD-M-YYYY')}</td>
              <td>${dateFns.differenceInMinutes(Date(), building.created_at.toDate())}</td>
            </tr>`;
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
    buildingForm.reset();
  }).catch(err => {
    console.log(err);
  });
});

// deleting data
buildingList.addEventListener('click', e => {
  if(e.target.tagName === 'BUTTON'){
    const id = e.target.parentElement.parentElement.getAttribute('data-id');
    db.collection('buildings').doc(id).delete().then(() => {
      console.log('doc ' + id + ' is deleted');
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
// buildingForm.addEventListener('submit', (e) => {
//   e.preventDefault();
  
//   cardhtml = `
//       <div class="col s12 m3">
//         <div class="card">
//           <div class="card-image">
//             <img src="${buildingForm['building-url'].value}" style="height: 10em">
//             <span class="card-title">${buildingForm['building-name'].value}</span>
//             <a class="btn-floating halfway-fab waves-effect waves-light red"><i class="material-icons">add</i></a>
//           </div>
//           <div class="card-content">
//             <p>${buildingForm['building-description'].value}</p>
//           </div>
//           <div class="card-action">
//             <a href="#">Build for ${buildingForm['building-cost'].value} credits</a>
//           </div>
//         </div>
//       </div>
//     </div>`

//   cardholder.innerHTML += cardhtml;
// })

