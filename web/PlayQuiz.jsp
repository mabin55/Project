<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="Model.DBConnection"%>
<!-- ##### Header Area Start ##### -->
<%@ include file = "Header.jsp" %>
<script language="javascript" type="text/javascript">
    function hideMessage() {
        var x = document.getElementById("hideblock");
        x.style.display = "none";
    }  
</script>
<div class="container" style="height: 100%;margin-top: 5px">
    <div class="top-header-content d-flex  justify-content-between">
        <div class="wrapper" style="margin-bottom: 65px;">
            <div class="content-section-area" style="padding:2px !important">
                <%   
                    String token = "";
                    if(request.getParameter("quizToken")!=null){
                        token = request.getParameter("quizToken");
                    }
                    Integer pageSize = 0;
                    String quiz_id = request.getParameter("quiz_id");
                    String LevelId = request.getParameter("LevelId");
                    DBConnection db = new DBConnection();
                    Connection conn = db.getConnection();
                    String pageid=request.getParameter("currentpage");  
                    PreparedStatement pagination = conn.prepareStatement(""
                                    + "select * from questions where quiz_id=" + quiz_id + " and question_type ='Quiz'");
                    ResultSet questionCount = pagination.executeQuery();
                    while(questionCount.next()){
                        pageSize++;
                    }
                    PreparedStatement level = conn.prepareStatement("select * from level_name where id=" + LevelId + " ");
                    ResultSet getLevel = level.executeQuery();
                    String level_description = "";
                    while (getLevel.next()) {
                        level_description = getLevel.getString("level_description");
                    }
                    PreparedStatement quiz_title = conn.prepareStatement("select * from quiz where quiz_id=" + quiz_id + " ");
                    ResultSet getQuiz_Title = quiz_title.executeQuery();
                    String quiz_titles = "";
                    while (getQuiz_Title.next()) {
                        quiz_titles = getQuiz_Title.getString("quiz_question_name");
                      }
              
                %>
                <% if (request.getParameter("success") != null && request.getParameter("success").length() != 0) {%>
                <span onclick="hideMessage();" style='margin-left: 15px;color: red;font-weight: bold;cursor:pointer;' id='hideblock'>  ${param.success} </span>
                    <%  }%>
                   
                <div class="question-top-header-box">
                    <span>
                        <h5><%=level_description%> Questions</h5>
                        <h6><%=quiz_titles%></h6>
                    </span>
                </div>
                <div class="form1">
                    <form style='margin-top:5px' method="post" id="formid" autocomplete="off" action="AddUserQuiz">
                        <input type="hidden" name="user_quiz" value="<%=quiz_id%>"/>
                        <input type="hidden" name="LevelId" value="<%=LevelId%>"/>
                        <input type="hidden" name="currentpage" value="<%=pageid%>"/>
                        <input type="hidden" name="token" value="<%=token%>"/>
                        
                        <%  String userAnsId = ""; 
                            int offsetvalue = Integer.parseInt(pageid)-1;
                            PreparedStatement stat = conn.prepareStatement(""
                                    + "select * from questions where quiz_id=" + quiz_id + " and question_type ='Quiz' "
                                    + "order by id desc OFFSET "+offsetvalue+" ROWS FETCH NEXT 1 ROWS ONLY");
                            ResultSet questionSet = stat.executeQuery();
                            String questionId ="";                            
                            while (questionSet.next()) { // question loop start here
                                Integer Counter = 1;
                                questionId = questionSet.getString("id");
                        %>  
                        <div class="question-box">
                            <span>Q.<%=pageid%> &nbsp;
                                <% if (questionSet.getString("question_text") != null && questionSet.getString("question_text").length() != 0) {%>
                                <%=questionSet.getString("question_text")%> ?
                                <% }%>                           
                            </span>
                            <input type="hidden" name="questionId" value="<%= questionId%>"/>
                            <%  // check query for multiple answer or single answer 
                                PreparedStatement ansType = conn.prepareStatement("select * from quiz_answer where question_id = " + questionId + "  ");
                                ResultSet answerType = ansType.executeQuery();
                                Integer ansCount = 0;
                                while (answerType.next()) {
                                    if(answerType.getString("answer_yn").equals("true")){
                                        ansCount++;
                                    }
                                }
                                //
                                PreparedStatement statement = conn.prepareStatement("select * from quiz_answer where question_id = " + questionId + "  ");
                                ResultSet answerSet = statement.executeQuery();
                                while (answerSet.next()) {
                                 // check query if answer is already insert into DB by user or not 
                                PreparedStatement ans = conn.prepareStatement("select * from user_answers where question_id = " + questionId + " and "
                                        + "user_answer_id = " + answerSet.getString("id") + " and token ='" + token + "'");
                                ResultSet ansSet = ans.executeQuery();
                                // check query end here
                                
                                while (ansSet.next()) {
                                 userAnsId = ansSet.getString("user_answer_id");
                                } 
                                                             
                                //String correctAnswer = answerSet.getString("answer_yn");%>
                            <div class="quiz-answer-row">                                                                                  
                                <span style="display:flex;margin-left: 20px;">
                                   <% if(ansCount >1) {%> 
                                   <input type="checkbox" <% if(userAnsId !=null && userAnsId.equals(answerSet.getString("id"))){%>
                                           checked="checked"<%}%> 
                                    name="correctAnswer<%=Counter%>" value=""/> 
                                   <%}if(ansCount == 1){ %>
                                   <input type="hidden" name="radio_ansId<%=Counter%>" value="<%=answerSet.getString("id")%>"/> 
                                  <input style='margin-top: 11px;margin-right: 10px;height:25px;width:25px;' type="radio" <% if(userAnsId !=null && userAnsId.equals(answerSet.getString("id"))){%>
                                           checked="checked"<%}%> 
                                    name="radio" value="correctAnswer<%=Counter%>"/> 
                                   <% }%>
                                    <span style="margin-right: 20px;margin-top:10px;"> <%= answerSet.getString("answer_text")%></span> 
                                    <input style="border:none" type="hidden" value="<%=answerSet.getString("id")%>" name="answer_id<%=Counter%>"/>  
                                </span>                                      
                            </div>
                            <% Counter++; }  %>                   
                        </div>
                        
                        <% } // question loop end here %> 
                     <%   if(pageSize>0){%> 
                        <div style='margin-left:30px;'>                            
                        <button class='pagination'<% if(Integer.parseInt(pageid) == 1 ){%> style='background-color:grey' disabled<%}%> type='submit' name='page' value='previous'>Previous</button>
                        <button class='pagination'<% if(Integer.parseInt(pageid) == pageSize ){%>style='background-color:grey' disabled<%}%> type='submit' name='page' value='next'>Next</button>
                          <% if(Integer.parseInt(pageid) == pageSize ){%>
                          <button class='pagination' type='submit' name='submit' value='submitQuiz'>Submit</button>
                        </div>
                           <%} }%> 
                    <%// } catch(Exception e) {  e.printStackTrace();  }%>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file = "Footer.jsp" %>

