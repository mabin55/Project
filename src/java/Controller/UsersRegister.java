/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author hp
 */
@WebServlet(name = "UsersRegister", urlPatterns = {"/UsersRegister"})
public class UsersRegister extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            DBConnection db = new DBConnection();
            Connection conn= db.getConnection();
            String username=request.getParameter("username");
            String email=request.getParameter("email");
            String password=request.getParameter("password");
            //String user_type=request.getParameter("user_type");
            
         
          PreparedStatement statement=conn.prepareStatement("insert into USERS(USERNAME,EMAIL,PASSWORD,USER_TYPE) values('" + username + "','" + email + "','" + password + "','user')");
          statement.executeUpdate();
        
           String  message = "Username added successfully, Please login";
             response.sendRedirect("Login.jsp?success=" + message);
        } catch (Exception e) {
            String message = "error";
                 response.sendRedirect("Register.jsp?success=" + message);
        }

    }

}
