<%-- 
    Document   : DisplaySurveySections
    Created on : May 11, 2019, 2:55:39 PM
    Author     : kundan Singh
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="Model.DBConnection"%>

<!-- ##### Header Area Start ##### -->
<%@ include file = "Header.jsp" %>
<script language="javascript" type="text/javascript">
  function hideMessage(){
             var x = document.getElementById("hideblock");
             x.style.display = "none";
             }
    </script>
<div class="container" style="height: 100%;margin-top: 5px">
    <div class="top-header-content d-flex  justify-content-between">
        <div class="wrapper" style="margin-bottom: 65px;">
            <div class="content-section-area" style="padding:2px !important">

                    <%
                        String quiz_id = request.getParameter("quiz_id");
                        //String LevelId = request.getParameter("LevelId");
                        DBConnection db = new DBConnection();
                        Connection conn = db.getConnection();
                        
                        PreparedStatement Section_name = conn.prepareStatement("select * from survey_section where survey_level_id=" + quiz_id + " ");
                        ResultSet surveySet = Section_name.executeQuery();
                        String survey_title = "";
                        while (surveySet.next()) {
                            survey_title = surveySet.getString("section_name");
                        }
                        
                        try {%>
                       
                            <% if (request.getParameter("success") != null && request.getParameter("success").length() !=0){%>
                               <span class='success-message' id='hideblock'>  ${param.success}<img style='width:15px;margin-left:12px;cursor:pointer;' onclick="hideMessage();" src='img/success.png'/> </span>
                          <%  }   %>
                         <div class="question-top-header-box">
                        <span>
                            <h5><%=survey_title%> Questions/Answers</h5>
                            
                        </span>
                        <span class="add-question-span"><a href="SurveyQuestions.jsp?quiz_id=${param.quiz_id}&option=add"  class="add-question-button">Add Question</a></span>
                    </div>
                    
                   
                    
                    <%
                        PreparedStatement stat = conn.prepareStatement("select * from questions where  question_type='Survey' and quiz_id=" + quiz_id + " order by id desc ");
                        ResultSet questionSet = stat.executeQuery();
                        Integer Counter = 1;
                        while (questionSet.next()) {
                            String questionId = questionSet.getString("id");
                    %>  
                    <div class="question-box">
                        <span><%=Counter%>. &nbsp;
                            <%  if (questionSet.getString("question_text") != null && questionSet.getString("question_text").length() !=0) {%>
                                <%=questionSet.getString("question_text")%> ?
                           <% }%>                           
                        </span>
                    
                 
                    <%

                        PreparedStatement statement = conn.prepareStatement("select * from quiz_answer where question_id = " + questionId + " ");
                        ResultSet answerSet = statement.executeQuery();
                        while (answerSet.next()) {
                            //String correctAnswer = answerSet.getString("answer_yn");
                    %>
                     <div class="answer-container">
                        <span style="margin-right: 20px;"> <%= answerSet.getString("answer_text")%></span>
                        <span>
                            <% if (answerSet.getString("answer_text") != null && answerSet.getString("answer_text").length() !=0) {%>
                             <% if ("true".equals(answerSet.getString("answer_yn"))) {%>  
                            <img style="opacity:0.5;" src='img/correct.jpg' />
                            <%}else{
                            if("survey_text_answer".equals(answerSet.getString("answer_type"))){%>                           
                            <%  }else{%>
                             <img style="opacity:0.5;" src='img/incorrect.jpg' />
                            <%}
                            }%>
                            
                            <%}else{%>
                            <span style='margin-left: -23px;'>Answer not available</span>
                            <%}%>
                           
                        </span>
                    </div>
                     

                    <% } %>                     
                    <span style='margin-left: 23px;margin-top: 10px;'>
                        <span class="edit-button "><a href="SurveyQuestions.jsp?quiz_id=<%=quiz_id%>&questionId=<%=questionId%>">Edit</a></span>
                        <span class="delete-button"><a href="DeleteSurvey?questionId=<%=questionId%>&quiz_id=<%=quiz_id%>">Delete</a></span>
                    </span>
                    </div>
                    <% 
                            Counter++;
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }%>


                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file = "Footer.jsp" %>
