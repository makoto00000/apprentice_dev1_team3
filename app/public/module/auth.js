class Auth {
  static logoutUser() {
    // サーバーにログアウト情報を送信
    fetch('http://localhost:8000/api/logout')
      .then(response => {
        if (response.ok) {
          document.getElementById('loginStatus').textContent = 'Logout successful';
          window.location.reload();
        } else {
          document.getElementById('loginStatus').textContent = 'Logout failed';
        }
      })
      .catch(error => console.error('Error during logout:', error));
  }

  static async isLoggedIn() {
      const response = await fetch('/api/is_logged_in');
      const data = await response.json();
      return data.isLoggedIn;
  }
};
