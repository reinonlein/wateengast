const voornaam = document.querySelector("#voornaam");
const achternaam = document.querySelector("#achternaam");
const email = document.querySelector("#email");


function switchVoornaam() {switch (voornaam.innerText) {
    case "REIN":
        voornaam.innerText = "DATA";
      break;
    case "DATA":
        voornaam.innerText = "CREATIVE";
      break;
    case "CREATIVE":
        voornaam.innerText = "WEB";
      break;
    case "WEB":
      voornaam.innerText = "DEEP";
    break;
    case "DEEP":
        voornaam.innerText = "BEAUTIFUL";
      break;
    case "BEAUTIFUL":
        voornaam.innerText = "CONTACT";
      break;
    case "CONTACT":
        voornaam.innerText = "REIN";
      break;
  }
};

function switchAchternaam() {switch (achternaam.innerText) {
    case "KLOOS":
        achternaam.innerText = "SCIENCE";
      break;
    case "SCIENCE":
        achternaam.innerText = "ANALYTICS";
      break;
    case "ANALYTICS":
        achternaam.innerText = "VISUALISATION";
      break;
    case "VISUALISATION":
        achternaam.innerText = "WRITING";
      break;
    case "WRITING":
        achternaam.innerText = "LEARNING";
      break;
    case "LEARNING":
        achternaam.innerText = "ME";
    break;
    case "ME":
        achternaam.innerText = "KLOOS";
    break;
  }
};