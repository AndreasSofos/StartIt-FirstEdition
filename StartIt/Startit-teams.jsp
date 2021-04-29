<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="StartitClasses.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<% if (session.getAttribute("userObj") == null){
		request.setAttribute("message", " Please login with valid credentials.");
%> 
<jsp:forwardpage="Startit.jsp"/>
<%  
}
    PeopleDAO pdao = new PeopleDAO();
    StartupDAO sdao=new StartupDAO();
    ArrayList<Startup> myList = new ArrayList<Startup>();
    try {
        if (request.getAttribute("filtered")==null){
            myList = sdao.getStartups();
        } else{
            myList = (ArrayList<Startup>) request.getAttribute("filtered");
        }
       
    } catch (Exception e) {
        e.printStackTrace();
    }
    
%>
<% if (session.getAttribute("userObj") == null){
        request.setAttribute("message", " Please login with valid credentials.");
    }
%> 
<%
try{
People user = (People)session.getAttribute("userObj");
NotificationDao ndao = new NotificationDao();
ArrayList<Notification> notifarr = ndao.getNotifications(user.getID());
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
    <link rel="stylesheet" href="css/startit-teams.css">
    <link rel="stylesheet" href="css/profil.css">
    <title>Document</title>
    <script src="https://kit.fontawesome.com/aec989c09b.js" crossorigin="anonymous"></script>
    <link href="https://fonts.cdnfonts.com/css/monument-extended" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="select2-4.0.12/dist/css/select2.min.css">
    <script src="js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script src="select2-4.0.12/dist/js/select2.min.js" type="text/javascript"></script>
</head>
<body>

    <header class="hero">
        <div class="navbar" >
            <div class="logo2">
              <a href="#Startit-profil.html">StartIt</a>
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
            <div class="left">
                <div class="title"> Filter Teams</div>
                <form  method="post"
                action="<%=request.getContextPath() %>/StartIt/Startit-teamsController.jsp">
                <div class="field1">
                    <label for="">Looking for</label> <br>    
                    <div class="select">                                               
                        <select class="js-example-placeholder-multiple" name="work" multiple="multiple" id="willworkas">
                            <option value="Front-end">Front-end programming</option>                                
                            <option value="Back-end">Back-end programming</option>                                
                            <option value="Data">Data analysis</option>                                
                            <option value="web">web analytics</option>                                
                            <option value="CRM">CRM</option>                                
                            <option value="Marketing">Marketing</option>                                
                            <option value="SEO">SEO</option>                                
                            <option value="Sales">Sales</option>                                
                            <option value="Accounting">Accounting</option>                                
                            <option value="Social media managment">Social media managment</option>                                
                            <option value="human resources">Human resources</option>                                
                            <option value="art design">Art design</option>                                
                            <option value="UI/UX">UI/UX design</option>                                
                            <option value="Office">Microsoft Office</option>                                                                
                            <option value="Robotics">Robotics</option>                                
                            <option value="Biology">Biology</option>                                
                            <option value="Physics">Physics</option>                                                                                   
                        </select>
                    </div>
                </div>
                <div class="field">
                    <label for="" >Location</label> <br>
                    <input name="location" type="text" ><i class="fas fa-map-marker-alt fa-lg"></i>
                </div>
                <div class="field1">       
                    <label for="">Market</label>  <br> 
                    <div class="select">                  
                        <select class="js-example-placeholder-multiple" name="market" multiple="" id="marketPlace" >
                            <option value="biology">biology</option>                                
                            <option value="robotics">robotics</option>
                            <option value="finance">finance</option>                                
                            <option value="logistics">logistics</option>                                
                            <option value="software">software</option>                                
                            <option value="hardware">hardware</option>                                            
                         </select>
                    </div>   
                </div>
                <div class="field1">
                    <label for="">Languages</label> <br>
                    <div class="select">
                        <select class="js-example-placeholder-multiple"  multiple="multiple" id="languages" name="languages" >
                            <option value="Greek">Greek</option>                                
                            <option value="English">English</option>
                            <option value="Mandarin">Mandarin</option>                                
                            <option value="Spanish">Spanish</option>                                
                            <option value="Hindi">Hindi</option>                                
                            <option value="Arabic">Arabic</option>                                
                            <option value="Indonisian">Indonisian</option>                                
                            <option value="French">French</option>                                
                            <option value="Bengali">Bengali</option>                                
                            <option value="Russian">Russian</option>                                
                            <option value="German">German</option>                                
                            <option value="Japanese">Japanese</option>                                
                            <option value="Portuguese">Portuguese</option>                           
                        </select>
                    </div>
                </div>
                <button>Apply</button>
            </form>   
                
            </div>

            <div class="middle">
                <%ArrayList<Integer> aAoM = sdao.alreadyAppliedOrMember(user.getID());
                for (Startup i: myList) {
                    if (!aAoM.contains(i.getID())){
                %>  
                <section class="card">
		    <div class="flex">
		    	<img id="logo" src="TeamUploads/<%= i.getID()%>.jpg" onerror="this.onerror=null; this.src='TeamUploads/user.jpg'" alt="">                    
                    	<h1><b><%= i.getName() %></b></h1> 
                      	<form  method="post"
                        action="<%=request.getContextPath() %>/StartIt/Startit-notificationController.jsp">
                            <input type="hidden" name="whatabout" value="action">
                            <input type="hidden" name="senderID" value= <%=user.getID()%> >
                            <input type="hidden" name="type" value= "1">
                            <input type="hidden" name="startupID" value=<%=i.getID()%>>
                            <input type="hidden" name="receiverID" value=<%=pdao.startUpLeader(i.getID())%> >
                            <input type="hidden" name="url" value="Startit-teams.jsp">
                        	<button type="submit">Join Team</button>
                    	</form>
		    </div>
                    <ul>
                        <li style="font-size:15px";><%= i.getWords() %></li>
                        <li style="font-size:15px">&#128205 <%= i.getLocation() %></li>
                        <li style="font-size:15px">&#128172<%
                        if (i.getLanguages() != null){
                        for (String lang:i.getLanguages()) { %> <%= lang%> <% }} %></li>
		    </ul>                                           
                </section>
                <%  } 
                }%>

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

    <script src="js/startit-script-teams-search.js"></script>
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
<%}catch (Exception e){
%>     <jsp:forwardpage="Startit-canditates.jsp"/>

<%}finally{}
%>