<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<% session.invalidate();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/startit.css" />
    <title>Welcome to StartIt</title>
    <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
    <link rel="icon" href="images/favicon.ico">
    
    <script src="https://kit.fontawesome.com/aec989c09b.js" crossorigin="anonymous"></script>

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
              <li><a  href="Startit.jsp" class="active">How it Works</a></li>
              <li><a href="Startit-invest.jsp">Invest</a></li>
            </ul>
          </nav>
          <a  id="sign-in" href="#pop-signin" class="signin">Login</a> 
        </div>
        <div class="content">
            <div>
                <h1>We Connect <span> Radical</span> People <br> &emsp; With <span> Radical</span> Ideas </h1>
                <p>&emsp;StartIt is a community driven app that allows <br>&emsp;
                  like minded people to connect and form teams <br>&emsp;
                  that will give life in ideas that will change tomorrow.
                  </p>
            </div>  
            <div class="arrow">
              <p id="target"><b>Find <br> How</b></p>
              <a href="#section1" ><img src="images/arrow.png" ></a>
            </div>     
        </div>     
    </header>
    <!-- Section 1 -->
    <div  id="section1" class="hero" >
      <div  class="content" data-aos="fade-right">
        <h1 class="number">01</h1>
        <div id="words">
            <h1><span> Tell us Who you Are</span>  </h1>
            <p>Create your profile , update it  with your hard and soft skills ,  languages you can speak 
              and most importantly your business  interests.
              </p>
        </div>  
        <div class="arrow">
          <p id="target"><b>Find <br> More</b></p>
          <a href="#section2" ><img src="images/arrow.png" ></a>
        </div>     
      </div>     
    </div>
    <!-- Section 2 -->
    <div  id="section2" class="hero" >
      <div  class="content" data-aos="fade-right">
        <h1 class="number">02</h1>
        <div id="words">
            <h1><span> Present your Idea</span>  </h1>
            <p>That idea you were thinking about last night in your bed? 
              We and most importantly the world wanna know about it , post it and find pe
              ople who wanna make it a reality with you.
              </p>
        </div>  
        <div class="arrow">
          <p id="target"><b>Find <br> More</b></p>
          <a href="#section3" ><img src="images/arrow.png" ></a>
        </div>     
      </div>     
    </div>
    <!-- Section -->
    <div  id="section3" class="hero" >
      <div  class="content" data-aos="fade-right">
        <h1 class="number">03</h1>
        <div id="words">
            <h1><span> Choose Who you Work With</span>  </h1>
            <p>This is not that miserable school project  get applications from those interested  and accept only those who fit your vision.
              </p>
        </div>  
        <div id="yo" class="arrow ">
          <a  id="circle-text"><img src="images/circle-text.png" ></a>
        </div>     
      </div>     
    </div> 
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


</body>
</html>
