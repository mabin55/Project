
package Controller;

import Model.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "AddUserSurvey", urlPatterns = {"/AddUserSurvey"})
public class AddUserSurvey extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            String survey_id = request.getParameter("survey_id"); 
            Random RANDOM = new SecureRandom();
            String letters = "abcdefghjkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ";
            String token = "";
            for (int i=0; i<10; i++)
                {   int index = (int)(RANDOM.nextDouble()*letters.length());
                            token += letters.substring(index, index+1);
                }
   try {
            HttpSession session = request.getSession();
            Timestamp currentTime = new Timestamp(System.currentTimeMillis());
            DBConnection db = new DBConnection();
            Connection conn = db.getConnection();
            String UserId = (String)session.getAttribute("userId") ;           
            Integer textanswer = Integer.parseInt(request.getParameter("textanswer"));
            Integer multiple_Q = Integer.parseInt(request.getParameter("numberOfMultipleQuestion"));
            String message = "";
                     //   insert survey text answers                
                     if(textanswer!=null && textanswer > 0){                             
                            for (int i = 1; i <= textanswer; i++) {                             
                            String question_id = request.getParameter("textans_question_id"+i);                           
                            String anstext = request.getParameter("survey_text_ans"+i);
                            if(anstext!=null && anstext.length() >0){
                            PreparedStatement answerStatement = conn.prepareStatement("Insert into user_answers(id,quiz_id,question_id,text_answer,token,created_date) values(" +UserId+ "," +survey_id+ "," + question_id +",'" + anstext + "','"+token+"','" + currentTime + "')");
                            answerStatement.executeUpdate();
                            message = "Insert into user_answers(id,quiz_id,question_id,text_answer,token,created_date) values(" +UserId+ "," +survey_id+ "," + question_id +",'" + anstext + "','"+token+"','" + currentTime + "')";
                              }
                             }
                            }
                         
                       
                     if(multiple_Q!=null && multiple_Q > 0){ 
                         String ansId ="";
                         String question_id = "";
                         String distinct_question_id = "";
                         PreparedStatement getQ_Id = conn.prepareStatement("select distinct a.id,a.QUESTION_TYPE,b.ANSWER_TYPE from questions a \n" +
                            "join quiz_answer b\n" +
                            "on a.ID = b.question_id\n" +
                            "and a.question_type = 'Survey' and b.ANSWER_TYPE in ('survey_radio','survey_checkbox')\n" +
                            " \n" +
                            " order by a.id");
                         ResultSet Q_Id_collection = getQ_Id.executeQuery();
                         while(Q_Id_collection.next()){                            
                         distinct_question_id = Q_Id_collection.getString("id");
                         for (int i = 1; i <= 10; i++) {
                         question_id = request.getParameter("question_id"+i);
                         if(distinct_question_id.equals(question_id)){
                         for (int j = 1; j <= 4; j++) {                         
                         boolean checkBoxType = request.getParameter("checkboxAnswer"+j+i) !=null;  
                         boolean radioType = request.getParameter("radio"+i) !=null;                          
                         String currentRadioVal = request.getParameter("radio"+i) ;                        
                        
                        if(checkBoxType){
                        ansId = request.getParameter("answer_id"+j+i);
                        PreparedStatement answerStatement = conn.prepareStatement("Insert into user_answers(id,quiz_id,question_id,user_answer_id,text_answer,token,created_date) values(" +UserId+ "," +survey_id+ "," + distinct_question_id +"," + ansId + ",'Surveycheckboxoption','" + token + "','" + currentTime + "')");
                        answerStatement.executeUpdate(); 
                        }
                        if(radioType && currentRadioVal.equals("radioAnswer"+j+i)){
                        ansId = request.getParameter("answer_id"+j+i);
                        PreparedStatement answerStatement = conn.prepareStatement("Insert into user_answers(id,quiz_id,question_id,user_answer_id,text_answer,token,created_date) values(" +UserId+ "," +survey_id+ "," + distinct_question_id +"," + ansId + ",'Surveyradiooption','" + token + "','" + currentTime + "')");
                        answerStatement.executeUpdate(); 
                              }
                             }
                            }
                          }
                        }                        
                       }
        response.sendRedirect("survey.jsp?success=Survey "+survey_id+" submitted Successfully");                 
                   
        } catch (Exception e) {           
            String message = "Operation Failed!!!";
            response.sendRedirect("survey.jsp?success="+message);
         }
    }

}
