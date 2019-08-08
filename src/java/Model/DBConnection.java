package Model;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DBConnection {

    private Connection connect = null;
    private Statement statement = null;
    private ResultSet resultSet = null;
   // HttpServletRequest request = null;

    public Connection getConnection() throws Exception {
        try {
            //Class.forName("org.apache.derby.jdbc.ClientDriver");
            connect = DriverManager.getConnection(
                    "jdbc:derby://localhost:1527/ROOT",
                    "root",
                    "root");
            // System.out.println("Connection Successfully");        
        } catch (Exception e) {
            System.out.println("Error in Database Connection: " + e);
        }
        return connect;
    }

    public boolean loginHandler( String email, String password)
            throws ServletException, IOException {
         boolean status = false;
        try {
            Connection conn = getConnection();
            PreparedStatement statement = conn.prepareStatement("SELECT * from USERS where email='" + email + "' and password='" + password + "'");
            resultSet = statement.executeQuery();
            status = resultSet.next();            
        } catch (Exception error) {
            System.out.println("Error in Database Connection: " + error);
        }
        return status;
    }

    public void deleteQuestionAnswers(String questionId) throws Exception {
        boolean status = false;
        try {
            Connection conn = getConnection();
            PreparedStatement del_q = conn.prepareStatement("Delete from questions Where id=" + questionId + " ");
            del_q.executeUpdate();
            PreparedStatement ans_del = conn.prepareStatement("Delete from quiz_answer Where question_id=" + questionId + " ");
            ans_del.executeUpdate();

        } catch (Exception e) {
            System.out.println("Error in Database Connection: " + e);
        }

    }

    public void deleteSurveyQuestions(String questionId) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
