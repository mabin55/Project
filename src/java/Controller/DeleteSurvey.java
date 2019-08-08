/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author hp
 */

@WebServlet(name = "DeleteSurvey", urlPatterns = {"/DeleteSurvey"})

public class DeleteSurvey extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String questionId = request.getParameter("questionId");
            String quiz_id = request.getParameter("quiz_id");
            //String LevelId = request.getParameter("levelId");
            DBConnection db = new DBConnection();
            db.deleteQuestionAnswers(questionId);
            String message = "Delete Successfully";
            response.sendRedirect("DisplaySurveySections.jsp?success=" + message + "&quiz_id=" + quiz_id );
        } catch (Exception e) {
            String message = "Delete Failed";
            response.sendRedirect("DisplaySurveySections.jsp?success=" + message);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
