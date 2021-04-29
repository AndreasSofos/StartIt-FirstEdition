package StartitClasses;

public class Notification {
    private int Nottype;
    private int RecipientId;
    private int NotificationId;
	private int senderID;
	private int startupID;


    public int getType() {
        return this.Nottype;
    }

    public void setType(int type) {
        this.Nottype = type;
    }

    public int getRecipientId() {
        return this.RecipientId;
    }

    public void setRecipientId(int recipientId) {
        this.RecipientId = recipientId;
    }

    public int getNotificationId() {
        return this.NotificationId;
    }

    public void setNotificationId(int notificationId) {
        this.NotificationId = notificationId;
    }
	
	public int getStartupID() {
        return this.startupID;
    }
	
	public int getSenderID() {
		return this.senderID;
	}
	
	public void setSenderID(int id){
		this.senderID = id;
	}
	
	public void setStartupID(int id){
		this.startupID = id;
	}
	
    public Notification(int type, int recipientId, int senderID, int startupID) {
        this.Nottype = type;
        this.RecipientId = recipientId;
        this.NotificationId = 0;
		this.senderID = senderID;
		this.startupID = startupID;
    }
}
