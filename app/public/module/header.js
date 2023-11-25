
const searchInput = document.getElementById('search_recipe_input')
const placeholder = document.getElementById('place_holder')
placeholder.addEventListener('click', function() {
  searchInput.focus();
})
searchInput.addEventListener('focus', function() {
  placeholder.style.display = 'none';
})
searchInput.addEventListener('blur', function() {
  placeholder.style.display = '';
})


const hoverKinds = document.getElementById('kinds')
const hoverMenuKinds = document.getElementById('kinds_hover')
const hoverTastes = document.getElementById('tastes')
const hoverMenuTastes = document.getElementById('tastes_hover')
hoverMenuKinds.addEventListener ("mouseover", function() {
  hoverKinds.style.opacity = "1"
  hoverKinds.style.visibility = "visible"
  hoverKinds.style.zIndex = "9999"
  hoverTastes.style.zIndex = "1"
  hoverTastes.style.opacity = "0"
  hoverTastes.style.visibility = "hidden"

})
hoverKinds.addEventListener ("mouseover", function() {
  hoverKinds.style.opacity = "1"
  hoverKinds.style.visibility = "visible"
})
hoverKinds.addEventListener ("mouseout", function() {
  hoverKinds.style.opacity = "0"
  hoverKinds.style.visibility = "hidden"
})

hoverMenuTastes.addEventListener ("mouseover", function() {
  hoverTastes.style.opacity = "1"
  hoverTastes.style.visibility = "visible"
  hoverTastes.style.zIndex = "9999"
  hoverKinds.style.zIndex = "1"
  hoverKinds.style.opacity = "0"
  hoverKinds.style.visibility = "hidden"
})
hoverTastes.addEventListener ("mouseover", function() {
  hoverTastes.style.opacity = "1"
  hoverTastes.style.visibility = "visible"
})
hoverTastes.addEventListener ("mouseout", function() {
  hoverTastes.style.opacity = "0"
  hoverTastes.style.visibility = "hidden"
})
