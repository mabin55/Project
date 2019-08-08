<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="Model.DBConnection"%>


<!-- ##### Header Area Start ##### -->
<%@ include file = "Header.jsp" %>
<div class="container" style="height: 100%;margin-top: 5px">
    <div class="top-header-content d-flex  justify-content-between">
        <div class="wrapper" style="margin-bottom: 65px;">
            <div class="content-section-area" >
                
                 <%
                        try {
                            DBConnection db = new DBConnection();
                            Connection conn = db.getConnection();
                            PreparedStatement level = conn.prepareStatement("select * from level_name");
                            ResultSet levelSet = level.executeQuery();
                            while (levelSet.next()) {
                    %> 
                    <div>
                    <h5><%=levelSet.getString("LEVEL_DESCRIPTION")%></h5>
                     <div class="row-section">
                    <%
                        String id = levelSet.getString("id");
                        PreparedStatement statement = conn.prepareStatement("select * from quiz where level_id = " + id + " ");
                        ResultSet dataSet = statement.executeQuery();
                        while (dataSet.next()) {
                    %>
                     <div class="row-section-container">
                    <span class="text-title"
                      ><a href="DisplayQuestionAnswers.jsp?quiz_id=<%=dataSet.getString("quiz_id")%>&Level=<%=levelSet.getString("LEVEL_DESCRIPTION")%>&LevelId=<%=levelSet.getString("id")%>">
                        <%=dataSet.getString("QUIZ_QUESTION_NAME")%>
                    </a></span>
                    <span class="img-wrapper"
                      >
                        <a href="DisplayQuestionAnswers.jsp?quiz_id=<%=dataSet.getString("quiz_id")%>&Level=<%=levelSet.getString("LEVEL_DESCRIPTION")%>&LevelId=<%=levelSet.getString("id")%>">
                        <img class="img" src="img/<%=dataSet.getString("QUIZ_DESCRIPTION")%>"
                    />
                    </a>
                        </span>
                  </div>
                    
                    
                        <% }%> </div></div>
                         <%   }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }%>
           

                
                
        </div>
    </div>
</div>
<%@ include file = "Footer.jsp" %>

