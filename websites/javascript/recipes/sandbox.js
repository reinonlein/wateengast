const list = document.querySelector('ul');
const form = document.querySelector('form');
const button = document.querySelector('button');

const addRecipe = (recipe, id) => {
  let time = recipe.created_at.toDate();
  let html = `
    <li data-id="${id}">
      <div>${recipe.title}</div>
      <div><small>${time}</small></div>
      <button class="btn btn-danger btn-sm my-2">delete</button>
    </li>
  `;

  list.innerHTML += html;
};

const deleteRecipe = (id) => {
  const recipes = document.querySelectorAll('li');
  recipes.forEach(recipe => {
    if(recipe.getAttribute('data-id') === id){
      recipe.remove();
    }
  });
};

// real-time listener
const unsub = db.collection('recipes').onSnapshot(snapshot => {
  snapshot.docChanges().forEach(change => {
    const doc = change.doc;
    if(change.type === 'added'){
      addRecipe(doc.data(), doc.id)
    } else if (change.type === 'removed'){
      deleteRecipe(doc.id);
    }
  });
});

// save documents
form.addEventListener('submit', e => {
  e.preventDefault();

  const now = new Date();
  const recipe = {
    title: form.recipe.value,
    created_at: firebase.firestore.Timestamp.fromDate(now)
  };

  db.collection('recipes').add(recipe).then(() => {
    //console.log('recipe added');
    form.reset();
  }).catch(err => {
    console.log(err);
  });
});

// deleting data
list.addEventListener('click', e => {
  if(e.target.tagName === 'BUTTON'){
    const id = e.target.parentElement.getAttribute('data-id');
    db.collection('recipes').doc(id).delete().then(() => {
      // console.log('recipe deleted');
    });
  }
});

button.addEventListener('click', e => {
  unsub();
  console.log('unsubscribed');
});