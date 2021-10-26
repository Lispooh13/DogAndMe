
addEventListener('load', ()=> {
  const flashWindow = document.getElementsByClassName("flash-window")[0];
  flashWindowToggle();
  setTimeout(flashWindowToggle, 3000)
 function flashWindowToggle() {
    flashWindow.classList.toggle("hidden");
  } 
});