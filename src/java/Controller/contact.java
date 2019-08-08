
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


@WebServlet(name = "contact", urlPatterns = {"/contact"})
public class contact extends HttpServlet {

     @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            DBConnection db = new DBConnection();
            Connection conn= db.getConnection();
            String username=request.getParameter("username");
            String email=request.getParameter("email");
            String message=request.getParameter("message");
            //String user_type=request.getParameter("user_type");           
         
          PreparedStatement statement=conn.prepareStatement("insert into CONTACT(USERNAME,EMAIL,MESSAGE) values('" + username + "','" + email + "','" + message + "')");
          statement.executeUpdate();
        
           String  urlmessage = "Thank you, For Sending us the Message.we will Contact you soon";
             response.sendRedirect("Contact.jsp?success="+urlmessage);
        } catch (Exception e) {
            String errormessage = "error";
                 response.sendRedirect("Contact.jsp?" + errormessage);
        }

    }

}
