document.addEventListener('DOMContentLoaded', function() {
  const form = document.getElementById('login_form');
  const loginMessage = document.getElementById('login_message');

  form.addEventListener('submit', async function(event) {
    event.stopPropagation();
    event.preventDefault();

    const formData = new FormData(form);

    try {
      const response = await fetch('/api/login', {
        method: 'POST',
        body: formData
      });
      
      
      if (!response.ok) {
        const responseData = await response.json();
        data = JSON.parse(JSON.stringify(responseData, null, 2))
        loginMessage.textContent = data.message;
        throw new Error('Network response was not ok');
      } else {
        window.location.href = "/recipes";
      }


      // レスポンスを表示または処理する
    } catch (error) {
      console.error('Fetch error:', error);
    }
  });
});
