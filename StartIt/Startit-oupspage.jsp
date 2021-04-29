<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="StartitClasses.*, java.util.*"%>
<%People user = (People)session.getAttribute("userObj");%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/startit-oupspage.css" />
        <meta http-equiv="refresh" content="4;url=Startit-applications.jsp" />
        <title>Welcome to StartIt</title>
        
    </head>
<body>
    <header class="hero">
        <div class="navbar" >
          <div class="logo2">
            <a href="#Startit-profil.html">StartIt</a>
          </div>
          <nav>
            <ul>
                <li><a href=""><img src="images/connection.png" alt="" style="width: 45px; margin-top: 1vw"></a></li>
                <li><a href=""><img src="images/team.svg" alt="" style="width: 50px; margin-top: 0.5vw;"></a></li>
                <li><a href=""><img src="images/notification 2.png" alt="" style="width: 55px; margin-top: 0.5vw;"></a></li>
                <li><a href="Startit-profile.jsp"><img src="Uploads/<%= user.getID()%>.jpg" onerror="this.onerror=null; this.src='Uploads/user.jpg'" alt="" style="border: 1px solid grey; border-radius: 50%; width: 80px; height: 80px;"></a></li>
            </ul>
         </nav>  
        </div>  
    </header>
    <main>
        Oops we couldn't find your team...
    </main>
  
</body>
</html>