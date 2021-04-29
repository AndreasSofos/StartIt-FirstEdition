<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="StartitClasses.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<% if (session.getAttribute("userObj") == null){
		request.setAttribute("message", " Please login with valid credentials.");
%> 
<jsp:forwardpage="Startit.jsp"/>
<%
}
People user = (People)session.getAttribute("userObj");
NotificationDao ndao = new NotificationDao();
ArrayList<Notification> notifarr = ndao.getNotifications(user.getID());

%>
<% 
StartupDAO sdao = new StartupDAO();
ArrayList<Startup> myStartups = new ArrayList<Startup>();
if( sdao.loadMyStartups(user.getID()) != null){
	myStartups = sdao.loadMyStartups(user.getID());
}else{
	myStartups = null;
}
%>

<% if (session.getAttribute("filtered") != null){
  session.removeAttribute("filtered");
}

PeopleDAO pdao = new PeopleDAO();
int personID = Integer.parseInt(request.getParameter("personID"));
People person = pdao.findById(personID);


%> 
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/startit-profile.css" />
        <title>StartIt</title>
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
                <li><a href="Startit-oupspage.jsp"><img src="images/team.png" alt="" style="width: 40px; margin-top: 1vw;"></a></li>
		<%}else{%>
		<li><a href="Startit-myteams.jsp"><img src="images/team.png" alt="" style="width: 40px; margin-top: 1vw;"></a></li>
		<%}%>
                <li><a href="#pop-notifications" class="notifications" id="notifications"><img src="images/notification 2.png" alt="" style="width: 55px; margin-top: 0.5vw;"></a></li>
                <li><a href="Startit-profile.jsp"><img src="Uploads/<%= user.getID()%>.jpg" onerror="this.onerror=null; this.src='Uploads/user.jpg'" alt="" style="border: 1px solid grey; border-radius: 50%; width: 80px; height: 80px;"></a></li>
            </ul>
         </nav>  
        </div>  
        <div class="contain1">
          <div class="banner"> 
              <div class="flexcontent">
                <div>
		<div class="profile-pic-div">
                   <img src="Uploads/<%= person.getID()%>.jpg" onerror="this.onerror=null; this.src='Uploads/user.jpg'" id="photo">
                                       
		              </div>
                </div>
                <div class="profile">
                  <h1> <%= person.getName()%> <%= person.getSurname()%></h1>
                  <ul>
                    <li>Academic Level: <%= person.getEducation()%></li>
                    <li><%= person.getLocation()%></li>
                    <li><%= person.getEmail()%></li>
                  </ul> 
                </div>
                <div class="links">	
		
    <%String Facebook = "";
    String[] socials = person.getSocials();
		if(socials[0] != null){
			Facebook = socials[0];
		}%>
                  <a href="<%=Facebook%>"> <img src="images/facebook-icon-color.png" alt=""> </a>
                  <a href=""> <img src="images/linkedin-icon-color.png" alt=""> </a>
                  <a href=""> <img src="images/instagram-icon-color.png" alt=""> </a>
                  <a href=""> <img src="images/twitter-icon-color.png" alt=""> </a>                  
                </div>
              </div>  
       
               
          </div>
          <div class="row">
            <div class="card">
              <h1>Top Skills</h1>

              
              <ul id = "card-scrollbar">
                <% try{
                    for (String skill : person.getSpecialties()){ %>
                <li><%= skill%></li>
                <% }}catch(Exception e){

                }finally{

                } %>
              </ul>

            </div>
            
            <div class="card">
              <h1>Hobbies</h1>

              <ul id = "card-scrollbar">
                <% try{
                  for (String hobby : person.getInterests()){ %>
                  <li><%= hobby%></li>
                <% }}catch(Exception e){

                }finally{

                }  %>
              </ul>


            </div>
            <div class="card">
              <h1>Speaks</h1>


                <ul id = "card-scrollbar">
                  <%  try{
                    for (String lang : person.getLanguages()){ %>
                    <li><%= lang%></li>
                    <% } }catch(Exception e){

                    }finally{
    
                    }  %>
                </ul>

            </div>

          </div>  
        </div>
    
        
  
    </header>

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
    <script src="js/startit-script-profil.js"></script>

  
    <script src="<%=request.getContextPath() %>/js/jquery-3.5.1.min.js"></script>
    <script src="<%=request.getContextPath() %>/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
      $(".notifications").on('click',function(){
          $(".pop-notifications").toggleClass("show");
      });
   </script>

</body>
</html>
