
package Controller;

public class SessionSetter {
    String username, user_type, user_email;
    Integer user_id;
    // setter method
    public void setName(String username){
        this.username = username;
    }
    public void setEmail(String email){
        this.user_email = email;
    }
    public void setUserType(String type){
        this.user_type = type;
    }
    public void setUserId(Integer id){
        this.user_id = id;
    }
    //getter method
    public String getName(){
        return this.username;
    }
    public String getEmail(){
       return this.user_email ;
    }
    public String getUserType(){
        return this.user_type;
    }
    public Integer getUserId(){
        return this.user_id ;
    }
    
    public void removeSession(){
        this.username = "";
        this.user_email = "";
        this.user_type = "";
        this.user_id = null;
    }
}
