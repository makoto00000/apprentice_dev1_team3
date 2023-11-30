
// テキスト検索
const searchRecipeInput = document.getElementById('search_recipe_input')
const placeholder = document.getElementById('place_holder')
let inputValue = ""

placeholder.addEventListener('click', function() {
  searchRecipeInput.focus();
})

searchRecipeInput.addEventListener('focus', function() {
  placeholder.style.display = 'none';
})

searchRecipeInput.addEventListener('blur', function(e) {
  if (inputValue === "") {
    placeholder.style.display = '';
  }
})

searchRecipeInput.addEventListener('keyup', function() {
  inputValue = this.value;
})

searchRecipeInput.addEventListener('keypress', function(e) {
  if (e.key === 'Enter') {
    window.location.href = `/recipes?searchWord=${this.value}`;
  }
})

// ホバーメニューを表示させる
const hoverKinds = document.getElementById('kinds')
const hoverMenuKinds = document.getElementById('kinds_hover_open')
const hoverTastes = document.getElementById('tastes')
const hoverMenuTastes = document.getElementById('tastes_hover_open')
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

// ログイン状態で表示を切り替え
document.addEventListener('DOMContentLoaded', async () => {
  const isLoggedIn = await Auth.isLoggedIn();
  writeRecipeLink = document.getElementById('write_recipe_link');
  loginButton = document.getElementById('header_login_button');
  userIcon = document.getElementById('user_icon');
  userIconImage = document.getElementById('user_icon_image');

  if (isLoggedIn) {
    const response = await fetch('/api/get_current_user')
    const data = await response.json()
    user = JSON.stringify(data, null, 2)
    userdata = JSON.parse(user)
    writeRecipeLink.style.display = "block";
    userIcon.style.display = "block";
    loginButton.style.display = "none";
    userIconImage.src = `./public/image/default_icons/${userdata.image}`;
  } else {
    userIcon.style.display = "none";
    loginButton.style.display = "block";
  }
});
