// listen for auth status changes
auth.onAuthStateChanged(user => {
    if (user) {
        db.collection('guides').onSnapshot(snapshot => {
            setupGuides(snapshot.docs);
            setupUI(user);
        });        
    } else {
        setupGuides([]);
        setupUI();
    }
});

// create new guide

const createForm = document.querySelector('#create-form');
createForm.addEventListener('submit', (e) => {
    e.preventDefault();
  
    db.collection('guides').add({
        title: createForm['title'].value,
        content: createForm['content'].value
    }).then(() => {
        const modal = document.querySelector('#modal-create');
        M.Modal.getInstance(modal).close();
        createForm.reset();
    });
});



// signup
const signupForm = document.querySelector('#signup-form');
signupForm.addEventListener('submit', (e) => {
    e.preventDefault();
    
    // get user info
    const email = signupForm['signup-email'].value;
    const password = signupForm['signup-password'].value;

    // sign up the user
    auth.createUserWithEmailAndPassword(email, password).then(cred => {
        const modal = document.querySelector('#modal-signup');
        M.Modal.getInstance(modal).close();
        signupForm.reset();
    });
});

//logout
const logout = document.querySelector('#logout');
logout.addEventListener('click', (e) => {
    e.preventDefault();
    auth.signOut()
});


//login
const loginForm = document.querySelector('#login-form');
loginForm.addEventListener('click', (e) => {
    e.preventDefault();

    // get user info
    const email = loginForm['login-email'].value;
    const password = loginForm['login-password'].value;

    // login
    auth.signInWithEmailAndPassword(email, password).then(cred => {
        const modal = document.querySelector('#modal-login');
        M.Modal.getInstance(modal).close();
        loginForm.reset();
    });
});