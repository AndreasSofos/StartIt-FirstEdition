<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="StartitClasses.*" %>
<%request.setCharacterEncoding("UTF-8");

People curruser = (People)session.getAttribute("userObj");
String name = curruser.getName();
String surname = curruser.getSurname();
String email = curruser.getEmail();
String password = curruser.getPassword();
int age;
String startupName = request.getParameter("name");
String stage = request.getParameter("stage");

String[] languages = request.getParameterValues("languages");
String[] jobs = request.getParameterValues("work");
String[] revenue = request.getParameterValues("funding");
String[] market = request.getParameterValues("market");
String words= request.getParameter("words");
String location = request.getParameter("location"); 


try{
    age = Integer.parseInt(request.getParameter("age"));
    StartupDAO x = new StartupDAO();
    Startup s = new Startup(startupName,stage,age,jobs,revenue,market,words,languages,location);
    x.updateDB(curruser,s);
        
    String site = new String("Startit-profile.jsp?#");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site);
}catch(Exception e){
    request.setAttribute("message", "All fields must be filled in order to create a new startup"); %>
    <jsp:forwardpage="Startit-application-startup.jsp"/>
<%
}finally{ 
    

}
%>
