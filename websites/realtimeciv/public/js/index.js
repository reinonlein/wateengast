const buildingForm = document.querySelector('#building-form');
const buildingList = document.querySelector('#buildings-list');
const buildingTable = document.querySelector('#buildings-table-body');
const cardholder = document.querySelector('.cardholder');

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


// setup materialize components
document.addEventListener('DOMContentLoaded', function() {

    var modals = document.querySelectorAll('.modal');
    M.Modal.init(modals);

    var elems = document.querySelectorAll('.parallax');
    M.Parallax.init(elems);
  
});

