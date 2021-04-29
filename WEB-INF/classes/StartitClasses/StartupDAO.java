package StartitClasses;
import java.io.File;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.io.*; 
public class StartupDAO {
	
	
	public ArrayList<Startup> weightedSearchResults(ArrayList<Startup> filtered){
		ArrayList<Startup> all = new ArrayList<Startup>();
		int countunique = 0;
		for (int i=0; i < filtered.size(); i++){
			if (!all.contains(filtered.get(i))) { 
				countunique++;
			} 
			all.add(filtered.get(i));
		}
		
		
		int[][] corresperid = new int[countunique][2];
		
		for (int i = 0; i < countunique; i++){
			for (Startup s:all){
				int id = s.getID();
				ArrayList <Integer> firstcolumn = new ArrayList<Integer>();
				for (int j = 0; j < countunique; j++){
					firstcolumn.add(corresperid[j][0]);
				}
				if (!firstcolumn.contains(id)){
					corresperid[i][0] = id;
					corresperid[i][1] = Collections.frequency(all, s);
				}
			}
		}
		
		sortbyColumn(corresperid, 1);
		ArrayList<Startup> weighted = new ArrayList<Startup>();
		int idtoappear = 0; 
		
		for (Startup s:all){
			if (s.getID() == corresperid[idtoappear][0]){
				if (!weighted.contains(s)){
					weighted.add(s);
					idtoappear++;
				}
			}
		}
		
		return weighted;
		
		
		
	}




    public void updateDB(People user,Startup startup) throws Exception{
        Database dataObj = new Database();
        Connection con = dataObj.getConnection();
        
        String name = startup.getName();
        String stage = startup.getStage();
        int employeeAge= startup.getEmployeeAge();
        String[] jobs = startup.getJobs();
        String[] revenue= startup.getRevenue();
        String[] markets=startup.getMarkets();
        String words=startup.getWords();
        String[] languages=startup.getLanguages();
		String location=startup.getLocation();
        
        String insertString = "INSERT INTO startupperinos (namerino, stagerino, age,words, location) VALUES ( ? , ? , ?, ?, ?);";

		try {

			PreparedStatement statement = con.prepareStatement(insertString);
			statement = con.prepareStatement(insertString);

			statement.setString(1, name);
			statement.setString(2, stage);
			statement.setInt(3, employeeAge);
            statement.setString(4, words);
			statement.setString(5, location);
            statement.executeUpdate();
            
 // CHANGE LANGUAGES
            int sID= findId(startup);
            
            String insert2 = "INSERT INTO startupjobs (id, lang) VALUES ( ? , ? );"; //to lang edw einai swsto giati etsi einai kai sth vash, eixe ginei lathos otan dhmiourgithike o pinakas
            PreparedStatement statement2 = con.prepareStatement(insert2);
            for(String job: jobs){
				statement2.setInt(1, sID);
				statement2.setString(2, job);
				statement2.executeUpdate();
            }
            
			
			String insert7 = "INSERT INTO startupperinosmarket (startupid, market) VALUES ( ? , ? );";
            PreparedStatement statement7 = con.prepareStatement(insert7);
            for(String market: markets){
				statement7.setInt(1, sID);
				statement7.setString(2, market);
				statement7.executeUpdate();
			}
            
            
            String insert3 = "INSERT INTO startuplanguages (id, lang) VALUES ( ? , ? );";
            PreparedStatement statement3 = con.prepareStatement(insert3);
            for(String lang: languages){
				statement3.setInt(1, sID);
				statement3.setString(2, lang);
				statement3.executeUpdate();
			}
            
            
            String insert4 = "INSERT INTO revenuetypes  (id, typerino) VALUES ( ? , ? );";
            PreparedStatement statement4 = con.prepareStatement(insert4);
            for(String rev: revenue){
				statement4.setInt(1, sID);
				statement4.setString(2, rev);
				statement4.executeUpdate();
			}
            int userid= PeopleDAO.findId(user.getEmail(), user.getPassword());
            
            
            String insert5 = "INSERT INTO teamsandmanagerids  (pid, sid) VALUES ( ? , ? );";
            PreparedStatement statement5 = con.prepareStatement(insert5);
            statement5.setInt(1, userid);
			statement5.setInt(2, sID);
			statement5.executeUpdate();
			
            String insert6 = "INSERT INTO groupsperperson  (PersonID, StartupID) VALUES ( ? , ? );";
            PreparedStatement statement6 = con.prepareStatement(insert6);
            statement6.setInt(1, userid);
			statement6.setInt(2, sID);
			statement6.executeUpdate();
			
			
			
			statement.close();
			dataObj.close();

		} catch (Exception e) {
			throw new Exception("Something went wrong " + e.getMessage());
		} finally {
			con.close();
		}
    }
	
