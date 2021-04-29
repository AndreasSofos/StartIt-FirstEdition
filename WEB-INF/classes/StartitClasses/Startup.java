package StartitClasses;

public class Startup {
    private String name;
    private String stage;
    private int employeeAge;
    private String[] jobs;
    private String[] revenue;
    private String[] markets;
    private String words;
    private String[] languages;
	private String location;
	private int id;
	

    public Startup(String name, String stage, int employeeAge, String[] jobs, String[] revenue, String[] markets, String words,String[] languages, String location) {
        this.name = name;
        this.stage = stage;
        this.employeeAge = employeeAge;
        this.jobs = jobs;
        this.revenue = revenue;
        this.markets = markets;
        this.words = words;
        this.languages=languages;
		this.location = location;
		this.id = 0;
    }
	
	public int getID() {
        return this.id;
    }

    public void setID(int id) {
        this.id = id;
    }
	
    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }
	
	public String getLocation() {
        return this.location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
  

    public String getStage() {
        return this.stage;
    }

    public void setStage(String stage) {
        this.stage = stage;
    }

    public int getEmployeeAge() {
        return this.employeeAge;
    }

    public void setEmployeeAge(int employeeAge) {
        this.employeeAge = employeeAge;
    }

    public String[] getJobs() {
        return this.jobs;
    }

    public void setJobs(String[] jobs) {
        this.jobs = jobs;
    }

    public String[] getRevenue() {
        return this.revenue;
    }

    public void setRevenue(String[] revenue) {
        this.revenue = revenue;
    }

    public String[] getMarkets() {
        return this.markets;
    }
    public String getMarket() {
        return this.markets[0];
    }

    public void setMarkets(String[] markets) {
        this.markets = markets;
    }

    public String getWords() {
        return this.words;
    }

    public void setWords(String words) {
        this.words = words;
    }

    public Startup name(String name) {
        this.name = name;
        return this;
    }

    public Startup stage(String stage) {
        this.stage = stage;
        return this;
    }

    public Startup employeeAge(int employeeAge) {
        this.employeeAge = employeeAge;
        return this;
    }

    public Startup jobs(String[] jobs) {
        this.jobs = jobs;
        return this;
    }

    public Startup revenue(String[] revenue) {
        this.revenue = revenue;
        return this;
    }

    public Startup markets(String[] markets) {
        this.markets = markets;
        return this;
    }

    public Startup words(String words) {
        this.words = words;
        return this;
    }

   
 

    @Override
    public String toString() {
        return "{" +
            " name='" + getName() + "'" +
            ", stage='" + getStage() + "'" +
            ", employeeAge='" + getEmployeeAge() + "'" +
            ", jobs='" + getJobs() + "'" +
            ", revenue='" + getRevenue() + "'" +
            ", markets='" + getMarkets() + "'" +
            ", words='" + getWords() + "'" +
            "}";
    }


    public Startup() {
    }

	public String[] getLanguages() {
		// TODO Auto-generated method stub
		return this.languages;
	}
}