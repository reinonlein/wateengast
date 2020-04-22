const guideList = document.querySelector('.guides');
const loggedOutLinks = document.querySelectorAll('.logged-out');
const loggedInLinks = document.querySelectorAll('.logged-in');
const accountDetails = document.querySelector('.account-details');
const adminItems = document.querySelectorAll('.admin');

const setupUI = (user) => {
  if (user) {
    if(user.admin){
      adminItems.forEach(item => item.style.display = 'block');
    }
    // show account info
    db.collection('players').doc(user.uid).get().then(doc => {

      const html = `
      <div>Logged in as ${user.email} with metadata sign up: ${user.metadata.creationTime}</div><br>
      <div>Dit is je buildings array: ${doc.data().buildings}</div>
      <div>Zit daar een piramide in? ${doc.data().buildings.includes('pyramids')}</div>
      <div>Dit is je dictionary: ${doc.data().dictionary}</div>
      <div>All entries: ${Object.entries(doc.data().dictionary)}</div>
      <div>Keys: ${Object.keys(doc.data().dictionary)}</div>
      <div>Values: ${Object.values(doc.data().dictionary)}</div>
      <div>Barracks gebouwd op: ${doc.data().dictionary['barracks']}</div>
      <div>Aantal gebouwen: ${Object.keys(doc.data().dictionary).length}</div>
      <div>${doc.data().buildings.includes('pyramids') ? 'color 5 exists!' : 'color 5 does not exist!'}</div>
      <div>Dit is je start timestamp: ${doc.data().start}</div>
      <br>
      <h5>Dit heb je al gebouwd:</h5>
      ${doc.data().buildings.includes('pyramid') ? '<img src="img/pyramid.jpg" alt="pyramide">' : '<div>In elk geval geen piramide</div>'} 
      ${Object.keys(doc.data().dictionary).includes('granary') ? '<img src="img/granary.jpg" alt="granary">' : '<div>In elk geval geen granary</div>'} 
         
      `;
      accountDetails.innerHTML = html;

    });
    

    // toggle UI elements
    loggedInLinks.forEach(item => item.style.display = 'block');
    loggedOutLinks.forEach(item => item.style.display = 'none');
  } else {
    adminItems.forEach(item => item.style.display = 'none');
    // hide account info
    accountDetails.innerHTML = '';
    loggedInLinks.forEach(item => item.style.display = 'none');
    loggedOutLinks.forEach(item => item.style.display = 'block');
  }
}

// setup guides
const setupGuides = (data) => {

  if(data.length) {
    let html = '';
    data.forEach(doc => {
      const guide = doc.data();
      const li = `
        <li>
          <div class="collapsible-header grey lighten-4">${guide.title}</div>
          <div class="collapsible-body white">${guide.content}</div>
        </li>
      `;
      html += li
    });

    guideList.innerHTML = html;

  } else {
    guideList.innerHTML = '<h6 class="center-align">Please login to view the guides</h6>';
  }
}

// setup materialize components
document.addEventListener('DOMContentLoaded', function() {

  var modals = document.querySelectorAll('.modal');
  M.Modal.init(modals);

  var items = document.querySelectorAll('.collapsible');
  M.Collapsible.init(items);

});