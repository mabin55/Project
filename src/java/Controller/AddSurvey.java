package Controller;

import Model.DBConnection;
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

@WebServlet(name = "AddSurvey", urlPatterns = {"/AddSurvey"})
public class AddSurvey extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            
            DBConnection db = new DBConnection();
            Connection conn = db.getConnection();
            //String LevelId = request.getParameter("levelId");
            String quiz_id = request.getParameter("quiz_id");
            // this is for edit option
            if (request.getParameter("questionId") != null) {

                String questionId = request.getParameter("questionId");
                String question = request.getParameter("question");
                PreparedStatement statement = conn.prepareStatement("update Questions set question_text='" + question + "' where id=" + questionId + " ");
                statement.executeUpdate();
                int currentQuestionID = 0;
                PreparedStatement del = conn.prepareStatement("Delete from quiz_answer Where question_id=" + questionId + " ");
                del.executeUpdate();
                 //make entry for answers options
                if (request.getParameter("survey_checkbox").equals("edit")) {
                    for (int i = 1; i <= 4; i++) {
                    String ans = request.getParameter("checkboxOption" + i);
                    boolean correctAns = request.getParameter("chk_answer" + i) != null;
                   if(ans.length() > 0){
                       PreparedStatement answerStatement = conn.prepareStatement("Insert into quiz_answer(question_id,answer_text,answer_yn,answer_type) "
                            + "values(" + questionId + ",'" + ans + "'," + correctAns + ",'survey_checkbox')");
                        answerStatement.executeUpdate();
                        System.out.println("Survey answer insertion success");
                   }                    
                  }
                }
                if (request.getParameter("survey_radio").equals("edit")) {
                     for (int i = 1; i <= 4; i++) {
                    String ans = request.getParameter("radioOption" + i);
                    boolean correctAns = false;
                    String currentVal = "radio_answer"+i;
                    String radioButton = request.getParameter("radio");
                     if (currentVal.equals(radioButton)) {
                     correctAns = true;
                        } 
                   if(ans.length() > 0){
                       PreparedStatement answerStatement = conn.prepareStatement("Insert into quiz_answer(question_id,answer_text,answer_yn,answer_type) "
                            + "values(" + questionId + ",'" + ans + "'," + correctAns + ",'survey_radio')");
                        answerStatement.executeUpdate();
                        System.out.println("Survey answer insertion success");
                   }                    
                  }
                }
                if (request.getParameter("survey_text").equals("edit") && request.getParameter("survey_text_answer")!=null) {
                       String ans = request.getParameter("survey_text_answer");  
                       boolean status = false;
                       if(ans.length() > 0){
                       PreparedStatement answerStatement = conn.prepareStatement("Insert into quiz_answer(question_id,answer_text,answer_yn,answer_type) "
                            + "values(" + questionId + ",'" + ans + "','"+status+"','survey_text_answer')");
                        answerStatement.executeUpdate();
                        System.out.println("Survey answer insertion success");
                       }
                }
                
                String message = "Update Successfully";
                response.sendRedirect("DisplaySurveySections.jsp?success=" + message + "&questionId=" + questionId + "&quiz_id=" + quiz_id);
            // this is for add option
            } else {
                if(request.getParameter("question") !=null && request.getParameter("question").length()>0){
                String question = request.getParameter("question");
                PreparedStatement statement = conn.prepareStatement("Insert into Questions(quiz_id,question_text,question_type) values(" + quiz_id + ",'" + question + "','Survey')");
                statement.executeUpdate();
                int currentQuestionID = 0;
                PreparedStatement getId = conn.prepareStatement("SELECT id FROM Questions ORDER BY id DESC fetch first 1 rows only");
                ResultSet rs2 = getId.executeQuery();
                while (rs2.next()) {
                    currentQuestionID = rs2.getInt(1);
                }
                //make entry for answers options
                if (request.getParameter("survey_checkbox").equals("add") && request.getParameter("survey_checkbox") !=null) {
                    for (int i = 1; i <= 4; i++) {
                    String ans = request.getParameter("checkboxOption" + i);
                    boolean correctAns = request.getParameter("chk_answer" + i) != null;
                   if(ans.length() > 0){
                       PreparedStatement answerStatement = conn.prepareStatement("Insert into quiz_answer(question_id,answer_text,answer_yn,answer_type) "
                            + "values(" + currentQuestionID + ",'" + ans + "'," + correctAns + ",'survey_checkbox')");
                        answerStatement.executeUpdate();
                        System.out.println("Survey answer insertion success");
                   }                    
                  }
                }
                if (request.getParameter("survey_radio").equals("add") && request.getParameter("survey_radio")!=null) {
                     for (int i = 1; i <= 4; i++) {
                    String ans = request.getParameter("radioOption" + i);
                    boolean correctAns = false;
                    String currentVal = "radio_answer"+i;
                    String radioButton = request.getParameter("radio");
                     if (currentVal.equals(radioButton)) {
                     correctAns = true;
                        }                    
                   if(ans.length() > 0){
                       PreparedStatement answerStatement = conn.prepareStatement("Insert into quiz_answer(question_id,answer_text,answer_yn,answer_type) "
                            + "values(" + currentQuestionID + ",'" + ans + "'," + correctAns + ",'survey_radio')");
                        answerStatement.executeUpdate();
                        System.out.println("Survey answer insertion success");
                   }                    
                  }
                }
                if (request.getParameter("survey_text").equals("add") && request.getParameter("survey_text_answer")!=null) {
                       String ans = request.getParameter("survey_text_answer");  
                       boolean status = false;
                       if(ans.length() > 0){
                       PreparedStatement answerStatement = conn.prepareStatement("Insert into quiz_answer(question_id,answer_text,answer_yn,answer_type) "
                            + "values(" + currentQuestionID + ",'" + ans + "','"+status+"','survey_text_answer')");
                        answerStatement.executeUpdate();
                        System.out.println("Survey answer insertion success");
                       }
                }
                
                String message = "Question Added successfully";
                 response.sendRedirect("DisplaySurveySections.jsp?success=" + message + "&quiz_id=" + quiz_id);
                }else{
                String message = "Please enter question";
                response.sendRedirect("SurveyQuestions.jsp?&option=add&success=" + message + "&quiz_id=" + quiz_id);
                   
                }
              }

        } catch (Exception error) {
            String message = "Operation Failed!";
            response.sendRedirect("DisplaySurveySections.jsp?success=" + message);
            System.out.println("Error in Database Connection: " + error);
        }
    }

}
