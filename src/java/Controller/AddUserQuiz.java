package Controller;

import Model.DBConnection;
import com.sun.xml.rpc.processor.modeler.j2ee.xml.string;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "AddUserQuiz", urlPatterns = {"/AddUserQuiz"})
public class AddUserQuiz extends HttpServlet {

      @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {  
            HttpSession session = request.getSession(); 
            String quiz_id = request.getParameter("user_quiz");
            String LevelId = request.getParameter("LevelId");
            String spageid = request.getParameter("currentpage");
            String pageType = request.getParameter("page") ; 
            String getQuestinoId = request.getParameter("questionId");
            String quizSubmit = request.getParameter("submit");
            String token= request.getParameter("token");
            int pageid =0;             
            Timestamp currentTime = new Timestamp(System.currentTimeMillis());
   try {
            DBConnection db = new DBConnection();
            Connection conn = db.getConnection();
            String UserId = (String)session.getAttribute("userId") ; 
            String message = "";
            boolean validateAns = false;
            Integer delCount = 1;
            
                     //   if(currentQuestionID.equals(getQuestinoId)){
                     if(request.getParameter("radio") !=null){
                       for (int i = 1; i <= 4; i++) {                            
                            String ansId = request.getParameter("answer_id"+i) ;
                            String currentVal = "correctAnswer"+i;
                            String radioButton = request.getParameter("radio");
                            boolean status = request.getParameter("radio") !=null;
                            if(currentVal.equals(radioButton) && status){
                            // delete once if ans already exists
                            if(delCount==1){
                            PreparedStatement delStatement = conn.prepareStatement("Delete from user_answers where quiz_id=" +quiz_id+ " and question_id=" + getQuestinoId +" "
                                    + "and id=" + UserId +" and token='" + token +"'");
                            delStatement.executeUpdate();
                            }                                                    
                            PreparedStatement answerStatement = conn.prepareStatement("Insert into user_answers(id,quiz_id,question_id,user_answer_id,token,created_date,question_level_id) values(" +UserId+ "," +quiz_id+ "," + getQuestinoId +"," + ansId + ",'" + token + "','" + currentTime + "'," + LevelId + ")");
                            answerStatement.executeUpdate();
                            validateAns = true;
                            delCount++;
                            }
                          }  
                     }else{
                         
                         for (int i = 1; i <= 4; i++) {                            
                            boolean correctAns = request.getParameter("correctAnswer"+i) != null;
                            if(correctAns){
                            // delete once if ans already exists
                            if(delCount==1){
                            PreparedStatement delStatement = conn.prepareStatement("Delete from user_answers where quiz_id=" +quiz_id+ " and question_id=" + getQuestinoId +""
                                    + "and id=" + UserId +" and token='" + token +"' ");
                            delStatement.executeUpdate();
                            }                            
                            String ansId = request.getParameter("answer_id"+i);                            
                            PreparedStatement answerStatement = conn.prepareStatement("Insert into user_answers(id,quiz_id,question_id,user_answer_id,token,created_date,question_level_id) values(" +UserId+ "," +quiz_id+ "," + getQuestinoId +"," + ansId + ",'" + token + "','" + currentTime + "'," + LevelId + ")");
                            answerStatement.executeUpdate();
                            validateAns = true;
                            delCount++;
                            }
                          }  
                     }
            if(pageType!=null  && pageType.equals("previous") ){
                    if(Integer.parseInt(spageid) > 1){
                        pageid=Integer.parseInt(spageid)-1;
                    }else{
                        pageid=Integer.parseInt(spageid);
                    } 
            }else{
                if(validateAns){               
                if(pageType!=null  && pageType.equals("next")){              
                    if(Integer.parseInt(spageid) < 10){
                        pageid=Integer.parseInt(spageid)+1;
                    }else{
                        pageid=Integer.parseInt(spageid);
                    }
                    }
                }else{
                PreparedStatement delStatement = conn.prepareStatement("Delete from user_answers where quiz_id=" +quiz_id+ " and question_id=" + getQuestinoId +" ");
                delStatement.executeUpdate();
                pageid = Integer.parseInt(spageid); 
                message = "Error: Please choose answer";
                } 
               
            }
            if( quizSubmit!=null && quizSubmit.equals("submitQuiz") && message == ""){
             response.sendRedirect("Quiz.jsp");
            }else{
             response.sendRedirect("PlayQuiz.jsp?success=" + message + "&LevelId=" + LevelId + "&quiz_id=" + quiz_id+"&currentpage=" + pageid+"&page="+pageType+"&quizToken="+token );   
            }           
 
        } catch (Exception e) {           
            String message = "Operation Failed!!!";
            response.sendRedirect("PlayQuiz.jsp?success=" + message + "&LevelId=" + LevelId + "&quiz_id=" + quiz_id+"&currentpage=" + pageid+"&page="+pageType+"&quizToken="+token );
         }
    }

}

