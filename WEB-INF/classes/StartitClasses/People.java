package StartitClasses;

import java.util.ArrayList;
import java.io.File;

public class People {
    private String name;
    private String surname;
    private String email;
    private String password;
    private int age;
	private int id;
    private String location;
    private String gender;
    private String facebook;
    private String instagram;
    private String twitter;
    private String linkedin;
	private String occupation;
	private String education;
	private boolean isTeamLeader;
    private String[] interests;
    private String[] specialties;
    private String[]  socials;
    private String[]  languages;

    
    

    public String getOccupation() {
        return this.occupation;
    }
	
	public String getEducation() {
        return this.education;
    }

    public void setOccupation(String occupation) {
        this.occupation = occupation;
    }

    public People() {
    }


    public Boolean isIsTeamLeader() {
        return this.isTeamLeader;
    }

    public Boolean getIsTeamLeader() {
        return this.isTeamLeader;
    }

    public void setIsTeamLeader(Boolean isTeamLeader) {
        this.isTeamLeader = isTeamLeader;
    }

    public People name(String name) {
        this.name = name;
        return this;
    }

    public People surname(String surname) {
        this.surname = surname;
        return this;
    }

    public People email(String email) {
        this.email = email;
        return this;
    }

    public People password(String password) {
        this.password = password;
        return this;
    }

    public People age(int age) {
        this.age = age;
        return this;
    }

    public People location(String location) {
        this.location = location;
        return this;
    }

    public People gender(String gender) {
        this.gender = gender;
        return this;
    }

    public People facebook(String facebook) {
        this.facebook = facebook;
        return this;
    }

    public People instagram(String instagram) {
        this.instagram = instagram;
        return this;
    }

    public People twitter(String twitter) {
        this.twitter = twitter;
        return this;
    }

    public People linkedin(String linkedin) {
        this.linkedin = linkedin;
        return this;
    }

    public People isTeamLeader(Boolean isTeamLeader) {
        this.isTeamLeader = isTeamLeader;
        return this;
    }

    public People interests(String[] interests) {
        this.interests = interests;
        return this;
    }

    public People specialties(String[] specialties) {
        this.specialties = specialties;
        return this;
    }

    public People socials(String[] socials) {
        this.socials = socials;
        return this;
    }

    public People languages(String[] languages) {
        this.languages = languages;
        return this;
    }

    // @Override
   // public boolean equals(Object o) {
    //    if (o == this)
     //       return true;
    //   if (!(o instanceof People)) {
     //       return false;
     //   }
     //   People people = (People) o;
     //   return Objects.equals(name, people.name) && Objects.equals(surname, people.surname) && Objects.equals(email, people.email) && Objects.equals(password, people.password) && age == people.age && Objects.equals(location, people.location) && Objects.equals(gender, people.gender) && Objects.equals(facebook, people.facebook) && Objects.equals(instagram, people.instagram) && Objects.equals(twitter, people.twitter) && Objects.equals(linkedin, people.linkedin) && Objects.equals(isTeamLeader, people.isTeamLeader) && Objects.equals(portfolio, people.portfolio) && Objects.equals(picture, people.picture) && Objects.equals(interests, people.interests) && Objects.equals(specialties, people.specialties) && Objects.equals(socials, people.socials) && Objects.equals(languages, people.languages);
    // }

    // @Override
    // public int hashCode() {
   //     return Objects.hash(name, surname, email, password, age, location, gender, facebook, instagram, twitter, linkedin, isTeamLeader, portfolio, picture, interests, specialties, socials, languages);
   // }

    @Override
    public String toString() {
        return "{" +
            " name='" + getName() + "'" +
            ", surname='" + getSurname() + "'" +
            ", email='" + getEmail() + "'" +
            ", password='" + getPassword() + "'" +
            ", age='" + getAge() + "'" +
            ", location='" + getLocation() + "'" +
            ", gender='" + getGender() + "'" +
            ", facebook='" + getFacebook() + "'" +
            ", instagram='" + getInstagram() + "'" +
            ", twitter='" + getTwitter() + "'" +
            ", linkedin='" + getLinkedin() + "'" +
            ", isTeamLeader='" + isIsTeamLeader() + "'" +
            ", interests='" + getInterests() + "'" +
            ", specialties='" + getSpecialties() + "'" +
            ", socials='" + getSocials() + "'" +
            ", languages='" + getLanguages() + "'" +
            "}";
    }

    public String getFacebook() {
        return this.facebook;
    }

    public void setFacebook(String facebook) {
        this.facebook = facebook;
    }

    public String getInstagram() {
        return this.instagram;
    }

    public void setInstagram(String instagram) {
        this.instagram = instagram;
    }

    public String getTwitter() {
        return this.twitter;
    }

    public void setTwitter(String twitter) {
        this.twitter = twitter;
    }

    public String getLinkedin() {
        return this.linkedin;
    }

    public void setLinkedin(String linkedin) {
        this.linkedin = linkedin;
    }

    public void setName(String name) {
        this.name = name;
    }
    public void setSurname(String surname) {
        this.surname = surname;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public int getAge() {
        return this.age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getLocation() {
        return this.location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getGender() {
        return this.gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String[] getInterests() {
        return this.interests;
    }

    public void setInterests(String[] interests) {
        this.interests = interests;
    }

    public String[] getSpecialties() {
        return this.specialties;
    }

    public void setSpecialties(String[] specialties) {
        this.specialties = specialties;
    }

    public String[] getSocials() {
        return this.socials;
    }

    public void setSocials(String[] socials) {
        this.socials = socials;
    }

    public String[] getLanguages() {
        return this.languages;
    }

    public void setLanguages(String[] languages) {
        this.languages = languages;
    }
  

    public People(String name, String surname, String email, String password){
        this.name=name;
        this.surname=surname;
        this.email=email;
        this.password=password;
		this.id = 0;
    }

    public People(String name, String surname, String email, String password,int age,String location,String gender,String occupation,String education,String[] interests,String[] specialties, String[]  socials, String[]  languages){
        this.name = name;
        this.surname = surname;
        this.email = email;
        this.password = password;
        this.age = age;
        this.location =location;
        this.gender = gender;
		setIsTeamLeader(false);
		this.education = education;
		this.occupation = occupation;
        this.interests = interests;
        this.specialties = specialties;
        this.socials = socials;
        this.languages = languages;
		this.id = 0;
    }
    public String getSurname(){
        return this.surname;
    }
	public void setID(int id) {
		this.id = id;
	}
	public int getID(){
		return this.id;
	}
    public String getEmail(){
        return this.email;
    }
    public String getName(){
        return this.name;
    }
    public String getPassword(){
        return this.password;
    }
}