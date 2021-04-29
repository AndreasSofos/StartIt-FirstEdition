<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="StartitClasses.*" %>

<% String email = request.getParameter("email");
String password = request.getParameter("password"); 

PeopleDAO pdao = new PeopleDAO();
try{
    People authp = pdao.authenticate(email, password);
    if (authp!=null){
        session.setAttribute("userObj", authp);
    }
    String site = new String("Startit-profile.jsp?#");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site); 
    
}catch (Exception e){
    String site = new String("Startit-profile.jsp?#");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site); 
}finally{

}
%>
    


