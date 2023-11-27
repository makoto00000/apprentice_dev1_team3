document.addEventListener('DOMContentLoaded', function() {
  const signup_form = document.getElementById('signup_form');
  // const signupMessage = document.getElementById('signup_message');

  signup_form.addEventListener('submit', async function(event) {
    event.stopPropagation();
    event.preventDefault();

    const formData = new FormData(signup_form);

    try {
      const response = await fetch('/api/signup', {
        method: 'POST',
        body: formData
      });

      if (!response.ok) {
        const responseData = await response.json();
        data = JSON.parse(JSON.stringify(responseData, null, 2))
        console.log(data)
        throw new Error('Network response was not ok');
      } else {
        window.location.href = "/";
      }

      // レスポンスを表示または処理する
    } catch (error) {
      console.error('Fetch error:', error);
    }
  });
});