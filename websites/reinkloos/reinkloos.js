const voornaam = document.querySelector("#voornaam");
const achternaam = document.querySelector("#achternaam");


function switchVoornaam() {switch (voornaam.innerText) {
    case "REIN":
        voornaam.innerText = "GAST";
      break;
    case "GAST":
        voornaam.innerText = "REIN";
      break;
  }
};

function switchAchternaam() {switch (achternaam.innerText) {
    case "KLOOS":
        achternaam.innerText = "ONLEIN";
      break;
    case "ONLEIN":
        achternaam.innerText = "GAST";
      break;
    case "GAST":
        achternaam.innerText = "KLOOS";
      break;
  }
};