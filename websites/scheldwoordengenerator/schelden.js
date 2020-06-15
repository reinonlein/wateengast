const voornaam = document.querySelector("#voornaam");
const achternaam = document.querySelector("#achternaam");
const email = document.querySelector("#email");



function switchVoornaam() {
  voornaam.innerText = rando(["SCHIJT", "KUT", "HERPES", "HOEREN", "ROT", "SCHURFT", "PLEURIS", "KLOTE", "SNOT"]).value;
};


function switchAchternaam() {
  achternaam.innerText = rando(["HOER", "WIJF", "LIJER", "LUL", "JONG", "GAST", "HOND", "SCROTUM", "ZAK"]).value;
};