<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="StartitClasses.*" %>
<%@ page import="java.util.ArrayList, java.util.List, java.util.Calendar, java.util.Locale, static java.util.Calendar.*, java.util.Date;" %>

<% 
String url = request.getParameter("url");
String whatabout = request.getParameter("whatabout");
try{
    if (whatabout.equals("reply")){
        boolean answer = false;
        if (request.getParameter("answer").equals("accepted")){
            answer = true;
        }
        int id = Integer.parseInt(request.getParameter("notification"));
        try{
            NotificationDao ndao = new NotificationDao();
            Notification notif = ndao.getNotificationByID(id);
            ndao.answerToNotification(answer, notif);

        }
        catch (Exception e){
            e.printStackTrace();
        }
    }else if(whatabout.equals("action")){
        int rID = 0;
        int stID = 0;
        if (request.getParameter("receiverID") == null){
            rID = 207;
        }else{
            rID = Integer.parseInt(request.getParameter("receiverID"));
        }
        int sID = Integer.parseInt(request.getParameter("senderID"));
        int type = Integer.parseInt(request.getParameter("type"));
        if (request.getParameter("startupID") == null){
            stID = 30;
        }else{
            stID = Integer.parseInt(request.getParameter("startupID"));
        }
        NotificationDao ndao = new NotificationDao();
        Notification notif = new Notification(type, rID, sID, stID);
        ndao.AddNotification(notif);
        url += "?" + "startupID=" + stID; 
    }
}finally{
response.setStatus(response.SC_MOVED_TEMPORARILY);
response.setHeader("Location", url); 
}



%>