<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="StartitClasses.*, java.util.List"%>
<% if (session.getAttribute("userObj") == null){
		request.setAttribute("message", " Please login with valid credentials.");
%> 
<jsp:forwardpage="Startit.jsp"/>
<%
}
People user = (People)session.getAttribute("userObj");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/startit-profil.css" />
        <title>Your Profile</title>
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
                <li><a href="Startit-application-startup.jsp"><img src="images/connection.png" alt="" style="width: 45px; margin-top: 1vw"></a></li>
                <li id="chat"><a href="#about"><img src="images/chat.png" alt="" style="width: 40px; margin-top: 0.5vw;"></a></li>
                <li><a href="#home"><img src="images/notification 2.png" alt="" style="width: 55px; margin-top: 0.5vw;"></a></li>
                <li><a href="Startit-profile.jsp"><img src="Uploads/<%= user.getID()%>.jpg" onerror="this.onerror=null; this.src='Uploads/user.jpg'" alt="" style="border: 1px solid grey; border-radius: 50%; width: 80px; height: 80px;"></a></li>
            </ul>
         </nav>  
        </div>  
        <div class="contain1">
          <div class="banner"> 
              <div class="flexcontent">
                <div>
                  <img  id="pen" src="images/pen.png" alt="">
 		              <div class="profile-pic-div">
                    <form action = "UploadFile.jsp" method = "post"
                      enctype = "multipart/form-data">
                      <img src="Uploads/<%= user.getID()%>.jpg" onerror="this.onerror=null; this.src='Uploads/user.jpg'" id="photo">
                      <input type = "file" id="file" name = "file" size = "50" />
                      <label for="file" id="uploadBtn" >Choose Photo</label>
                      <input type = "submit" id="submit"  value = "Upload File" />                      
                    </form>                  
		              </div>
                </div>
                <div class="profile">
                  <h1> <%= user.getName()%> <%= user.getSurname()%></h1>
                  <ul>
                    <li>Academic Level: <%= user.getEducation()%></li>
                    <li><%= user.getLocation()%></li>
                    <li><%= user.getEmail()%></li>
                  </ul> 
                  <a id="textbutton" href="">Message Me</a>
                </div>
                <div class="checkbutton" >
                  <a  id="textbutton" href="">Matchmaking <img id="check" src="images/check.png" alt=""></a>
                </div>
              </div>  
       
               
          </div>
          <div class="row">
            <div class="card">
              <h1>Top Skills</h1>
              <img src="images/plus.png" alt="">
              
              <ul>
                <% try{
                    for (String skill : user.getSpecialties()){ %>
                <li><%= skill%></li>
                <% }}catch(Exception e){

                }finally{

                } %>
              </ul>

            </div>
            
            <div class="card">
              <h1>Hobbies</h1>
              <img id="card2"src="images/plus.png" alt="">

              <ul>
                <% try{
                  for (String hobby : user.getInterests()){ %>
                  <li><%= hobby%></li>
                <% }}catch(Exception e){

                }finally{

                }  %>
              </ul>


            </div>
            <div class="card">
              <h1>Speaks</h1>
              <img id="card3" src="images/plus.png" alt="">

                <ul>
                  <%  try{
                    for (String lang : user.getLanguages()){ %>
                    <li><%= lang%></li>
                    <% } }catch(Exception e){

                    }finally{
    
                    }  %>
                </ul>

            </div>

          </div>  
        </div>
  
        
  
    </header>
    <script src="js/startit-script-profil.js"></script>

  
    <script src="<%=request.getContextPath() %>/js/jquery.min.js"></script>
    <script src="<%=request.getContextPath() %>/js/bootstrap.min.js"></script>
    

</body>
</html>
