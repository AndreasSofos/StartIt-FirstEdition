<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="StartitClasses.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%
    PeopleDAO pdao=new PeopleDAO();
    ArrayList<People> myList = new ArrayList<People>();
    int startupID = 0;
    try {
        if (request.getAttribute("filtered")==null){
            myList = pdao.getPeople();
        } else{
            myList = (ArrayList<People>) request.getAttribute("filtered");
        }
        if (request.getParameter("startupID")!= null){
            startupID = Integer.parseInt(request.getParameter("startupID"));
        }else {
            String site = new String("Startit-profile.jsp?#");
            response.setStatus(response.SC_MOVED_TEMPORARILY);
            response.setHeader("Location", site); 
        }
       
    } catch (Exception e) {
        e.printStackTrace();
    }
    
%>
<% if (session.getAttribute("userObj") == null){
    request.setAttribute("message", " Please login with valid credentials.");
%> 
<jsp:forwardpage="Startit.jsp"/>
<%
}try{
People user = (People)session.getAttribute("userObj");
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
    <link rel="stylesheet" href="css/startit-canditates.css">
    <link rel="stylesheet" href="css/profil.css" />
    <title>Available Candidates</title>
    <link rel="icon" href="images/favicon.ico">
    <script src="https://kit.fontawesome.com/aec989c09b.js" crossorigin="anonymous"></script>
    <link href="https://fonts.cdnfonts.com/css/monument-extended" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/multirange.css">
    <link rel="stylesheet" type="text/css" href="select2-4.0.12/dist/css/select2.min.css">
    <script src="js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script src="select2-4.0.12/dist/js/select2.min.js" type="text/javascript"></script>
    <script src="js/multirange.js"></script>
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
    </header>
    
    <main class="content">

        <section class="flex-item" >
            <!-- αριστερό μέρος φιλτρα -->
            
            <div class="left">
                <div class="title"> Filter <br> Canditates</div>
                <form  method="post"
                action="<%=request.getContextPath() %>/StartIt/Startit-canditatesController.jsp">
                    <div class="field">
                        <label id = "age" for="">Age</label> <br>
                        <div class="range">
                            <div class="sliderValue">
                            <span>0,100</span>
                            </div>
                            <div class="r_field">
                                    <!-- <div class="value left">0</div> -->
                            <input name="age" type="range" multiple min="0" max="100" value="0,100" steps="1">
                                    <!-- <div class="value right">100</div> -->
                            </div>
                        </div>                
                    </div>
                    <div class="field">
                        <label for="" >Location</label> <br>
                        <input type="text" id="location" name="location" ><i class="fas fa-map-marker-alt fa-lg"></i>
                    </div>
                    <div class="field1">       
                        <label for="">Skills</label>  <br>       
                        <div class="select">               
                            <select class="js-example-placeholder-multiple"  multiple="multiple" id="skills" name="skills">
                                <option value="Front-end programming">Front-end programming</option>                                
                                <option value="Back-end programming">Back-end programming</option>                                
                                <option value="Data analysis">Data analysis</option>                                
                                <option value="web analytics">web analytics</option>                                
                                <option value="CRM">CRM</option>                                
                                <option value="Marketing">Marketing</option>                                
                                <option value="SEO">SEO</option>                                
                                <option value="Sales">Sales</option>                                
                                <option value="Accounting">Accounting</option>                                
                                <option value="Social media managment">Social media managment</option>                                
                                <option value="Human resources">Human resources</option>                                
                                <option value="Art design">Art design</option>                                
                                <option value="UI/UX">UI/UX design</option>                                
                                <option value="Microsoft Office">Microsoft Office</option>                                                                
                                <option value="Robotics">Robotics</option>                                
                                <option value="Biology">Biology</option>                                
                                <option value="Physics">Physics</option>                                                                                   
                            </select>
                        </div>
                    </div>
                    <div class="field1">
                        <label for="">Languages</label> <br>
                        <div class="select">
                            <select class="js-example-placeholder-multiple"  multiple="multiple" id="languages" name="languages" >
                                <option value="gr">Greek</option>                                
                                <option value="en">English</option>
                                <option value="ma">Mandarin</option>                                
                                <option value="sp">Spanish</option>                                
                                <option value="h">Hindi</option>                                
                                <option value="ar">Arabic</option>                                
                                <option value="in">Indonisian</option>                                
                                <option value="fr">French</option>                                
                                <option value="be">Bengali</option>                                
                                <option value="ru">Russian</option>                                
                                <option value="ge">German</option>                                
                                <option value="ja">Japanese</option>                                
                                <option value="po">Portuguese</option>                           
                            </select>
                        </div>
                    </div>
                    <input type="hidden" name="startupID" value= <%=startupID%> >
                    <button>Submit</button>    </form>        </div>
            
            <!-- δεξί μέρος καρτέλες υποψηφίων καθε section μία καρτέλα -->
            <div class="right">
                <% ArrayList<Integer> aIoM = pdao.alreadyInvitedOrMember(startupID);
                for (People i: myList) {
                        if (i.getID() != user.getID()){
                            if (!(aIoM.contains(i.getID()))){
                %>

                                <section class="card">
                                    <img src="Uploads/<%= i.getID()%>.jpg" onerror="this.onerror=null; this.src='Uploads/user.jpg'" alt="">
                                    <h1><%= i.getName() +" "+i.getSurname()+","+ i.getAge() %></h1>
                                    <ul>
                                        <li><b>Based in:</b> <%= i.getLocation() %></li>
                                        
                                        <li><b>Languages:</b><%
                                        if (i.getLanguages() != null){
                                        for (String lang:i.getLanguages()) { %> <%= lang%>  <% }} %></li>

                                        <li><b>Skills:</b><%
                                        if (i.getSpecialties() != null){
                                        for (String spec:i.getSpecialties()){ %> <%=spec%> <% } } %></li>
                                        
                                        
                                    </ul>
					<form method="post"
                                            action="<%=request.getContextPath() %>/StartIt/Startit-notificationController.jsp">
                                            <input type="hidden" name="whatabout" value="action">
                                            <input type="hidden" name="senderID" value= <%=user.getID()%> >
                                            <input type="hidden" name="startupID" value= <%=startupID%> >
                                            <input type="hidden" name="receiverID" value= <%= i.getID()%> >
                                            <input type="hidden" name="type" value= "4">
                                            <input type="hidden" name="url" value="Startit-canditates.jsp">
                                            <button type="submit"> Invite</button>

                                        </form>
                                </section>
                <% }
             } 
             
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
    <script src="js/startit-script-candidates-search.js"></script>
    <script src="<%=request.getContextPath() %>/js/jquery-3.5.1.min.js"></script>
    <script src="<%=request.getContextPath() %>/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
      $(".notifications").on('click',function(){
          $(".pop-notifications").toggleClass("show");
      });
   </script>
    
    <script>
      const slideValue = document.querySelector("span");
      const inputSlider = document.querySelector("input");
      inputSlider.oninput = (()=>{
        let value = inputSlider.value;
        slideValue.textContent = value;
        slideValue.style.left = (value/2) + "%";
        slideValue.classList.add("show");
      });
    //   inputSlider.onblur = (()=>{
    //     slideValue.classList.remove("show");
    //   });
   </script>
</body>

</html>
<%}catch (Exception e){

}finally{}
%>