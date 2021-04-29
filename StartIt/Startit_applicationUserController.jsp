<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="StartitClasses.*" %>
<%@ page import="java.util.ArrayList, java.util.List, java.util.Calendar, java.util.Locale, static java.util.Calendar.*, java.util.Date;" %>

<%request.setCharacterEncoding("UTF-8");

People curruser = (People)session.getAttribute("userObj");
String name = curruser.getName();
String surname = curruser.getSurname();
String email = curruser.getEmail();
String password = curruser.getPassword();
String location = request.getParameter("location"); 
int age = Integer.parseInt(request.getParameter("age"));
String gender = request.getParameter("gender");
String occupation = request.getParameter("occupation");
String[] languages = request.getParameterValues("languages");
String[] interests = request.getParameterValues("hobbies");
String[] specialties = request.getParameterValues("skills");
String education = request.getParameter("education");
String facebook = request.getParameter("facebook");
String linkedin = request.getParameter("linkedin");
String twitter = request.getParameter("twitter");
String ig = request.getParameter("instagram");
String[] socials = {facebook, ig, linkedin, twitter};


try{
    PeopleDAO useregDAO = new PeopleDAO();
    People usereg = new People(name, surname, email, password, age, location, gender, occupation, education, interests, specialties, socials, languages);
    useregDAO.fullRegister(usereg);
    session.setAttribute("userObj", usereg);
    String site = new String("Startit-profile.jsp?#");
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site);  
}catch(Exception e){
}finally{ 


}
%>


 <%--  session.setAttribute("id",currentUserId);
    currentUser.setLocation(location);
    currentUser.setBirthday(birthday);
    currentUser.setLanguages(languages);
    currentUser.setGender(gender);
    currentUser.setHobby(hobby);
    currentUser.setSkills(skills);
    currentUser.setEducation(education);
    currentUser.setOccupation(occupation);
    currentUser.setFacebook(facebook);
    currentUser.setInstagram(instagram);
    currentUser.setTwitter(twitter);
    currentUser.setLinkedin(linkedin);
    PeopleDAO.fullRegister(currentUser);
    session.setAttribute("userObj",currentUser);

    String[] arrOfStr = birthday.split("/");
String birthYear= arrOfStr[arrOfStr.length-1];
int birthYearino=Integer.parseInt(birthYear);
int currentYear = Calendar.getInstance().get(Calendar.YEAR);
int age=currentYear-birthYearino; 

 Date birthday = (Date)request.getParameter("birthday");

public static int getDiffYears(Date first, Date last) {
    Calendar a = getCalendar(first);
    Calendar b = getCalendar(last);
    int diff = b.get(YEAR) - a.get(YEAR);
    if (a.get(MONTH) > b.get(MONTH) || 
        (a.get(MONTH) == b.get(MONTH) && a.get(DATE) > b.get(DATE))) {
        diff--;
    }
    return diff;
}

public static Calendar getCalendar(Date date) {
    Calendar cal = Calendar.getInstance(Locale.US);
    cal.setTime(date);
    return cal;
}

int age = getDiffYears(birthday, java.time.LocalDate.now()) 


String[] languages = request.getParameterValues("languages");
String gender = request.getParameter("gender");
String[] interests = request.getParameterValues("hobbies");
String[] specialties = request.getParameterValues("skills");
String education = request.getParameter("education");
String occupation = request.getParameter("occupation");
String facebook = request.getParameter("facebook");
String linkedin = request.getParameter("linkedin");
String twitter = request.getParameter("twitter");
String ig = request.getParameter("instagram");
String[] socials = {facebook, ig, linkedin, twitter}; 
--%>