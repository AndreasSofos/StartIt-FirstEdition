<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="StartitClasses.*" %>
<%@ page import="java.util.ArrayList;" %>

<% 
String name = request.getParameter("name");
String surname = request.getParameter("surname");
String email = request.getParameter("email");
String password = request.getParameter("password");
String check = request.getParameter("check");
ArrayList<String> messages = new ArrayList<String>();


try{
    if(name.length() >= 2 && surname.length() >= 2 && password.length() >= 5 && check.equals("on")){
        PeopleDAO regp = new PeopleDAO();
        People newp = new People(name, surname, email, password);
        regp.register(newp);
        session.setAttribute("userObj",newp);
        String site = new String("Startit-application-user.jsp?#");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site); 
    }else {
        int i=0;
        if(name.length() < 2){
            messages.add(i,"Name should be at least 2 characters long");
            i++;
        }
        if(surname.length() < 2){
            messages.add(i,"Surname should be at least 2 characters long");
            i++;
        }
        if(password.length() < 5){
            messages.add(i,"Password should be at least 5 characters long");
            i++;
        }
            if(!check.equals("on")){
                messages.add(i,"You must aggree to Terms and Conditions");
                i++;
            }
        
        request.setAttribute("message", messages);
        String site = new String("Startit.jsp?#");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site); 
    }
}catch(Exception e){
        String site = new String("Startit.jsp?#");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site); 

}finally{

    }
 %>
