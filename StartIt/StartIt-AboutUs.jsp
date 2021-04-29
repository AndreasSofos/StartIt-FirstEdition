<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/startitaboutus.css" />
    <title>Welcome to StartIt</title>
    <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700&display=swap" rel="stylesheet">  
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
              <li><a href="#about" class="active">About Us</a></li>
              <li><a href="Startit.jsp">How it Works</a></li>
              <li><a href="Startit-invest.jsp">Invest</a></li>
              
            </ul>
          </nav>
          <a  id="sign-in" href="Startit.jsp" class="signin">Login</a> 
        </div>
        <div id="section0"data-aos="fade-right" class="content">
          <div >
            <div class="textnames">
              <h1 id="name">ILIADIS </h1> 
              <h1 id="name">VICTORAS </h1> 
              <h2 id="job">design and</h2>
              <h2 id="job">frontend</h2>
            </div>  
            <a href="#section1">  <img id="arrows" src="images/arrowdown.png" alt=""></a>
          
            
           

              
          </div>  
          <div >
            <img id="profileimg"src="images/iliadis.png" alt="">
          </div>     
     
           
    </header>
        <!-- Section 1 -->
        <div  class="hero" >
          <div id="section1"  data-aos="fade-right" class="content">
            <div >
              <div class="textnames">
                <h1 id="name">ANDREAS </h1> 
                <h1 id="name">SOFOS </h1> 
                <h2 id="job">front-end </h2>
                <h2 id="job"> developer</h2>
              </div>  
              <a href="#section2">  <img id="arrows" src="images/arrowdown.png" alt=""></a>
              <a href="#section0">  <img id="arrows" src="images/arrowup.png" alt=""></a>
              
             
  
                
            </div>  
            <div >
              <img id="profileimg"src="images/sofos.png" alt="">
            </div>     
          
           
        </div>
        <div   class="hero" >
          <div id="section2" data-aos="fade-right" class="content">
            <div >
              <div class="textnames">
                <h1 id="name">GIANNIS </h1> 
                <h1 id="name">VAGIONAKIS </h1> 
                <h2 id="job">back-end</h2>
                <h2 id="job">developer</h2>
              </div>  
              <a href="#section3">  <img id="arrows" src="images/arrowdown.png" alt=""></a>
              <a href="#section1">  <img id="arrows" src="images/arrowup.png" alt=""></a>
              
             
            </div>  
            <div >
              <img id="profileimg"src="images/vagionakis.png" alt="">
            </div>     
          
           
        </div>
        <div   class="hero" >
          <div id="section3" data-aos="fade-right" class="content">
            <div >
              <div class="textnames">
                <h1  id="namegeorge">NIKOS </h1> 
                <h1 id="namegeorge">GEORGAKOPOYLOS </h1> 
                <h2 id="job">back-end</h2>
                <h2 id="job">developer</h2>
              </div>  
              <a href="#section2">  <img id="arrows" src="images/arrowup.png" alt=""></a>
              
             
            </div>  
            <div >
              <img id="profileimg"src="images/georgakopoulos.png" alt="">
            </div>     
          
           
        </div>
    
   
 

   
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


</body>
</html>
