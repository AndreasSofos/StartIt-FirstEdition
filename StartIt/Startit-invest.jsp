<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<% session.invalidate();%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/investstartit.css" />
    <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700&display=swap" rel="stylesheet">  
    <script src="https://kit.fontawesome.com/aec989c09b.js" crossorigin="anonymous"></script>
    <title>Invest with StartIt</title>
    <link rel="icon" href="images/favicon.ico">

</head>
<body>
  <!-- Hero and Navbar -->
    <header class="hero">
        <div class="navbar" >
          <div class="logo">
            <img src="images/logo.png" alt="">
          </div>
          <nav>
            <ul >
              <li><a href="StartIt-AboutUs.jsp">About Us</a></li>
              <li><a href="Startit.jsp">How it Works</a></li>
              <li><a href="Startit-invest.jsp" class="active" >Invest</a></li>
              
            </ul>
          </nav>
          <a  id="sign-in" href="#pop-signin" class="signin">Login</a> 
        </div>
        <div id="changefont" class="content">
          <div >
            <div class="textpadding">
              <h1><span>Boost</span> an upcoming Startup today!</h1>
              <h2>The StartIt investment program closes</h2>
              <h2>the gap between investors and startups.</h2>
            </div>
            <form class="myform" action="">
              <h3>Your investment interests</h3>
              <div class="formrow">
                <div>
                  <div class="field">
                    <input type="text" placeholder="Name">
                  </div>
                  <div class="field">
                    <input type="text" placeholder="Market Interests">
                  </div>
                </div>
                <div>
                  <div class="field">
                    <input type="text" placeholder="Surname">
                  </div>
                  <div class="field">
                    <input type="email" placeholder="Email">
                  </div>
                </div>
                <!-- <input placeholer="Name" type="text">
                <input type="text"> -->
              </div>
              <div class="slidecontainer">
                <input type="range" min="5000" max="30000" value="5000" class="slider" id="myRange" step="10">
                <p>Amount to Invest: <span id="demo"></span></p>
              </div>
              <button class="apply-button">Apply</button>
            







            </form>
          </div>
          <lottie-player src="https://assets6.lottiefiles.com/packages/lf20_1Uj5JP.json"  background="transparent"  speed="1"  style="width: 600px; height: 600px;"  loop  autoplay></lottie-player>

          
    
    
    
    
    
    
        </div>
      
           
    </header>
   
       
   
 

    <!-- Sign in -->
    <section id="pop-signin" class="pop-signin">
      <div class="sign-top">
        <button class="close-signin" ><i class="fas fa-times fa-lg"></i></button>
        <h3>Not a member?<a href="#pop-signup" class="signup"> Sign up</a></h3>
      </div>
      <h1>Log in.</h1>
      <h2>Be a part of tommorow</h2>
      <% if(request.getAttribute("message") != null) { %>		
        <div> <p style="color:red; margin-left: 3vh; margin-bottom: -3vw;">  <%=(String)request.getAttribute("message") %></p></div> <% } %>
      <form method="post" action="<%=request.getContextPath() %>/StartIt/Startit_loginController.jsp">
        <label for="email" id="email-title">Email</label> <br>
          <input type="text" id="email-signin" name="email" > <br>
          <label for="password" id="password-title">Password</label> <br>
          <input type="password" id="password-signin" name="password"> <br>
          <button type="submit" id="login">Log in</button> <br>
          <div class="keep">
          <input type="checkbox" id="keep" name="keep">
          <label for="keep" id="keep-text">Keep me logged in</label></div>
      </form>
      
    </section>
    <!-- Sign In -->
    <!-- Sign Up -->
    <section class="pop-signup">
      <div class="sign-top">
        <button class="close-signup" ><i class="fas fa-times fa-lg"></i></button>
        <h3>Already a member?<a href="#pop-signin" class="signup"> Login</a></h3>
      </div>
      <h1>Sign up.</h1>
      <% if(request.getAttribute("message") != null) { %>		
        <div><p style="color:red; margin-left: 2vh;  margin-bottom: -3vw;">  <%=(String)request.getAttribute("message") %></p></div> <% } 
      else if(request.getAttribute("messages") != null){
        ArrayList<String> messagelist = (ArrayList<String>)request.getAttribute("messages");
       %>
      <div>
            <div>
            <%= messagelist.get(0) %>
            </div> <%
      }
      %>
      </div>
      <form method="post" action="<%=request.getContextPath() %>/StartIt/Startit_registerController.jsp">
          <div class="grid">
          <label for="name" id="name" >Name</label>
          <label for="surname" id="surname">Surname</label>
          <input type="text" name="name" id="name-signup">
          <input type="text" name="surname" id="surname-signup">
          </div>
          <label for="email" id="email">Email</label> <br>
          <input type="text" id="email-signup" name="email" > <br>
          <label for="password" id="password">Password</label> <br>
          <input type="password" id="password-signup" name="password"> <br>
          <button type="submit" id="signup">Sign up</button>
          <div class="keep">
              <input type="checkbox" id="check" name="check">
              <label for="check" id="check-text">Creating an account means you agree<br> with our Service and Privacy Terms</label>
          </div>
      </form>
      
    </section>
     <!-- Sign up -->
    <script src="https://unpkg.com/aos@next/dist/aos.js"></script>
    <script>
      AOS.init({
        duration: 1800,
           })
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
    <script>
        $(".signin").on('click',function(){
            $(".pop-signin").toggleClass("show");
        });
        $(".close-signin").on('click',function(){
            $(".pop-signin").toggleClass("show");
        });
        $(".signup").on('click',function(){
            $(".pop-signin").toggleClass("show");
            $(".pop-signup").toggleClass("show");
        });
        $(".close-signup").on('click',function(){
            $(".pop-signup").toggleClass("show");
        });
    </script>

<script src="<%=request.getContextPath() %>/js/jquery.min.js"></script>
<script	src="<%=request.getContextPath() %>/js/bootstrap.min.js"></script>
    <script>
      var slider = document.getElementById("myRange");
      var output = document.getElementById("demo");
      output.innerHTML = slider.value;

      slider.oninput = function() {
        output.innerHTML = this.value;
      }

    </script>

    <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>



</body>
</html>