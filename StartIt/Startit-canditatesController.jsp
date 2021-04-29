<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="StartitClasses.*" %>
<%@ page import="java.util.ArrayList, java.util.List, java.util.Calendar, java.util.Locale, static java.util.Calendar.*, java.util.Date;" %>

<% 
String[] ages = request.getParameterValues("age");
int agemin = Integer.parseInt(ages[0]);
int agemax = Integer.parseInt(ages[ages.length-1]);
String location = request.getParameter("location");
String[] specialties = request.getParameterValues("skills");
String[] languages = request.getParameterValues("languages");
int startupID = 0;
if (request.getParameter("startupID")!=null){
    startupID = Integer.parseInt(request.getParameter("startupID"));
}

try{
    PeopleDAO pdao = new PeopleDAO();
    ArrayList<People> all = pdao.getPeople();
    ArrayList<People> filtered = pdao.filteredSearch(agemin, agemax, location, specialties, languages, all);
    ArrayList<People> weighted = pdao.weightedSearchResults(filtered);
    request.setAttribute("filtered", weighted);
    %>
    <jsp:forwardpage="Startit-canditates.jsp">
        <jsp:param name="startupID" value= "<%=startupID%>" />
    </jsp:forward>
    <%
}catch(Exception e){
    String site = new String("Startit-profile.jsp?#");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site); 
}finally{

}

%>

<%-- int agemin = Integer.parseInt(ages[0]);
int agemax = Integer.parseInt(ages[ages.length-1]);
ArrayList<People> weighted = pdao.weightedSearchResults(filtered); --%>
