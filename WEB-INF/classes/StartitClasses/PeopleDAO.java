package StartitClasses;

import java.util.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.io.*; 


/**
 * PeopleDAO provides all the necessary methods related to users in order to
 * connect to the database and store/retrieve users etc.
 * 
 * @author
 *
 */
public class PeopleDAO {

	/**
	 * This method returns a List with all Users
	 * 
	 * @return List<User>
	 */
	public ArrayList<People> getPeople() throws Exception {
		Database dataObj = new Database();
		Connection con = dataObj.getConnection();
		try {

			ArrayList<People> users = new ArrayList<People>();
			String query = "SELECT * FROM people";
			PreparedStatement statement = con.prepareStatement(query);
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				String name = rs.getString("Pname") ;
				String lastName= rs.getString("PSurname");
				String email = rs.getString("Email");
				String pass = rs.getString("PPassword");
				String location = rs.getString("Location");
				int id = rs.getInt("PersonID");
				String gender = rs.getString("Gender");
				int age = rs.getInt("Age");
				String occupation = rs.getString("Occupation");
				String edu = rs.getString("Education");
				String[] socials = getSocials(id);
				String[] langs = getLanguages(id);
				String[] specialties = getSpecialties(id);
				String[] interests = getInterests(id);
				People user = new People(name, lastName, email, pass, age, location, gender, occupation, edu, interests, specialties, socials, langs);
				user.setID(id);
				users.add(user);
			}
			return users;
		} catch (Exception e) {
			throw new Exception("Something went wrong " + e.getMessage());
		} finally {
			con.close();
		}
	} // End of getUsers
	
	public ArrayList<Integer> alreadyInvitedOrMember(int startupid) throws Exception{
		Database dataObj = new Database();
		Connection con = dataObj.getConnection();
		ArrayList<Integer> ids = new ArrayList<Integer>();

		try {
			String query = "SELECT * FROM groupsperperson WHERE StartupID=? ";
			PreparedStatement statement = con.prepareStatement(query);
			statement.setInt(1, startupid);
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				ids.add(rs.getInt("PersonID"));
			}
			String query2 = "SELECT * FROM notifications WHERE startupID=? and NotType=?";
			PreparedStatement statement2 = con.prepareStatement(query2);
			statement2.setInt(1, startupid);
			statement2.setInt(2, 4);	
			ResultSet rs2 = statement2.executeQuery();
			while (rs2.next()) {
				ids.add(rs2.getInt("RecepientId"));
			}
			String query3 = "SELECT * FROM notifications WHERE startupID=? and NotType=?";
			PreparedStatement statement3 = con.prepareStatement(query3);
			statement3.setInt(1, startupid);
			statement3.setInt(2, 1);	
			ResultSet rs3 = statement3.executeQuery();
			while (rs3.next()) {
				ids.add(rs2.getInt("RecepientID"));
			}
		}finally{
			return ids;
		}
	}	
	
	public ArrayList<People> filteredSearch(int agemin, int agemax, String loc, String[] specs, String[] langs, ArrayList<People> users){
		ArrayList<People> filtered = new ArrayList<People>(); 
        // initializing 
        

		for (People user : users) {
			
			if (user.getAge() >= agemin && user.getAge() <= agemax) {
				filtered.add(user);
			}
			
			if (user.getLocation()!= null && loc!="" ){
				if ((user.getLocation()).equals(loc)) {
					filtered.add(user);
				}
			}
			if (user.getSpecialties() != null && specs != null){
				if (user.getSpecialties().length != 0){
					if (FindCommonElement(specs, user.getSpecialties())){
						filtered.add(user);
					}
				}
			}
			if (user.getLanguages() != null && langs != null){
				if (user.getLanguages().length != 0){
					if (FindCommonElement(langs, user.getLanguages())){
						filtered.add(user);
					}
				}
			}
		}
		return filtered;
	}
	
	public Boolean FindCommonElement(String[] arr1, String[] arr2){ 
        Set<String> set=new HashSet<>(); 
        for(int i = 0; i < arr1.length; i++){ 
            for(int j = 0; j < arr2.length; j++){ 
                if(arr1[i].equals(arr2[j])){  
                    set.add(arr1[i]); 
                    break;          
                } 
            } 
        }
        if (set.isEmpty()){
        	return false;
        }
        else {
        	return true;
        }
	}
	
	public ArrayList<People> weightedSearchResults(ArrayList<People> filtered){
		ArrayList<People> all = new ArrayList<People>();
		int countunique = 0;
		for (int i=0; i < filtered.size(); i++){
			if (!all.contains(filtered.get(i))) { 
				countunique++;
			} 
			all.add(filtered.get(i));
		}
		
		
		int[][] corresperid = new int[countunique][2];
		
		for (int i = 0; i < countunique; i++){
			for (People user:all){
				int id = user.getID();
				ArrayList <Integer> firstcolumn = new ArrayList<Integer>();
				for (int j = 0; j < countunique; j++){
					firstcolumn.add(corresperid[j][0]);
				}
				if (!firstcolumn.contains(id)){
					corresperid[i][0] = id;
					corresperid[i][1] = Collections.frequency(all, user);
				}
			}
		}
		
		sortbyColumn(corresperid, 1);
		ArrayList<People> weighted = new ArrayList<People>();
		int idtoappear = 0; 
		
		for (People user:all){
			if (user.getID() == corresperid[idtoappear][0]){
				if (!weighted.contains(user)){
					weighted.add(user);
					idtoappear++;
				}
			}
		}
		
		return weighted;
		
		
		
	}
	
	
	public static void sortbyColumn(int arr[][], int col) { 
        // Using built-in sort function Arrays.sort 
        Arrays.sort(arr, new Comparator<int[]>() { 
            
          @Override              
          // Compare values according to columns 
          public int compare(final int[] entry1,  
                             final int[] entry2) { 
  
            // To sort in descending order revert  
            // the '>' Operator 
            if (entry1[col] < entry2[col]) 
                return 1; 
            else
                return -1; 
          } 
        });  // End of function call sort(). 
    } 
	
	public static void fullRegister(People user) throws Exception{
		Database dataObj = new Database();
		String sqlupdate = "UPDATE people SET  Age=?,Location=?,Gender=?,IsTeamLeader=?,Occupation=?,Education=? WHERE PersonID= ?";
		updateListsOf(user);
		Connection con = dataObj.getConnection();
		PreparedStatement statement = null;
		try {
			statement = con.prepareStatement(sqlupdate);
			statement.setInt(1, user.getAge());
			statement.setString(2, user.getLocation());
			statement.setString(3, user.getGender());
			statement.setBoolean(4, user.getIsTeamLeader());
			statement.setString(5, user.getOccupation());
			statement.setString(6, user.getEducation());
			int id =  findId(user.getEmail(), user.getPassword());
			statement.setInt(7, id);
			user.setID(id);
			statement.executeUpdate();
			
			statement.close();
			dataObj.close();

		} catch (Exception e) {
			throw new Exception("Something went wrong " + e.getMessage());
		} finally {
			con.close();
		}
	}

	public static void updateListsOf(People user) throws Exception{
		int id= findId(user.getEmail(), user.getPassword());
		String[] skills = user.getSpecialties();
		Database dataObj = new Database();
		String sqlupdate = "INSERT INTO speciatlies (PersonID, Specialty) VALUES ( ?, ?);";
		Connection con = dataObj.getConnection();
		PreparedStatement statement = con.prepareStatement(sqlupdate);
		try{
			for(String skill : skills){
				statement.setInt(1, id);
				statement.setString(2, skill);
				statement.executeUpdate();
			}
			String[] socials = user.getSocials();
			sqlupdate="INSERT INTO socmedia (PersonID, SMediaType, SmediaAddress ) VALUES ( ?, ?, ?);";
			statement = con.prepareStatement(sqlupdate);
			int i=0;
			for(String social : socials){
				statement.setInt(1, id);
				switch (i){
				case 0:
					statement.setString(2,"Facebook");
					break;
				case 1:
					statement.setString(2,"Instagram");
					break;
				case 2:
					statement.setString(2,"LinkedIn");
					break;
				case 3:
					statement.setString(2,"Twitter");
					break;
				}
				statement.setString(3, socials[i]);
				statement.executeUpdate();
				i++;
			}
			String[] languages = user.getLanguages();
			sqlupdate="INSERT INTO languages (PersonID, lang) VALUES ( ?, ?);";
			statement = con.prepareStatement(sqlupdate);
			for(String lang : languages){
				statement.setInt(1, id);
				statement.setString(2, lang);
				statement.executeUpdate();
			}
			String[] hobbies = user.getInterests();
			sqlupdate="INSERT INTO interests (PersonID, Interest) VALUES ( ?, ?);";
			statement = con.prepareStatement(sqlupdate);
			for(String hobby: hobbies){
				statement.setInt(1, id);
				statement.setString(2, hobby);
				statement.executeUpdate();
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		dataObj.close();
	
	}
	
	public int startUpLeader(int startupID) throws Exception{
		int leaderid = 0;
		try{			
			Database dataObj = new Database();
			Connection con = dataObj.getConnection();
			String query = "SELECT * FROM teamsandmanagerids";
			PreparedStatement statement = con.prepareStatement(query);
			ResultSet rs = statement.executeQuery();
			int sid;
			int pid;
			while (rs.next()){
				sid = rs.getInt("sid");
				pid = rs.getInt("pid");
				if (sid == startupID){
					leaderid = pid;
				}
			}
		}finally{
			return leaderid;
		}
	}
	
	public People findById(int id) throws Exception { //works, checked
		Database dataObj = new Database();
		Connection con = dataObj.getConnection();
		try {

			ArrayList<People> users = new ArrayList<People>();
			String query = "SELECT * FROM people WHERE PersonID=? ";
			People user = new People();
			PreparedStatement statement = con.prepareStatement(query);
			statement.setInt(1, id);
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				String name = rs.getString("Pname") ;
				String lastName= rs.getString("PSurname");
				String email = rs.getString("Email");
				String pass = rs.getString("PPassword");
				String location = rs.getString("Location");
				id = rs.getInt("PersonID");
				String gender = rs.getString("Gender");
				int age = rs.getInt("Age");
				String occupation = rs.getString("Occupation");
				String edu = rs.getString("Education");
				String[] socials = getSocials(id);
				String[] langs = getLanguages(id);
				String[] specialties = getSpecialties(id);
				String[] interests = getInterests(id);
				user = new People(name, lastName, email, pass, age, location, gender, occupation, edu, interests, specialties, socials, langs);
				user.setID(id);
				return user;
			}
			return user;
		} catch (Exception e) {
			throw new Exception("Something went wrong " + e.getMessage());
		} finally {
			con.close();
		}
    }
	
	public static int findId(String email,String password) throws Exception{
		Database dataObj = new Database();
		Connection con = null;
		PreparedStatement statement = null;
		ResultSet rs = null;
		String query = "SELECT * FROM people";
		int id=0;
		try {
			con = dataObj.getConnection();
			statement = con.prepareStatement(query);
			rs = statement.executeQuery();
			while (rs.next()) {
				String email1 = rs.getString("Email");
				String password1 = rs.getString("PPassword");
				if (email1.equals(email) && password.equals(password1)) {
					 id = rs.getInt("PersonID");
			
				}
			}
		} catch (Exception e) {
			e.printStackTrace();

		}
		dataObj.close();
		return id;

	
	}
	public People findUserSimple(int id) throws Exception {
		Database dataObj = new Database();
		Connection con = dataObj.getConnection();
		String query = "SELECT * FROM people WHERE PersonID=?;";
		PreparedStatement statement = con.prepareStatement(query);
		People myGuy= new People();
		try {

			statement.setInt(1, id);
			ResultSet rs = statement.executeQuery();
			if (rs.next()) {
				String name = rs.getString("PName");
				String surname = rs.getString("PSurname");
				String email = rs.getString("Email");
				String pass = rs.getString("PPassword");
				myGuy = new People(name, surname, email, pass);
			
			}
		}finally{

		}
		return myGuy;
	}
	public ArrayList<People> findPeopleFromSID(int startupid) throws Exception{
		ArrayList<People> ppl= new ArrayList<People>();
		Database dataObj = new Database();
		Connection con = dataObj.getConnection();
		ArrayList<Integer> pplIds = new ArrayList<Integer>();
		String query = "SELECT * FROM groupsperperson WHERE StartupID=?;";
		PreparedStatement statement = con.prepareStatement(query);
		statement.setInt(1, startupid);
		ResultSet rs = statement.executeQuery();
		
		while (rs.next()) {
			int id = rs.getInt("PersonID");
			pplIds.add(id);
		}	
		for(int i : pplIds) {
			ppl.add(findById(i));
		}
		return ppl;	
	}
	
	/**
	 * Search user by username
	 * 
	 * @param username, String
	 * @return User, the User object
	 * @throws Exception, if user not found
	 */
//	public People findUserSimple(int id) throws Exception {
//		Database dataObj = new Database();
//		Connection con = dataObj.getConnection();
//		String query = "SELECT * FROM people WHERE PersonID=?;";
//		PreparedStatement statement = con.prepareStatement(query);
//
//		try {
//
//			statement.setInt(1, id);
//			ResultSet rs = statement.executeQuery();
//
//			if (rs.next()) {
//				String fullname = rs.getString("Pname"); // remember to split name
//				String split[] = fullname.split(" ", 0);
//				String name = split[0];
//				String lastName;
//				String email = rs.getString("Email");
//				String pass = rs.getString("PPassword");
//				String location = rs.getString("Location");
//				String gender = rs.getString("Gender");
//				String isTeamLeader = rs.getString("IsTeamLeader");
//				int age = rs.getInt("Age");
//				for (String s : split) {
//					lastName = lastName + s;
//				}
//				File portfolio = getPortfolio();
//				File picture = getPicture();
//				String[] socials = getSocials(id);
//				String[] langs = getLanguages(id);
//				String[] specialties = getSpecialties(id);
//				String[] interests = getInterests(id);
//				People user = new People(name, lastName, email, pass, age, location, gender, portfolio, interests,
//						specialties, socials, langs);
//				return user;
//				return user;
//			}
////
	//		rs.close();
	//		statement.close();
	//		dataObj.close();
	//		return null;
//
//		} catch (Exception e) {
//			throw new Exception("Something went wrong" + e.getMessage());
//		} finally {
//
//			dataObj.close();
//		}
//
//	}
	// End of findUser

	/**
	 * This method is used to authenticate a user.
	 * 
	 * @param username, String
	 * @param password, String
	 * @return User, the User object
	 * @throws Exception, if the credentials are not valid
	 */
	public People authenticate(String email, String password) throws Exception {
		Database dataObj = new Database();
		Connection con = null;
		ResultSet rs = null;
		con = dataObj.getConnection();
		String query = "SELECT * FROM people";
		PreparedStatement statement = con.prepareStatement(query);
		rs = statement.executeQuery();

		try {
			while (rs.next()) {
				String email1 = rs.getString("Email");
				String password1 = rs.getString("PPassword");
				if ((email1.equals(email)) && (password1.equals(password))){
					String name = rs.getString("PName");
					String lastName = rs.getString("PSurname");
					String location = rs.getString("Location");
					int id = rs.getInt("PersonID");
					String gender = rs.getString("Gender");
					String isTeamLeader = rs.getString("IsTeamLeader");
					int age = rs.getInt("Age");
					String occupation = rs.getString("Occupation");
					String education = rs.getString("Education");
					String[] socials = getSocials(id);
					String[] langs = getLanguages(id);
					String[] specialties = getSpecialties(id);
					String[] interests = getInterests(id);
					People user = new People(name, lastName, email1, password1, age, location, gender, occupation, education, interests, specialties, socials, langs);
					user.setID(id);
					return user;
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		dataObj.close();
		throw new Exception("Wrong email or Password");

	}
	// End of authenticate

	public String[] getSocials(int id)throws Exception{
		Database dataObj = new Database();
		Connection con = null;
		PreparedStatement statement = null;
		ResultSet rs = null;
		String query = "SELECT * FROM socmedia WHERE PersonID = ?;";
		String[] mediaz = new String[4];

		try {
			con = dataObj.getConnection();
			statement = con.prepareStatement(query);
			statement.setInt(1, id);
			rs = statement.executeQuery();
			while (rs.next()) {
				if (rs.getString("SMediaType").equals("Facebook")){
					mediaz[0] = rs.getString("SmediaAddress");
				}else if (rs.getString("SMediaType").equals("Instagram")){
					mediaz[1] = rs.getString("SmediaAddress");
				}else if (rs.getString("SMediaType").equals("Twitter")){
					mediaz[2] = rs.getString("SmediaAddress");
				}else if (rs.getString("SMediaType").equals("LinkedIn")){
					mediaz[3] = rs.getString("SmediaAddress");
				}
			}
		}			
	
		catch (Exception e) {
			throw new Exception("Couldn't load the socialmedia");
		}
		dataObj.close();
		return mediaz;
	}
	
	public String[] getLanguages(int id) throws Exception{
		Database dataObj = new Database();
		Connection con = null;
		PreparedStatement statement = null;
		ResultSet rs = null;
		String query = "SELECT * FROM languages WHERE PersonID = ?;";
		List<String> langz = new ArrayList<String>();

		try {
			con = dataObj.getConnection();
			statement = con.prepareStatement(query);
			statement.setInt(1, id);
			rs = statement.executeQuery();
			while (rs.next()){
				langz.add(rs.getString("Lang"));
			}
		}	
		catch (Exception e) {
			throw new Exception("Couldn't load the langs");
		}
		dataObj.close();
		String[] langzarr = new String[langz.size()];
		langzarr = langz.toArray(langzarr);
		return langzarr;
		
	}
	
	public String[] getSpecialties(int id) throws Exception{
		Database dataObj = new Database();
		Connection con = null;
		PreparedStatement statement = null;
		ResultSet rs = null;
		String query = "SELECT * FROM speciatlies";
		List<String> skillz = new ArrayList<String>();
		try{
			con = dataObj.getConnection();
			statement = con.prepareStatement(query);
			rs = statement.executeQuery();
			while (rs.next()) {
				if(id==rs.getInt("PersonID")){
					skillz.add(rs.getString("Specialty"));
				}
			}
		}catch (Exception e) {
			throw new Exception("Couldn't load the specs");
		}
		dataObj.close();
		String[] skillzarr = new String[skillz.size()];
		skillzarr = skillz.toArray(skillzarr);
		return skillzarr;
			
	}
	
	public String[] getInterests(int id)throws Exception{
		Database dataObj = new Database();
		Connection con = null;
		PreparedStatement statement = null;
		ResultSet rs = null;
		String query = "SELECT * FROM interests";
		List<String> interests = new ArrayList<String>();
		try{
			con = dataObj.getConnection();
			statement = con.prepareStatement(query);
			rs = statement.executeQuery();
			while (rs.next()) {
				if(id==rs.getInt("PersonID")){
					interests.add(rs.getString("Interest"));
				}
			}
		}catch (Exception e) {
			throw new Exception("Couldn't load the interests");
		}
		dataObj.close();
		String[] intsarr = new String[interests.size()];
		intsarr = interests.toArray(intsarr);
		return intsarr;
		
	}
	
	/**
	 * Register/create new User.
	 * 
	 * @param user, User
	 * @throws Exception, if encounter any error.
	 */
	public void register(People user) throws Exception {

		Database dataObj = new Database();
		String query = "SELECT * FROM people where Email=?;";
		String sqlupdate = "INSERT INTO people (PName, PSurname, Email, PPassword) VALUES ( ?, ?, ?, ?);";
		Connection con = dataObj.getConnection();

		try {

			PreparedStatement statement = con.prepareStatement(query);
			statement.setString(1, user.getEmail());
			ResultSet rs = statement.executeQuery();
			

			if (rs.next()) {
				throw new Exception("Email already registered");
			}

			statement = con.prepareStatement(sqlupdate);

			statement.setString(1, user.getName());
			statement.setString(2, user.getSurname());
			statement.setString(3, user.getEmail());
			statement.setString(4, user.getPassword());

			statement.executeUpdate();

			rs.close();
			statement.close();
			dataObj.close();

		} catch (Exception e) {
			throw new Exception("Something went wrong " + e.getMessage());
		} finally {
			con.close();
		}
	}// end of register

} // End of class
