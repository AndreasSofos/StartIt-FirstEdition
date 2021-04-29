<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="StartitClasses.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%People user = (People)session.getAttribute("userObj");%>
<% 
Startup startup = new Startup();
NotificationDao ndao = new NotificationDao();
ArrayList<Notification> notifarr = ndao.getNotifications(user.getID());
StartupDAO sdao = new StartupDAO();
ArrayList<Startup> myStartups = new ArrayList<Startup>();
if( sdao.loadMyStartups(user.getID()) != null){
	myStartups = sdao.loadMyStartups(user.getID());
}else{
	myStartups = null;
}
%>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=<header class="hero">
        <link rel="stylesheet" href="css/startit-myteams.css">
    <link rel="stylesheet" href="css/profil.css">
    <title>Document</title>
    <script src="https://kit.fontawesome.com/aec989c09b.js" crossorigin="anonymous"></script>
    <link href="https://fonts.cdnfonts.com/css/monument-extended" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="select2-4.0.12/dist/css/select2.min.css">
    <script src="js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script src="select2-4.0.12/dist/js/select2.min.js" type="text/javascript"></script>
    <title>My Teams</title>
    <link rel="icon" href="images/favicon.ico">

</head>
<body>

    <header class="hero">
        <div class="navbar" >
          <div class="logo2">
            <a href="Startit.jsp">StartIt</a>
          </div>
          <nav>
             <ul >
                <li><a href="Startit-applications.jsp"><img src="images/connection.png" alt="" style="width: 45px; margin-top: 1vw"></a></li>
		<% if(myStartups.isEmpty()){%>
                <li><a href="Startit-oupspage.jsp"><img src="images/team.svg" alt="" style="width: 40px; margin-top: 1vw;"></a></li>
		<%}else{%>
		<li><a href="Startit-myteams.jsp"><img src="images/team.svg" alt="" style="width: 40px; margin-top: 1vw;"></a></li>
		<%}%>
                <li><a href="#pop-notifications" class="notifications" id="notifications"><img src="images/notification 2.png" alt="" style="width: 55px; margin-top: 0.5vw;"></a></li>
                <li><a href="Startit-profile.jsp"><img src="Uploads/<%= user.getID()%>.jpg" onerror="this.onerror=null; this.src='Uploads/user.jpg'" alt="" style="border: 1px solid grey; border-radius: 50%; width: 80px; height: 80px;"></a></li>
            </ul>
         </nav>  
        </div>  
    </header>

    
    <main class="content">
        <section class="flex-item" >
            <div class="middle">                
                <%for(Startup i: myStartups) {
                %>  
                <section class="card">
		    <div class="flex">
		    	<img id="logo" src="TeamUploads/<%= i.getID()%>.jpg" onerror="this.onerror=null; this.src='TeamUploads/user.jpg'" alt="">                    
                    	<h1><b><%= i.getName() %></b></h1> 
                      	<form  method="post"
                        action="<%=request.getContextPath() %>/StartIt/Startit-team-profile.jsp">
                            <input type="hidden" name="startup" value=<%=i.getID()%>>
                        	<button type="submit">View More</button>
                        </form>
                        <% if (sdao.isStartupLeader(i.getID(), user.getID())){ %>
                            <form  method="post"
                            action="<%=request.getContextPath() %>/StartIt/Startit-canditates.jsp">
                                <input type="hidden" name="startupID" value=<%=i.getID()%>>
                                <button type="submit" >New Members</button>
                            </form>
                        <% } %>
		    </div>
                    <ul>
                        <li style="font-size:15px";><%= i.getWords() %></li>
                        <li style="font-size:15px">&#128205 <%= i.getLocation() %></li>
                        <li style="font-size:15px">&#128172<%
                        if (i.getLanguages() != null){
                        	for (String lang:i.getLanguages()) { %> 
					<%= lang%> <% }} %></li>
		    </ul>                                           
                </section>
                <%}%>
            </div>
        </section>
    </main>
    <section id="pop-notifications" class="pop-notifications">
      <h1> Notifications</h1>
      <%
      try{
        if (notifarr.size() > 0){
          for (Notification notif:notifarr){
            int type = notif.getType();
            String[] notifString = ndao.type2string(notif);
            String whereto = "Startit-team-profile.jsp?startup=" + notif.getStartupID(); %>  
            <div class="notif">
              <a href=<%=whereto%>> <img class="notificon"  src="images/notificationsv.svg" alt="">  </a>
              <div class="notifcontent">
                  <h2><%= notifString[0] %></h2>
                  <h3><%= notifString[1] %></h3>          
                <%if (type==1 || type==4){ %>
                    <form method="post"
                    action="<%=request.getContextPath() %>/StartIt/Startit-notificationController.jsp">
                      <input type="hidden" name="notification" value=<%=notif.getNotificationId()%> >
                      <input type="hidden" name="answer" value="accepted">
                      <input type="hidden" name="whatabout" value="reply">
                      <input type="hidden" name="url" value="Startit-profile.jsp">
                      <button type="submit">Accept</button>
                    </form>
                  <% } %>
                <form method="post"
                  action="<%=request.getContextPath() %>/StartIt/Startit-notificationController.jsp">
                  <input type="hidden" name="notification" value= <%=notif.getNotificationId()%> >
                  <input type="hidden" name="answer" value="declined">
                  <input type="hidden" name="whatabout" value="reply">
                  <input type="hidden" name="url" value="Startit-profile.jsp">
                  <button type="submit">Dismiss</button>
                </form>
                  
              </div>
            </div> 
        
      <%}}
      }catch (Exception e){
        e.printStackTrace();
      }
      %> 
    </section> 
    <script src="<%=request.getContextPath() %>/js/jquery-3.5.1.min.js"></script>
    <script src="<%=request.getContextPath() %>/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
      $(".notifications").on('click',function(){
          $(".pop-notifications").toggleClass("show");
      });
   </script>

    <script src="js/startit-script-teams-search.js"></script>
</body>
</html>