	public static void insertPersontoStartup(int sid, int pid) throws Exception{
		try{	
			Database dataObj = new Database();
			Connection con = dataObj.getConnection();
			String insert6 = "INSERT INTO groupsperperson  (PersonID, StartupID) VALUES ( ? , ? );";
			PreparedStatement statement6 = con.prepareStatement(insert6);
			statement6.setInt(1, pid);
			statement6.setInt(2, sid);
			statement6.executeUpdate();
			con.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public boolean isStartupLeader(int startupID,int personID){
		boolean isLeader = false;
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
				if (pid == personID && sid == startupID){
					isLeader = true;
				}
			}
			con.close();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			return isLeader;
		}
	}
	
	public ArrayList<Startup> loadMyStartups(int pid)throws Exception{
		ArrayList<Startup> startups = new ArrayList<Startup>();
		try{	
			Database dataObj = new Database();
			Connection con = dataObj.getConnection();
			String query = "SELECT StartupID FROM groupsperperson WHERE PersonID = ?";
			PreparedStatement statement = con.prepareStatement(query);
			statement.setInt(1, pid);
			ResultSet rs = statement.executeQuery();
			ArrayList<Integer> sids = new ArrayList<Integer>();
			while (rs.next()){
				sids.add(rs.getInt("StartupID"));
			}
			con.close();
			for (int id : sids){
				startups.add(findById(id));
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return startups;

	}	
	
	public ArrayList<Integer> alreadyAppliedOrMember(int personid) throws Exception{
		Database dataObj = new Database();
		Connection con = dataObj.getConnection();
		ArrayList<Integer> ids = new ArrayList<Integer>();

		try {
			String query = "SELECT * FROM groupsperperson WHERE PersonID=? ";
			PreparedStatement statement = con.prepareStatement(query);
			statement.setInt(1, personid);
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				ids.add(rs.getInt("startupID"));
			}
			String query2 = "SELECT * FROM notifications WHERE senderID=? and NotType=?";
			PreparedStatement statement2 = con.prepareStatement(query2);
			statement2.setInt(1, personid);
			statement2.setInt(2, 1);	
			ResultSet rs2 = statement2.executeQuery();
			while (rs2.next()) {
				ids.add(rs2.getInt("startupID"));
			}
			String query3 = "SELECT * FROM notifications WHERE RecepientId=? and NotType=?";
			PreparedStatement statement3 = con.prepareStatement(query3);
			statement3.setInt(1, personid);
			statement3.setInt(2, 4);	
			ResultSet rs3 = statement3.executeQuery();
			while (rs3.next()) {
				ids.add(rs3.getInt("startupID"));
			}
		}finally{
			return ids;
		}
	}	
	
    public ArrayList<Startup> getStartups() throws Exception { //send filters in responding position in args
    	Database dataObj = new Database();
		Connection con = dataObj.getConnection();
		ArrayList<Startup> startups = new ArrayList<Startup>();

		try {
			
			//first get the lists
			String query = "SELECT * FROM startupperinos "; //jobs
			PreparedStatement statement = con.prepareStatement(query);
			ResultSet rs = statement.executeQuery();
			String[] jobs;
			String[] langs;
			String[] revs;
			String[] markets;
			
			while (rs.next()) {
				String name = rs.getString("namerino"); 
				String stage = rs.getString("stagerino");
				int employeeAge = rs.getInt("age");
				String words= rs.getString("words");
				int id = rs.getInt("startupID");
				String loc= rs.getString("location");
				//fill lists;
				jobs=getJobs(id);
				langs=getLanguages(id);
				revs=getRevs(id);
				markets=getMarkets(id);
				Startup s = new Startup(name,stage,employeeAge,jobs,revs,markets,words,langs,loc);
				s.setID(id);
				startups.add(s);
			}
			return startups;
		}catch(Exception e){
			
		}finally {
			return startups;

		}	
    }
    
    
    
    public String[] getLanguages(int id) throws Exception{
		Database dataObj = new Database();
		Connection con = null;
		PreparedStatement statement = null;
		ResultSet rs = null;
		String query = "SELECT * FROM startuplanguages";
		List<String> langs = new ArrayList<String>();
		try{
			con = dataObj.getConnection();
			statement = con.prepareStatement(query);
			rs = statement.executeQuery();
			while (rs.next()) {
				if(id==rs.getInt("id")){
					langs.add(rs.getString("lang"));
				}
			}
		}catch (Exception e) {
			throw new Exception("Couldn't load the specs");
		}
		dataObj.close();
		String[] arr = new String[langs.size()];
		arr = langs.toArray(arr);
		return arr;
			
	}
    public String[] getJobs(int id) throws Exception{
  		Database dataObj = new Database();
  		Connection con = null;
  		PreparedStatement statement = null;
  		ResultSet rs = null;
  		String query = "SELECT * FROM startupjobs";
  		List<String> jobs = new ArrayList<String>();
  		try{
  			con = dataObj.getConnection();
  			statement = con.prepareStatement(query);
  			rs = statement.executeQuery();
  			while (rs.next()) {
  				if(id==rs.getInt("id")){
  					jobs.add(rs.getString("lang"));
  				}
  			}
  		}catch (Exception e) {
  			throw new Exception("Couldn't load the specs");
  		}
  		dataObj.close();
  		String[] arr = new String[jobs.size()];
  		arr = jobs.toArray(arr);
  		return arr;
  			
  	}
    
    public String[] getRevs(int id) throws Exception{
  		Database dataObj = new Database();
  		Connection con = null;
  		PreparedStatement statement = null;
  		ResultSet rs = null;
  		String query = "SELECT * FROM revenuetypes";
  		List<String> revs = new ArrayList<String>();
  		try{
  			con = dataObj.getConnection();
  			statement = con.prepareStatement(query);
  			rs = statement.executeQuery();
  			while (rs.next()) {
  				if(id==rs.getInt("id")){
  					revs.add(rs.getString("typerino"));
  				}
  			}
  		}catch (Exception e) {
  			throw new Exception("Couldn't load the specs");
  		}
  		dataObj.close();
  		String[] arr = new String[revs.size()];
  		arr = revs.toArray(arr);
  		return arr;
  			
  	}
    public String[] getMarkets(int id) throws Exception{
  		Database dataObj = new Database();
  		Connection con = null;
  		PreparedStatement statement = null;
  		ResultSet rs = null;
  		String query = "SELECT * FROM startupperinosmarket";
  		List<String> markets = new ArrayList<String>();
  		try{
  			con = dataObj.getConnection();
  			statement = con.prepareStatement(query);
  			rs = statement.executeQuery();
  			while (rs.next()) {
  				if(id==rs.getInt("startupid")){
  					markets.add(rs.getString("market"));
  				}
  			}
  		}catch (Exception e) {
  			throw new Exception("Couldn't load the specs");
  		}
  		dataObj.close();
  		String[] arr = new String[markets.size()];
  		arr = markets.toArray(arr);
  		return arr;
  			
  	}
   /* public ArrayList<Startup> findStartups(String[] argsArrays) throws Exception { //send filters in responding position in args
    	
		
		try {
			if(argsArrays.length!=0) { //if list isnt empty	
				for(int i=0;i<argsArrays.length;i++) {
					if(argsArrays[i]!=null && i==0) { //check by looking for
						ArrayList<Startup> byJobs = new ArrayList<Startup>();
						byJobs=findStartupsByJob();
						startups.addAll(byJobs);
						
					}else if(argsArrays[i]!=null && i==1) {//by location 
						ArrayList<Startup> byLoc = new ArrayList<Startup>();
						byJobs=findStartupsByLoc();
						startups.addAll(byLoc);
					}else if(argsArrays[i]!=null && i==2) {//market
						ArrayList<Startup> byMark = new ArrayList<Startup>();
						byJobs=findStartupsbyMark();
						startups.addAll(byMark);
					}else if(argsArrays[i]!=null && i==3) {//langs
						ArrayList<Startup> byLang = new ArrayList<Startup>();
						byJobs=findStartupsbyLang();
						startups.addAll(byLang);
					}
			}
		}
		return startups;
		} catch (Exception e) {
			throw new Exception("Something went wrong " + e.getMessage());
		} finally {
			con.close();
		} 
    }*/
    
	public ArrayList<Startup>[] filteredSearch(String[] jobs, String loc, String[] markets, String[] langs, ArrayList<Startup> startups){
		ArrayList<Startup>[] filtered = new ArrayList[4]; 
        // initializing 
        for (int i = 0; i < 4; i++) { 
            filtered[i] = new ArrayList<Startup>();
        }
		for (Startup startup : startups) {
			if (FindCommonElement(jobs, startup.getJobs())) {
				filtered[0].add(startup);
			}
			if ((startup.getLocation()).equals(loc)) {
				filtered[1].add(startup);
			}
			if (FindCommonElement(markets, startup.getMarkets())){
				filtered[2].add(startup);
			}
			if (FindCommonElement(langs, startup.getLanguages())){
				filtered[3].add(startup);
			}
		}
		return filtered;
	}
	
	public Boolean FindCommonElement(String[] arr1, String[] arr2){ 
        Set<String> set=new HashSet<>(); 
        for(int i = 0; i < arr1.length; i++){ 
            for(int j = 0; j < arr2.length; j++){ 
                if(arr1[i] == arr2[j]){  
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
   
    public static int findId(Startup startup) throws Exception{
		Database dataObj = new Database();
		ResultSet rs = null;
		Connection con = dataObj.getConnection();
      
        String name = startup.getName();
        String stage = startup.getStage();
        int employeeAge= startup.getEmployeeAge();
        String words=startup.getWords();
        String[] languages=startup.getLanguages();
		String location=startup.getLocation();
		int res=0;
		String query = "SELECT * FROM startupperinos WHERE namerino = ? and stagerino = ? and age = ? and words = ? and location = ?;";
		try {

			PreparedStatement statement = con.prepareStatement(query);

			statement.setString(1, name);
			statement.setString(2, stage);
			statement.setInt(3, employeeAge);
			statement.setString(4, words);
			statement.setString(5, location);
			
			rs = statement.executeQuery();
			
			if(rs.next()){
				res = rs.getInt("startupID");
				return res;
			}
		
		

		} catch (Exception e) {
			e.printStackTrace();

		}
		dataObj.close();
		return res;
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
		
		
		
	
    public Startup findById(int id) throws Exception { //works, checked
    	Database dataObj = new Database();
		ResultSet rs = null;
		Connection con = dataObj.getConnection();
		
		String[] jobs;
		String[] langs;
		String[] revs;
		String[] markets;
		
		Startup mine = new Startup();
		
		
		String query = "SELECT * FROM startupperinos WHERE startupID = ? ;";
		PreparedStatement statement = con.prepareStatement(query);
		statement.setInt(1, id);
		rs = statement.executeQuery();

		while(rs.next()) {
			String name = rs.getString("namerino"); 
			String stage = rs.getString("stagerino");
			int employeeAge = rs.getInt("age");
			String words= rs.getString("words");
			String loc= rs.getString("location");
			//fill lists;
			jobs=getJobs(id);
			langs=getLanguages(id);
			revs=getRevs(id);
			markets=getMarkets(id);
			mine = new Startup(name,stage,employeeAge,jobs,revs,markets,words,langs,loc);
			mine.setID(id);
		}
		return mine;
    }
    public ArrayList<Startup> finalSearch(String[] jobs,String location,String[] markets,String[] languages) throws Exception{
		ArrayList<Startup> mine = new ArrayList<Startup>();
		ArrayList<Startup> goodJobs= new ArrayList<Startup>();
		ArrayList<Startup> goodLoc= new ArrayList<Startup>();
		ArrayList<Startup> goodMarket= new ArrayList<Startup>();
		ArrayList<Startup> goodLangs= new ArrayList<Startup>();
		
		
		Database dataObj = new Database();
		ResultSet rs = null;
		Connection con = dataObj.getConnection();

		if(jobs!=null && jobs.length!=0) {
			String query = "SELECT * FROM startupjobs WHERE lang = ? ;";
			for(String job : jobs) {
				PreparedStatement statement = con.prepareStatement(query);
				statement.setString(1, job);
				rs = statement.executeQuery();
				while(rs.next()){
					int id = rs.getInt("id");
					Startup s = findById(id);
					
					goodJobs.add(s);
				}
			}
		}
		if(location!=null) {
			String query = "SELECT * FROM startupperinos WHERE location = ? ;";
			
				PreparedStatement statement = con.prepareStatement(query);
				statement.setString(1, location);
				rs = statement.executeQuery();
				while(rs.next()){
					int id = rs.getInt("startupID");
					Startup s = findById(id);
					
					goodLoc.add(s);
				}
			
		}
		if(markets!=null && markets.length!=0) {
			String query = "SELECT * FROM startupperinosmarket WHERE market = ? ;";
			for(String market : markets) {
				PreparedStatement statement = con.prepareStatement(query);
				statement.setString(1, market);
				rs = statement.executeQuery();
				while(rs.next()){
					int id = rs.getInt("startupid");
					Startup s = findById(id);
					
					goodMarket.add(s);
				}
			}
		}
		if(languages!=null && languages.length!=0) {
			String query = "SELECT * FROM startuplanguages WHERE lang = ? ;";
			for(String lang : languages) {
				PreparedStatement statement = con.prepareStatement(query);
				statement.setString(1, lang);
				rs = statement.executeQuery();
				while(rs.next()){
					int id = rs.getInt("id");
					Startup s = findById(id);
					
					goodLangs.add(s);
				}
			}
		}
		mine.addAll(goodLoc);
		mine.addAll(goodJobs);
		mine.addAll(goodMarket);
		mine.addAll(goodLangs);
		return mine;
    }
}

