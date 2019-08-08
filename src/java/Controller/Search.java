
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author English
 */
@WebServlet(name = "Search", urlPatterns = {"/Search"})
public class Search extends HttpServlet {

    

 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
     
        if(request.getParameter("survey") != null && request.getParameter("survey").equals("search_survey")){
            if(request.getParameter("username")!=null && request.getParameter("username").length() > 0){
                 String quizName = request.getParameter("username");
                 response.sendRedirect("SurveyResult.jsp?USERNAME="+quizName); 
             }else{
                 response.sendRedirect("SurveyResult.jsp"); 
             }
        }else{
             if(request.getParameter("quiz_name")!=null && request.getParameter("quiz_name").length() > 0){
                 String quizName = request.getParameter("quiz_name");
                 response.sendRedirect("QuizResult.jsp?quiz_name="+quizName); 
             }else{
                 response.sendRedirect("QuizResult.jsp"); 
             }
        }
       
         
                
    }

   

}
