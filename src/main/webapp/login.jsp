<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SMS LOGIN PAGE</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" >
    <link href="https://fonts.googleapis.com/css2?family=Exo+2:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">


    <link rel="stylesheet" href="CSS/loginPage.css">
</head>
<body>
    
    <div class="main-box">
        <div class="top">
            STUDENT MANAGEMENT SYSTEM
        </div>

        <div class="login-box">
            <div class="box">
                <div class="box-top">
                    <img src="images/profile.png" class="image" alt="error not found">
                    <h2>Login! To Your Dashboard</h2>
                </div>
                <div class="box-bottom">
                    <form action="<%= request.getContextPath() %>/LoginServlet" method="post">
                      <% String error = (String) request.getAttribute("error");
                          if(error != null) { %>
                            <p style="color:red; text-align:center;"><%= error%></p>
                      <% } %>
                        <div class="input-box">
                            <img src="images/user.png" class="icon">
                            <input type="text" name="username" placeholder="Username">
                        </div>
                    
                        <div class="input-box">
                            <img src="images/lock.png" class="icon">
                            <input type="password" name="password" placeholder="Password">
                        </div>
                        <br>
                        <button>Login</button>
                    
                    </form>
                </div>

            </div>
        </div>
    </div>



</body>
</html>