const guideList = document.querySelector('.guides');
const loggedOutLinks = document.querySelectorAll('.logged-out');
const loggedInLinks = document.querySelectorAll('.logged-in');
const accountDetails = document.querySelector('.account-details')

const setupUI = (user) => {
  if (user) {
    // show account info
    db.collection('users').doc(user.uid).get().then(doc => {

      const html = `
      <div>Logged in as ${user.email}</div>
      <div>You signed up on ${user.metadata.creationTime}</div>
      <div>And your last login was on ${user.metadata.lastSignInTime}</div>
      <div>This is your one line bio: ${doc.data().bio}</div>
      `;
      accountDetails.innerHTML = html;

    })
    

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