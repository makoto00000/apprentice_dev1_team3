document.addEventListener('DOMContentLoaded', async () => {
  const isLoggedIn = await Auth.isLoggedIn();

  if (isLoggedIn) {
    const response = await fetch('/api/get_current_user')
    const data = await response.json()
    user = JSON.stringify(data, null, 2)
    userdata = JSON.parse(user)
    document.getElementById('user_id').textContent = "ユーザーID:" + userdata.id;
    document.getElementById('user_name').textContent = "ユーザーネーム:" + userdata.name;
    document.getElementById('user_email').textContent = "メールアドレス:" + userdata.email;
    document.getElementById('user_password').textContent = "パスワード:" + userdata.password;
    document.getElementById('user_image').textContent = "ユーザーイメージ:" + userdata.image;
    document.body.innerHTML += `
    <button onclick="Auth.logoutUser()">Logout</button>
    `;
    document.getElementById("login_form").remove();
  } else {

  }
});