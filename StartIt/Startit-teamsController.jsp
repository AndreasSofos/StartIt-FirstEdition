<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="StartitClasses.*" %>
<%@ page import="java.util.ArrayList, java.util.List, java.util.Calendar, java.util.Locale, static java.util.Calendar.*, java.util.Date;" %>

<% 
String[] jobs = request.getParameterValues("work");
String location = request.getParameter("location");
String[] markets = request.getParameterValues("market");
String[] languages = request.getParameterValues("languages");

try{
    StartupDAO sdao = new StartupDAO();
    ArrayList<Startup> s = sdao.getStartups();
    ArrayList<Startup> filtered = sdao.finalSearch(jobs,location,markets,languages);
    ArrayList<Startup> weighted = sdao.weightedSearchResults(filtered);
        request.setAttribute("filtered", weighted);
    %>
    <jsp:forwardpage="Startit-teams.jsp"/>
    <%
}catch(Exception e){
    String site = new String("Startit-canditates.jsp?#");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site); 
}finally{

}

%>
