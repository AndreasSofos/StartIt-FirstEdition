<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="StartitClasses.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%if (session.getAttribute("userObj") == null){
		request.setAttribute("message", " Please login with valid credentials.");
%> 
<jsp:forwardpage="Startit.jsp"/>
<%
}
People user = (People)session.getAttribute("userObj");
request.setCharacterEncoding("UTF-8");
%>
<%
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


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=<header class="hero">
    <link rel="stylesheet" href="css/startit-application-startup.css">
    <link rel="stylesheet" href="css/profil.css">

    <title>Startup Application</title>
    <script src="https://kit.fontawesome.com/aec989c09b.js" crossorigin="anonymous"></script>
    <link href="https://fonts.cdnfonts.com/css/monument-extended" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500&display=swap" rel="stylesheet">

    <link rel="stylesheet" type="text/css" href="select2-4.0.12/dist/css/select2.min.css">
    <script src="js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script src="select2-4.0.12/dist/js/select2.min.js" type="text/javascript"></script>
    <title>Application</title>
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
        <div class="container" >
            <div class="progress-bar">
                <div class="step">
                    <div class="bullet">
                        <span>1</span>
                    </div>
                    <div class="check fa fa-check"></div>
                    <p>Business Details</p>
                </div>
                <div class="step">
                    <div class="bullet">
                        <span>2</span>
                    </div>
                    <div class="check fa fa-check"></div>
                    <p>General Idea</p>
                </div>
                <div class="step">
                    <div class="bullet">
                        <span>3</span>
                    </div>
                    <div class="check fa fa-check"></div>
                    <p>The Team</p>
                </div>
            </div>
            <div class="form-outer">
                <form  method="post"
                action="<%=request.getContextPath() %>/StartIt/Startit-application-startupController.jsp">
                    <div class="page slidePage" onkeypress="return runScript(event)">
                        <div class="title">Give us some details about your idea</div>
                        <div class="columns">
                            <div class="column1">
                                <div class="field">                           
                                    <input type="text" name="name" placeholder="Startup Name">
                                </div>
                                <div class="field">                          
                                    <div class="icons">   
                                        <div>  
                                            <select name="funding" id="select">     
                                                <option value="" disabled selected>Revenue Stream </option>
                                                <option value="one"id="one" >Advertisements </option>
                                                <option value="two" id="tow">Subscriptions</option>
                                                <option value="three" id="three">Direct sale</option>
                                            </select> 
                                        </div>
                                        <div><i class="fas fa-chevron-down fa-2x" href="#select"></i> </div>
                                    </div>  
                                </div>
                            </div>
                            <div class="column1">   
                                <div class="field"> 
                                    <div class="icons">   
                                        <div>  
                                            <select name="stage" id="select">     
                                                <option value="" disabled selected>Development stage </option>
                                                <option value="one"id="one" >Idea </option>
                                                <option value="two" id="tow">Prototype</option>
                                                <option value="three" id="three">Market Ready</option>
                                            </select> 
                                        </div>
                                        <div><i class="fas fa-chevron-down fa-2x" href="#select"></i> </div>
                                    </div>  
                                </div>
                                <div class="field1">                            
                                    <select class="js-example-placeholder-multiple" name="market" multiple="multiple" id="marketPlace" >
                                        <option value="biology">biology</option>                                
                                        <option value="robotics">robotics</option>
                                        <option value="finance">finance</option>                                
                                        <option value="logistics">logistics</option>                                
                                        <option value="software">software</option>                                
                                        <option value="hardware">hardware</option>                                            
                                  </select>
                                </div>
                            </div> 
                        </div>
                        <div class="field btns">
                            
                            <button type="button" class="nextBtn">Next step</button>
                        </div>
                    </div>
                    <div class="page">
                        <div class="title">A few words about the general idea of your startup</div>
                        <textarea name="words" id="" cols="100" rows="100"></textarea>
                        <div class="field btns">
                            <button type="button" class="prev-1 prev">Previous step</button>
                            <button type="button" class="next-1 next">Next step</button>                                         
                        </div>
                    </div>
                    <div class="page">
                        <div class="title">What members do you envision</div>
                        <div class="columns">
                            <div class="column1">
                                <div class="field">
                                    <input type="number" name="age" placeholder="Age">
                                </div>
                                <div class="field1">                                
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
                            <div class="column2">
                                <div class="field1">
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
                                <div class="field">
                                    <div class="icons">
                                        <div><input type="text" placeholder="Location" id="Location" name="location"></div>   
                                        <div><i class="fas fa-map-marker-alt fa-lg"></i></div>                                
                                    </div>
                                </div>
                            </div>
                                                      
                        </div>
                        <div class="field btns">
                                <button type="button" class="prev-2 prev">Previous step</button>                                
                                <button type="submit" class="Submit">Submit</button>
                        </div>  
                    </div>
                </form>
            </div>
        </div>
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
    <script src="js/startit-script-application-startup.js"></script>
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