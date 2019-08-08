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
                <% if ("add".equals(request.getParameter("option"))) { %>
               <div style='padding:5px;'>
                <span class="label">a)</span>
                <span onClick='showAnswersOption("checkboxOptions")' class="label survey-answer-options">
                    Multiple answers from multiple options
                </span>
                <span class="label">b)</span>
                <span onClick='showAnswersOption("radioButtonOptions")' class="label survey-answer-options">
                    Single answer from multiple options
                </span>
            <!--    <span class="label">c)</span>
                <span onClick='showAnswersOption("inputTextOptions")' class="label survey-answer-options">
                    Single in text format
                </span>-->
            </div>
               <%}%>
                <div class="form1" >
                    <h4>Add New Questions/Answers</h4>
                    <%
                        String questionId = "";
                        String quiz_id = request.getParameter("quiz_id");
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
                                    request.setAttribute("ansType", answer_Set.getString("answer_type"));
                                    cnt++;
                                }

                            }
                    %>
                  
                           <% if (request.getParameter("success") != null && request.getParameter("success").length() != 0) {%>
                <span onclick="hideMessage();" style='color: red;font-weight: bold;cursor:pointer;' id='hideblock'>  ${param.success} </span>
                    <%  }%>              
                     
                        <form style='margin-top:5px' method="post" autocomplete="off" action="AddSurvey">
                        <input type="hidden" name="quiz_id" value="<%=request.getParameter("quiz_id")%>"/> 
                        <% if (request.getParameter("questionId") != null) {%>
                        <input type="hidden" name="questionId" value="<%=questionId%>"/> 
                        <% }%>
                   
                        <div> 
                            <label class="label">Questions:</label>
                            <input type="text" name="question" value="<%=Question_text%>" placeholder="Type your question"/>
                        </div>
                        <!-- multiple option answer start here -->
                        <!--HTML Content Replace start here -->
                                <div id="addHTMLContent" style="padding:5px;display: none;">
                                </div>
                                <!--HTML Content Replace end here -->
                               <!--checkbox start here -->
                                <div id="checkboxOptions" 
                                     <% if (request.getParameter("questionId") != null && request.getAttribute("ansType").equals("survey_checkbox")) {}else{%>
                                     style="padding:5px;display: none;" <%}%>>
                                    <% if (request.getParameter("questionId") == null) { %>
                                        <div class="delete-survey-options" onClick='hideAnswersOption("addHTMLContent")'>
                                                Delete Options
                                            </div>
                                        <% }%>
                                    <% if (request.getParameter("questionId") != null) { %>
                                     <input type="hidden" name="survey_checkbox" value="edit"  />
                                    <% }else{%>
                                     <input type="hidden" name="survey_checkbox" value="add"  />
                                    <%}%>
                                    
                                        <label class="label">Tick (&#10004;) checkbox if this answer is correct
                                        </label>
                                        <span style="display:flex">
                                            <label class="ContainerRadioButton">                                            
                                            <input type="checkbox" name="chk_answer1" 
                                                   <% if (("true".equals(request.getAttribute("correctAnswer1"))) && request.getAttribute("ansType").equals("survey_checkbox")){%>  checked="checked" <%}%> >
                                            <span class="checkboxCheckMark"></span>                                            
                                        </label>
                                            <input type="text" name="checkboxOption1" value="<% if ((request.getAttribute("answer_text1") != null) && request.getAttribute("ansType").equals("survey_checkbox")) {%><%=request.getAttribute("answer_text1")%><%}%>" placeholder="Answer Option one..." />
                                        </span>
                                   
                                        <label class="label">
                                        </label>
                                        <span style="display:flex">
                                             <label class="ContainerRadioButton">                                            
                                            <input type="checkbox" name="chk_answer2" <% if (("true".equals(request.getAttribute("correctAnswer2"))) && request.getAttribute("ansType").equals("survey_checkbox")) {%>  checked="checked" <%}%>>
                                            <span class="checkboxCheckMark"></span>                                            
                                        </label>
                                            <input type="text" name="checkboxOption2" value="<% if ((request.getAttribute("answer_text2") != null) && request.getAttribute("ansType").equals("survey_checkbox")){%><%=request.getAttribute("answer_text2")%><%}%>" placeholder="Answer Option one..." />
                                        </span>
                                   
                                        <label class="label">
                                        </label>
                                        <span style="display:flex">
                                             <label class="ContainerRadioButton">                                            
                                            <input type="checkbox" name="chk_answer3" <% if (("true".equals(request.getAttribute("correctAnswer3"))) && request.getAttribute("ansType").equals("survey_checkbox")){%>  checked="checked" <%}%>>
                                            <span class="checkboxCheckMark"></span>                                            
                                        </label>
                                            <input type="text" name="checkboxOption3" value="<% if ((request.getAttribute("answer_text3") != null)&& request.getAttribute("ansType").equals("survey_checkbox")) {%><%=request.getAttribute("answer_text3")%><%}%>" placeholder="Answer Option one..." />
                                        </span>
                                   
                                        <label class="label">
                                        </label>
                                        <span style="display:flex">
                                             <label class="ContainerRadioButton">                                            
                                            <input type="checkbox" name="chk_answer4" <% if (("true".equals(request.getAttribute("correctAnswer4"))) && request.getAttribute("ansType").equals("survey_checkbox")) {%>  checked="checked" <%}%>>
                                            <span class="checkboxCheckMark"></span>                                            
                                        </label>
                                            <input type="text" name="checkboxOption4" value="<% if ((request.getAttribute("answer_text4") != null) && request.getAttribute("ansType").equals("survey_checkbox")){%><%=request.getAttribute("answer_text4")%><%}%>" placeholder="Answer Option one..." />
                                        </span>
                                   
                                </div>
                                <!--checkbox end here -->

                                <!--radio button start here -->
                                <div id="radioButtonOptions"  <% if (request.getParameter("questionId") != null && request.getAttribute("ansType").equals("survey_radio")) {}else{%>
                                     style="padding:5px;display: none;" <%}%>>
                                     <% if (request.getParameter("questionId") == null) { %>
                                    <div class="delete-survey-options" onClick='hideAnswersOption("addHTMLContent")'>
                                            Delete Options
                                        </div>
                                    <% }%>
                                   <% if (request.getParameter("questionId") != null) { %>
                                     <input type="hidden" name="survey_radio" value="edit"  />
                                    <% }else{%>
                                     <input type="hidden" name="survey_radio" value="add"  />
                                    <%}%>
                                    <label class="label">Tick (&#10004;) checkbox if this answer is correct
                                    </label>
                                    <span style="display:flex">                                       
                                        <label class="ContainerRadioButton">                                            
                                            <input type="radio" name="radio" id="radio_answer1" value="radio_answer1" <% if (("true".equals(request.getAttribute("correctAnswer1"))) && request.getAttribute("ansType").equals("survey_radio")) {%>  checked="checked" <%}%>>
                                            <span class="radioCheckMark"></span>                                            
                                        </label>
                                        <input type="text" name="radioOption1" value="<% if ((request.getAttribute("answer_text1") != null) && request.getAttribute("ansType").equals("survey_radio")) {%><%=request.getAttribute("answer_text1")%><%}%>" placeholder="Answer Option one..." />                                       
                                    </span>
                                
                                <span style="display:flex">
                                    <label class="ContainerRadioButton">
                                        <input type="radio" name="radio" id="radio_answer2" value="radio_answer2"  <% if (("true".equals(request.getAttribute("correctAnswer2"))) && request.getAttribute("ansType").equals("survey_radio")) {%>  checked="checked" <%}%>>
                                        <span class="radioCheckMark"></span>
                                    </label>
                                    <input type="text" name="radioOption2" value="<% if ((request.getAttribute("answer_text2") != null) && request.getAttribute("ansType").equals("survey_radio")) {%><%=request.getAttribute("answer_text2")%><%}%>" placeholder="Answer Option one..." />
                                </span>
                                <span style="display:flex">
                                    <label class="ContainerRadioButton">
                                        <input type="radio" name="radio" id="radio_answer3" value="radio_answer3"  <% if (("true".equals(request.getAttribute("correctAnswer3"))) && request.getAttribute("ansType").equals("survey_radio")) {%>  checked="checked" <%}%>>
                                        <span class="radioCheckMark"></span>
                                    </label>
                                    <input type="text" name="radioOption3" value="<% if ((request.getAttribute("answer_text3") != null) && request.getAttribute("ansType").equals("survey_radio")) {%><%=request.getAttribute("answer_text3")%><%}%>" placeholder="Answer Option one..." />
                                </span>
                                <span style="display:flex">
                                    <label class="ContainerRadioButton">
                                        <input type="radio" name="radio" id="radio_answer4" value="radio_answer4"  <% if (("true".equals(request.getAttribute("correctAnswer4"))) && request.getAttribute("ansType").equals("survey_radio")) {%>  checked="checked" <%}%>>
                                        <span class="radioCheckMark"></span>
                                    </label>
                                    <input type="text" name="radioOption4" value="<% if ((request.getAttribute("answer_text4") != null) && request.getAttribute("ansType").equals("survey_radio")) {%><%=request.getAttribute("answer_text4")%><%}%>" placeholder="Answer Option one..." />
                                </span>
                                
                                </div>
                                <!--radio button end here -->

                                <!--Input type text start here -->
                                <div id="inputTextOptions" <% if (request.getParameter("questionId") != null && request.getAttribute("ansType").equals("survey_text_answer")) {}else{%>
                                     style="padding:5px;display: none;" <%}%>>
                                     <% if (request.getParameter("questionId") == null) { %>
                                    <div class="delete-survey-options" onClick='hideAnswersOption("addHTMLContent")'>
                                            Delete Options
                                        </div>
                                    <% }%>
                                  <% if (request.getParameter("questionId") != null) { %>
                                     <input type="hidden" name="survey_text"  value="edit"  />
                                    <% }else{%>
                                     <input type="hidden" name="survey_text"  value="add"  />
                                    <%}%>
                                    
                                    <label class="label">Type your answer in sentences
                                    </label>
                                    <span>                                       
                                        <input type="text" name="survey_text_answer" value="<% if ((request.getAttribute("answer_text1") != null) && request.getAttribute("ansType").equals("survey_text_answer")) {%><%=request.getAttribute("answer_text1")%><%}%>" placeholder="Type your answer in text..." />
                                        
                                    </span>
                                  </div>
                                <!--Input type end here -->
                              
                       
                <!-- multiple option answer here here -->

                <button class='signup-bottom'  type="submit">
                    <% if (request.getParameter("questionId") != null) {%>Update Question/Answers<%} else {%>Add Question/Answers<%}%>
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

