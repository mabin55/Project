<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="Model.DBConnection"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java"%>

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
                <div class="form1" >
                    <h4>Add New Questions/Answers</h4>
                    <%
                        String questionId = "";
                        String quiz_id = quiz_id = request.getParameter("quiz_id");
                        String Question_text = "";
                        try {
                            if (request.getParameter("questionId") != null) {
                                questionId = request.getParameter("questionId");

                                DBConnection db = new DBConnection();
                                Connection conn = db.getConnection();
                                PreparedStatement editQuestion = conn.prepareStatement("select * from questions where id=" + questionId + " ");
                                ResultSet q_Set = editQuestion.executeQuery();
                                while (q_Set.next()) {
                                    Question_text = q_Set.getString("question_text");
                                }
                                PreparedStatement editAns = conn.prepareStatement("select * from quiz_answer where question_id=" + questionId + " ");
                                ResultSet answer_Set = editAns.executeQuery();
                                Integer cnt = 1;
                                while (answer_Set.next()) {
                                    request.setAttribute("answer_text" + cnt, answer_Set.getString("answer_text"));
                                    request.setAttribute("correctAnswer" + cnt, answer_Set.getString("answer_yn"));
                                    cnt++;
                                }

                            }
                    %>
                    
                <!--    <span onClick='showAnswersOption("addForm")' class="label survey-answer-options">
                    Click this link your question is Image Type
                   </span> -->
                    <% if (request.getParameter("success") != null && request.getParameter("success").length() != 0) {%>
                <span onclick="hideMessage();" style='color: red;font-weight: bold;cursor:pointer;' id='hideblock'>  ${param.success} </span>
                    <%  }%>
                    <form style="margin-top:-20px"  method="post" autocomplete="off" action="AddQuestion"  >
                        <input type="hidden" name="levelId" value="<%=request.getParameter("LevelId")%>"/> 
                        <% if (request.getParameter("questionId") != null) {%>
                        <input type="hidden" name="questionId" value="<%=questionId%>"/> 
                        <% }%>
                        <input type="hidden" name="quiz_id" value="<%=quiz_id%>"/> 
                        <div id="addHTMLContent" style="padding:5px;display: none">
                            </div>
                        
                        <div id='addForm' style='display:none'>
                          <span style='color:red;border:none;' class="label survey-answer-options" >* Browser Image and Click Upload Button to Save Image
                          </span>
                           <input type='file' name='image_question'  />  
                           <button class='pagination' type='submit' name='submit' value=''>Save Image</button>
                           <br>
                           <span onClick='hideAnswersOption("addHTMLContent")' class="label survey-answer-options">
                           Delete Image Option
                           </span>                         
                           </div>
                           <br><br>
                        
                     
                        <div> 
                            <label class="label">Enter your Question</label>
                          <input type="text" name="question" value="<%=Question_text%>" placeholder="Type your question"/>
                         
                        </div>


                        <div>  
                            <label class="label">Type your answer and Tick(&#x2714;) checkbox if this answer is correct</label>                
                            <span style="display:flex">
                                <input type="checkbox" name="correctAnswer1" 
                                       <% if ("true".equals(request.getAttribute("correctAnswer1"))) {%>  checked="checked" <%}%>
                                       value=""/>
                                <input type="text" name="answer1" value="<% if (request.getAttribute("answer_text1") != null) {%><%=request.getAttribute("answer_text1")%><%}%>" 
                                       placeholder="Answer option one"/>                       
                            </span>
                        </div>
                        <div>
                            <label class="label"></label>
                            <span style="display:flex">
                                <input type="checkbox" value="" name="correctAnswer2" <% if ("true".equals(request.getAttribute("correctAnswer2"))) {%>  checked="checked" <%}%>
                                       />
                                <input type="text" name="answer2" value="<% if (request.getAttribute("answer_text2") != null) {%><%=request.getAttribute("answer_text2")%><%}%>" placeholder="Answer option two"/>

                            </span>
                        </div>
                        <div> 
                            <label class="label"></label>
                            <span style="display:flex">
                                <input type="checkbox" name="correctAnswer3"  <% if ("true".equals(request.getAttribute("correctAnswer3"))) {%>  checked="checked" <%}%> 
                                       />
                                <input type="text" name="answer3" value="<% if (request.getAttribute("answer_text3") != null) {%><%=request.getAttribute("answer_text3")%><%}%>" placeholder="Answer option three"/>
                            </span>
                        </div>
                        <div> 
                            <label class="label"></label>
                            <span style="display:flex">
                                <input type="checkbox" name="correctAnswer4" <% if ("true".equals(request.getAttribute("correctAnswer4"))) {%>  checked="checked" <%}%> 
                                       />
                                <input type="text" name="answer4" value="<% if (request.getAttribute("answer_text4") != null) {%><%=request.getAttribute("answer_text4")%><%}%>" placeholder="Answer option four"/>

                            </span>
                        </div>

                        <button class='signup-bottom'  type="submit">
                            <% if (request.getParameter("questionId") != null) {%>Update Question/Answers<%}else{%>Add Question/Answers<%}%>
                        </button>


                    </form>
                    <%
                        } catch (Exception e) {
                            e.printStackTrace();
                        }%>

                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file = "Footer.jsp" %>

