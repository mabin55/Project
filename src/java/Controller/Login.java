/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.DBConnection;
import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            DBConnection db = new DBConnection();
             Connection conn = db.getConnection();
             
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            Boolean status = db.loginHandler(email, password);
            
             PreparedStatement statement = conn.prepareStatement("SELECT username,user_type,id from USERS where email='" + email + "' and password='" + password + "'");
            ResultSet resultSet = statement.executeQuery();
            status = resultSet.next();              
          
            if (status) {
               String message = "Login Success";
               String username = resultSet.getString(1); 
               String user_type = resultSet.getString(2);
               String userId = resultSet.getString(3);
               HttpSession session = request.getSession(); 
               session.setAttribute("email", String.valueOf(email));
               session.setAttribute("username", String.valueOf(username));
               session.setAttribute("user_type",String.valueOf(user_type));
               session.setAttribute("userId",String.valueOf(userId));
               response.sendRedirect("index.jsp?success=" + message);
                
            } else {
                 String message = "Invalid Email/Password !! Please try Again";
                 response.sendRedirect("Login.jsp?success=" + message);
            }
           
        } catch (Exception error) {
            System.out.println("Error in Database Connection: " + error);
        }

    }

}
