<%-- 
    Document   : SurveyQuestions
    Created on : May 11, 2019, 4:56:55 PM
    Author     : Narayan
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="Model.DBConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<!-- ##### Header Area Start ##### -->
<%@ include file = "Header.jsp" %>
<div class="container" style="height: 100%;margin-top: 5px">
    <div class="top-header-content d-flex  justify-content-between">
        <div class="wrapper" style="margin-bottom: 65px;">
            <div class="content-section-area" style="padding:2px !important">
                <% if (request.getParameter("success") != null && request.getParameter("success").length() != 0) {%>
                <span class='success-message' style='background-color: red' id='hideblock'>  ${param.success}<img style='width:15px;margin-left:12px;cursor:pointer;' onclick="hideMessage();" src='img/success.png'/> </span>
                <%  }                                                   
                    String survey_id = request.getParameter("survey_id");
                    DBConnection db = new DBConnection();
                    Connection conn = db.getConnection();
                    PreparedStatement getSurvey = conn.prepareStatement("select * from survey_section where survey_level_id=" + survey_id + " ");
                    ResultSet survey = getSurvey.executeQuery();
                    String survey_level = "";
                    Integer questionCount = 0;
                    PreparedStatement questions = conn.prepareStatement("select * from questions where quiz_id=" + survey_id + "  and question_type='Survey' order by id ");
                    ResultSet collection = questions.executeQuery();
                    while(collection.next()){
                    questionCount++;
                    }
                    while (survey.next()) {
                        survey_level = survey.getString("section_name");
                    }
                    PreparedStatement getQuestion = conn.prepareStatement("select * from questions where quiz_id=" + survey_id + "  and question_type='Survey' order by id ");
                    ResultSet questionCollection = getQuestion.executeQuery();
                  
                  
                    String question_title = "";
                    String question_id = "";
                    Integer counter = 1;   
                %>
                
                   <div class="form1">
                       <h3>Survey <%=survey_id%></h3>
                    <form style='margin-top:5px' method="post" id="formid" autocomplete="off" action="AddUserSurvey">
                        <input type="hidden" name="survey_id" value="<%=survey_id%>"/>
                        
                      <% 
                        Integer textansCounter = 0;
                        Integer numberOfMultipleQuestion = 0;
                        Integer radioname = 1;
                        while (questionCollection.next()) {
                        question_title = questionCollection.getString("question_text");
                        question_id = questionCollection.getString("id");
                      %>                                            
                        <div class="question-box">
                           
                           <span>Q.<%=counter%> <%=question_title%></span>                       
                            <%  // check query for multiple answer or single answer 
                                PreparedStatement ansType = conn.prepareStatement("select * from quiz_answer where question_id = " + question_id + "  ");
                                ResultSet answerType = ansType.executeQuery();
                                Integer ansCount = 0;
                                while (answerType.next()) {                                   
                                        ansCount++;                                    
                                }
                                if(ansCount > 0){
                                    numberOfMultipleQuestion++;
                                }
                                //
                                PreparedStatement statement = conn.prepareStatement("select * from quiz_answer where question_id = " + question_id + "  ");
                                ResultSet answerSet = statement.executeQuery();
                                Integer sn =1; %>
                                 <input type="hidden" name="question_id<%=counter%>" value="<%=question_id%>"/>   
                                <%
                                radioname++;                                  
                                while (answerSet.next()) {
                                String ansOptions = answerSet.getString("answer_type");
                                
                                %>
                            <div class="quiz-answer-row">
                                
                                <span style="display:flex;margin-left: 15px;">
                                   <% if(ansCount >1 && ansOptions.equals("survey_checkbox")) { %> 
                                   <input type="checkbox" name="checkboxAnswer<%=sn%><%=counter%>" value="checkboxAnswer<%=sn%><%=counter%>"/>
                                   <span style="margin-right: 20px;margin-top:6px;"> <%= answerSet.getString("answer_text")%></span>
                                   <% }else if(ansCount >1 && ansOptions.equals("survey_radio")) { %> 
                                   <input style='margin-top: 11px;margin-right: 10px;height:25px;width:25px;' type="radio" name="radio<%=counter%>" value="radioAnswer<%=sn%><%=counter%>"/> 
                                  <span style="margin-right: 20px;margin-top:10px;"> <%= answerSet.getString("answer_text")%></span>
                                   <%}%>
                                    
                                   <input style="border:none" type="hidden" value="<%=answerSet.getString("id")%>" name="answer_id<%=sn%><%=counter%>"/>
                                   
                                </span>                                      
                            </div>                                       
                        <% sn++;
                        }counter++; 
                        if(ansCount == 0) {
                        textansCounter++;
                        %>
                        <div class="quiz-answer-row">
                                <span style="display:flex;margin-left:15px;">                                    
                                  
                                   <input type="hidden" name="textans_question_id<%=textansCounter%>" value="<%=question_id%>"/>
                                  <input type="text" value="" name="survey_text_ans<%=textansCounter%>"/>   
                                </span>                                      
                            </div>
                        <%}%>
                        </div>
                        <% } // question loop end here %>     
                          <input type="hidden" name="numberOfMultipleQuestion" value="<%=numberOfMultipleQuestion%>"/>
                          <input type="hidden" name="textanswer" value="<%=textansCounter%>"/> 
                          <% if(questionCount > 0){ %>
                          <button class="signup-bottom" type='submit' name='submit' value=''>Submit Survey</button>
                      <% } %>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file = "Footer.jsp" %>

