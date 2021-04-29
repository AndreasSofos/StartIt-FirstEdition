<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="StartitClasses.*, java.util.List"%>
<% if (session.getAttribute("userObj") == null){
		request.setAttribute("message", " Please login with valid credentials.");
%> 
<jsp:forwardpage="Startit.jsp?#"/>
<%request.setCharacterEncoding("UTF-8");

}
try{
People user = (People)session.getAttribute("userObj");

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=<header class="hero">
        <link rel="stylesheet" href="css/startit-application-user.css">
    <title>Document</title>
    <script src="https://kit.fontawesome.com/aec989c09b.js" crossorigin="anonymous"></script>
    <link href="https://fonts.cdnfonts.com/css/monument-extended" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Space+Mono:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500&display=swap" rel="stylesheet">
    <title>StartIt</title>
    <link rel="icon" href="images/favicon.ico">

    


    <link rel="stylesheet" type="text/css" href="select2-4.0.12/dist/css/select2.min.css">
    <script src="js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script src="select2-4.0.12/dist/js/select2.min.js" type="text/javascript"></script>

    <Style>
        .blackText{
        color: black;}
    </Style>
    
</head>
<body>
    <header class="hero">
        <div class="navbar" >
            <div class="logo2">
              <a href="Startit.jsp">StartIt</a>
            </div>
            <nav>
             
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
                    <p>Your Details</p>
                </div>
                <div class="step">
                    <div class="bullet">
                        <span>2</span>
                    </div>
                    <div class="check fa fa-check"></div>
                    <p>What makes you special</p>
                </div>
                <div class="step">
                    <div class="bullet">
                        <span>3</span>
                    </div>
                    <div class="check fa fa-check"></div>
                    <p>Enrich your profile</p>
                </div>
            </div>
           
            <div class="form-outer">
		<form method="post" action="<%=request.getContextPath() %>/StartIt/Startit_applicationUserController.jsp">
                    <div class="page slidePage" onkeypress="return runScript(event)">
                        <div class="title">Tell us more about yourshelf</div>
                        <div class="columns">
                            <div class="column1">
                                <div class="field">                                     
                                    <div class="icons">
                                        <div><input type="text" placeholder="Location" id="Location" name="location"></div>
                                        <div><i class="fas fa-map-marker-alt fa-lg"></i></div>
                                    </div>                                                
                                </div>                        
                                <div class="field1">
                                   <!-- <input type="text" placeholder="Languages"> -->
                                   <select class="js-example-placeholder-multiple"  multiple="multiple" id="languages" name="languages">
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
                            
                            <div class="column2">
                                <div class="field">                            
                                    <input type="number" name="age" placeholder="Age">
                                </div>
                                
                                <div class="field">
                                    <div class="icons">
                                        <div>
                                            <select  id="select-gender" name="gender">     
                                                <option value="null" disabled selected id="gender">Gender </option>
                                                <option value="Male" id="choice"  class="blackText">Male</option>
                                                <option value="Female" id="choice" class="blackText">Female</option>
                                                <option value="Other" id="choice" class="blackText">Other</option>
                                            </select> 
                                            
                                        </div>
                                        <div><i class="fas fa-chevron-down fa-2x" href="#select"></i> </div>
                                    </div>
                                    
                                    
                                </div>
                            </div>
                        </div>
                        <div class="field btns">
                                <button type="button" class="maybelater">Maybe later</button>
                                <button type="button" class="nextBtn" onclick="return runScript1(event)">Next step</button>
                        </div>
                    </div>
                    <div class="page " onkeypress="return runScript(event)">
                        <div class="title">Give us some details</div>
                        <div class="columns">
                            <div class="column1">
                                <div class="field"> 
                                    <div class="icons">
                                        <div>
                                            <select id="select-education" name="education">     
                                                <option value="null" disabled selected>Education </option>
                                                <option  value="Junior-High" class="blackText">Junior-High</option>
                                                <option value="High School" class="blackText">High School</option>
                                                <option value="Bachelor" class="blackText">Bachelor</option>
                                                <option value="Post-Graduate" class="blackText">Post-Graduate</option>
                                            </select> 
                                        </div>
                                        <div> <i class="fas fa-chevron-down fa-2x" href="#select"></i></div>
                                    </div>  
                                </div>
                                <div class="field1">                           
                                    <!-- <input type="text" placeholder="Hobby"> -->
                                    <select class="js-example-placeholder-multiple"  multiple="multiple" id="hobbies" name="hobbies">
                                        <option value="hiking">hiking</option>                                
                                        <option value="camping">camping</option>                                
                                        <option value="jogging">jogging</option>                                
                                        <option value="music">music</option>                                
                                        <option value="collecting">collecting</option>                                                    
                                        <option value="movies">movies</option>                                
                                        <option value="cooking">cooking</option>                                
                                        <option value="photography">photography</option>                                
                                        <option value="sudoku">sudoku</option>                                
                                        <option value="reading">reading</option>                                
                                        <option value="travelling">travelling</option>                                
                                        <option value="driving">driving</option>                                                                                                     
                                  </select>
                                </div>                                
                            </div>
                            <div class="column1">   
                                 <div class="field"> 
                                    <div class="icons">
                                        <div>
                                             <select  id="select-occupation" name="occupation">     
                                                <option value="null" disabled selected>Occupation</option>
                                                <option  value="Unemployed" class="blackText">Unemployed</option>
                                                <option value="Student" class="blackText">Student</option>
                                                <option value="Full Time Job" class="blackText">Full Time Job</option>
                                                <option value="Part Time Job" class="blackText">Part Time Job</option>
                                            </select> 
                                        </div>
                                        <div><i class="fas fa-chevron-down fa-2x" href="#select"></i></div>
                                    </div>
                                </div>
                                <div class="field1">       
                                     <!-- <input type="text" placeholder="Skills"> -->
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
                        </div>
                        <div class="field btns">
                            <button type="button" class="prev-1 prev" onclick="return runScript1(event)">Previous step</button>
                            <button type="button" class="next-1 next" onclick="return runScript1(event)">Next step</button>
                        </div>
                    </div>
                    
                    <div class="page">
                        <div class="title">Connect your Social Medias</div>
                        <div class="columns">
                            <div class="column1">
                                <div class="field">   
                                    <div class="icons">
                                        <div><input type="text" placeholder="Facebook Link" name="facebook"></div>
                                        <div><i class="fa fa-facebook-official fa-2x"></i></div>
                                    </div>                             
                                </div>
                                <div class="field">
                                    <div class="icons">
                                        <div><input type="text" placeholder="Linkedin Link"  name="linkedin"></div>
                                        <div><i class="fa fa-linkedin-square fa-2x"></i></div>
                                    </div>
                                    
                                </div>
                            </div>
                            <div class="column2">
                                <div class="field">
                                    <div class="icons">
                                        <div><input  type="text" placeholder="Instagram Link"  name="instagram"></div>
                                        <div><i id="icon" class="fa fa-instagram fa-2x"></i></div>
                                    </div>
                                   
                                </div>
                                <div class="field">
                                    <div class="icons">
                                        <div><input type="text" placeholder="Twitter Link"  name="twitter"></div>
                                        <div><i class="	fa fa-twitter fa-2x"></i></div>
                                    </div>
                                    
                                </div>
                            </div>
                                                      
                        </div>
                        <div class="field btns">
                                <button type="button" class="prev-2 prev" onclick="return runScript1(event)">Previous step</button>
                                <button type="submit" class="Submit">Submit</button>
                        </div>  
                    </div>
                </form>
            </div>
        </div>
    </main>
    <script src="js/startit-script-application-user.js"></script>
</body>
</html>
<%}catch (Exception e){

}finally{}
%>