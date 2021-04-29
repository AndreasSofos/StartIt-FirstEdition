package StartitClasses;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class NotificationDao {

    public static void DeleteNotification(int NotId) throws Exception {
        Database dataObj = new Database();
        Connection con = dataObj.getConnection();
        try {
            PreparedStatement st = con.prepareStatement("DELETE FROM Notifications WHERE Notificationid = ?");
            st.setInt(1, NotId);
            st.executeUpdate();
        } catch (Exception e) {
            throw new Exception("Something went wrong " + e.getMessage());
        } finally {
            con.close();
        }
    }

	public Notification getNotificationByID(int notID) throws Exception {
        Database dataObj = new Database();
        Connection con = dataObj.getConnection();
        Notification newnot = new Notification(0,0,0,0);
        try {
            String query = "SELECT * FROM Notifications where Notificationid=?";
			PreparedStatement statement = con.prepareStatement(query);
            statement.setInt(1, notID);
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
			   int notificationid=rs.getInt(1);
			   int nottype=rs.getInt(2);
			   int Recepientid=rs.getInt(3);
			   int senderID=rs.getInt(5);
			   int startupID=rs.getInt(4);
			   newnot.setRecipientId(Recepientid);
			   newnot.setSenderID(senderID);
			   newnot.setStartupID(startupID);
			   newnot.setType(nottype);
			   newnot.setNotificationId(notificationid);
            }
			return newnot;

        } catch (Exception e) {
			throw new Exception("Something went wrong " + e.getMessage());
		} finally {
			con.close();
		}
    }

    public ArrayList<Notification> getNotifications(int UserId) throws Exception {
        Database dataObj = new Database();
        Connection con = dataObj.getConnection();
        
        try {
            ArrayList<Notification> notifications = new ArrayList<Notification>();
            String query = "SELECT * FROM Notifications where RecepientId=?";
			PreparedStatement statement = con.prepareStatement(query);
            statement.setInt(1, UserId);
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
			   int notificationid=rs.getInt(1);
			   int nottype=rs.getInt(2);
			   int Recepientid=rs.getInt(3);
			   int senderID=rs.getInt(5);
			   int startupID=rs.getInt(4);
			   Notification newnot=new Notification(nottype, Recepientid, senderID, startupID);
			   newnot.setNotificationId(notificationid);
			   notifications.add(newnot);
            }
            return notifications;
        } catch (Exception e) {
			throw new Exception("Something went wrong " + e.getMessage());
		} finally {
			con.close();
		}
    }

    public static void AddNotification(Notification notif) throws Exception {
		int Type = notif.getType();
		int RecepientId = notif.getRecipientId();
		int senderID = notif.getSenderID();
		int startupID = notif.getStartupID();
        Database dataObj = new Database();
        Connection con = dataObj.getConnection();

        try {
            String query = " insert into Notifications (NotType, RecepientId, startupID, senderID)"
                    + " values (?, ?, ?, ?)";

            PreparedStatement st = con.prepareStatement(query);
            st.setInt(1, Type);
            st.setInt(2, RecepientId);
			st.setInt(3, startupID);
			st.setInt(4, senderID);

            st.executeUpdate();
        } catch (Exception e) {
            throw new Exception("Something went wrong " + e.getMessage());
        } finally {
            con.close();
        }

    }
    public String[] type2string(Notification notification) throws Exception {
		int type=notification.getType();
		String s1;
		String s2;
		String[] fin = new String[2];
		String message = null;
		PeopleDAO d = new PeopleDAO();
		People recepient = new People();
		int recId=notification.getRecipientId();
		recepient = d.findById(recId);
		int senderId=notification.getSenderID();
		People sender = d.findById(senderId);
		Startup s = new Startup();
		StartupDAO ds = new StartupDAO();
		int startID= notification.getStartupID();
		s=ds.findById(startID);
		
		if(type==1) {//type 1 =  candidate for startup
			s1="Candidate for " + s.getName()  ;
			s2= sender.getName() + " " + sender.getSurname() + " Wants to join your team";
			fin[0]=s1;
			fin[1]=s2;
			
		}else if(type==2) {	//type 2 = congrats accepted
			s1="Congratulations  ";	
			s2="You have been accepted in "+s.getName();
			fin[0]=s1;
			fin[1]=s2;			
		}else if(type==3) {	//type 3 = try again you have rejected

			s1="Try again";
			s2="You have been rejected by "+s.getName();
			fin[0]=s1;
			fin[1]=s2;
		}else if(type==4) {//type 4 = new invite	

			s1="New Invite ";
			s2=sender.getName() + " " + sender.getSurname() + " wants you in their Team " + s.getName() ; 
			fin[0]=s1;
			fin[1]=s2;
		}else if(type==5) {//	5 new member

			s1="A New Member ";
			s2= sender.getName() + " " + sender.getSurname() +" has accepted your offer to join your team " + s.getName();
			fin[0]=s1;
			fin[1]=s2;
		}else {
			s1="Offer Declined ";
			s2=sender.getName() + " " + sender.getSurname() + " has declined your offer to join your team " + s.getName();
			fin[0]=s1;
			fin[1]=s2;
		}
		return fin;
	}
	public static void answerToNotification(boolean isAccepted, Notification notif)throws Exception{
		int psID = notif.getRecipientId();
		int prID = notif.getSenderID();
		int sID = notif.getStartupID();
		int typeOfRet = 0;
		try{
			if (notif.getType() == 1 || notif.getType() == 4){
				if (notif.getType() == 1){//apply
					if (isAccepted){
						StartupDAO sdao = new StartupDAO();
						sdao.insertPersontoStartup(sID, prID);
						typeOfRet = 2;
					}
					else{
						typeOfRet = 3;
					}
				}else if(notif.getType() == 4){//invite
					if (isAccepted){
						StartupDAO sdao = new StartupDAO();
						sdao.insertPersontoStartup(sID, psID);
						typeOfRet = 5;
					}else{
						typeOfRet = 6;
					}
				}
			Notification notifToCreate = new Notification(typeOfRet, prID, psID, sID); 
			AddNotification(notifToCreate);
			}
		}finally{
			DeleteNotification(notif.getNotificationId());
		}
	}	
}


