
package Controller;

import Model.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AddQuestion", urlPatterns = {"/AddQuestion"})
public class AddQuestion extends HttpServlet {   

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {         
            DBConnection db = new DBConnection();
            Connection conn = db.getConnection();
            String levelId = request.getParameter("levelId");
            String quiz_id = request.getParameter("quiz_id");
          
            
            // this is for edit option
            if (request.getParameter("questionId") != null) {

                String questionId = request.getParameter("questionId");
                String question = request.getParameter("question");
                PreparedStatement statement = conn.prepareStatement("update Questions set question_text='" + question + "' where id=" + questionId + " ");
                statement.executeUpdate();
                PreparedStatement del = conn.prepareStatement("Delete from quiz_answer Where question_id=" + questionId + " ");
                del.executeUpdate();
                for (int i = 1; i <= 4; i++) {
                    String ans = request.getParameter("answer" + i);
                    boolean correctAns = request.getParameter("correctAnswer" + i) != null;
                    PreparedStatement answerStatement = conn.prepareStatement("Insert into quiz_answer(question_id,answer_text,answer_yn) "
                            + "values(" + questionId + ",'" + ans + "'," + correctAns + ")");
                    answerStatement.executeUpdate();
                }
                String message = "Update Successfully";
                response.sendRedirect("DisplayQuestionAnswers.jsp?success=" + message + "&LevelId=" + levelId + "&quiz_id=" + quiz_id);
            // this is for add option
            } else {
                if(request.getParameter("question").length() > 0 && request.getParameter("question") !=null){                         
                String question = request.getParameter("question");
                PreparedStatement statement = conn.prepareStatement("Insert into Questions(quiz_id,question_text,question_type) values(" + quiz_id + ",'" + question + "','Quiz')");
                statement.executeUpdate();
                int currentQuestionID = 0;
                PreparedStatement getId = conn.prepareStatement("SELECT id FROM Questions ORDER BY id DESC fetch first 1 rows only");
                ResultSet rs2 = getId.executeQuery();
                while (rs2.next()) {
                    currentQuestionID = rs2.getInt(1);
                }
                for (int i = 1; i <= 4; i++) {
                    String ans = request.getParameter("answer" + i);
                    boolean correctAns = request.getParameter("correctAnswer" + i) != null;
                    PreparedStatement answerStatement = conn.prepareStatement("Insert into quiz_answer(question_id,answer_text,answer_yn) "
                            + "values(" + currentQuestionID + ",'" + ans + "'," + correctAns + ")");
                    answerStatement.executeUpdate();
                    System.out.println("Question answer insertion success");
                }
                String message = "Question Added successfully";
                response.sendRedirect("DisplayQuestionAnswers.jsp?success=" + message + "&LevelId=" + levelId + "&quiz_id=" + quiz_id);
              }else{
                String message = "Please enter question text"; 
                 response.sendRedirect("QuestionSetup.jsp?success=" + message + "&LevelId=" + levelId + "&quiz_id=" + quiz_id);
                }
             }

        } catch (Exception error) {
            String message = "Operation Failed!";
            response.sendRedirect("DisplayQuestionAnswers.jsp?success=" + message);
            System.out.println("Error in Database Connection: " + error);
        }
    }

}