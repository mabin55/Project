<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="Model.DBConnection"%>

<!-- ##### Header Area Start ##### -->
<%@ include file = "Header.jsp" %>
<div class="container" style="height: 100%;margin-top: 5px">
    <div class="top-header-content d-flex  justify-content-between">
        <div class="wrapper" style="margin-bottom: 65px;">
            <div class="content-section-area" style="padding:2px !important">
                <div class="form" style="padding:1px">
                    <h4> Welcome to Survey !! please take part in any Survey you like. </h4>

                     <% if (request.getParameter("success") != null && request.getParameter("success").length() !=0){%>
                               <span style='margin-left:5px;' class='success-message' id='hideblock'>  ${param.success}<img style='height:7px;width:7px;margin-left:10px;cursor:pointer;' onclick="hideMessage();" src='img/success.png'/> </span>
                          <%  }   %>
                    <%
                        try {
                            DBConnection db = new DBConnection();
                            Connection conn = db.getConnection();
                            PreparedStatement statement = conn.prepareStatement("SELECT * from SURVEY_SECTION");
                            ResultSet resultSet = statement.executeQuery();
                            while (resultSet.next()) {%>      
                            <div style='width:310px;display:flex;flex-wrap: wrap;padding:5px;border-bottom:1px solid #7a7aff;color:#A0F0ED;font-size: 20px;font-weight: Menlo, Monaco, Consolas, Liberation Mono, Courier New, monospace;'> 
                                <img style='height:35px;margin-right:5px;' src='img/page.png'/>
                                 <% String userType=(String)session.getAttribute("user_type");
                                     if(userType!=null && userType.equals("admin")){ 
                                  %>
                                <span class="add-question-span">                                
                                <a class="add-question-button" href="DisplaySurveySections.jsp?quiz_id=<%=resultSet.getString("SURVEY_LEVEL_ID")%>">
                                    SetUp <%=resultSet.getString("SECTION_NAME")%>
                                </a>
                                </span>
                                <%}%>
                                 <span style="margin-left:5px;float:right" class="add-question-span">
                                 <a class="add-question-button" href="PlaySurvey.jsp?survey_id=<%=resultSet.getString("SURVEY_LEVEL_ID")%>">
                                    Go To <%=resultSet.getString("SECTION_NAME")%>
                                </a>
                                 </span>
                            </div>
                               
                    <% }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }%>


                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file = "Footer.jsp" %>
