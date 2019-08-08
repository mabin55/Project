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
               
                 <div class="question-top-header-box">
                        <span>
                            <h5><%=request.getParameter("SURVEY_LEVEL")%>  Questions/Answers</h5>
                            <h6>User: <%=username%></h6>
                            
                        </span>
                      
                    </div>
                           
                  <%    
                      try{
                     //   String token = request.getParameter("token");
                        DBConnection db = new DBConnection();
                        Connection conn = db.getConnection();             
                        Integer Counter = 1;
                        
                         PreparedStatement survey = conn.prepareStatement("select distinct a.question_text, b.USER_ANSWER_ID , b.TEXT_ANSWER "
                                + "from questions a "
                                + "join user_answers b on a.ID = b.QUESTION_ID and b.token='"+request.getParameter("token")+"' "
                                + "join user_answers c on a.ID = c.QUESTION_ID "
                                + "where a.QUESTION_TYPE like '%Survey%' ");
                        ResultSet getSurvey = survey.executeQuery();
                        while (getSurvey.next()) {
                            
                    %> 
                   
                    <div class="question-box">
                        <span><%=Counter%>. &nbsp;
                            <%  if (getSurvey.getString("question_text") != null && getSurvey.getString("question_text").length() !=0) {%>
                                <%=getSurvey.getString("question_text")%> ?
                           <% }%>                           
                        </span>
                    
                    <span style='margin-left: 23px;margin-top: 10px;'>                        
                            <b>User Answer:</b><%
                            if(getSurvey.getString("USER_ANSWER_ID")!=null && getSurvey.getString("USER_ANSWER_ID").length() > 0){
                            PreparedStatement ans = conn.prepareStatement("select distinct answer_text from quiz_answer  "                                   
                                    + " where id = " + getSurvey.getString("USER_ANSWER_ID") + " ");
                            ResultSet correctAns = ans.executeQuery();
                            while (correctAns.next()) {%>
                            <i><%=correctAns.getString("answer_text")%></i>,
                            <%   }
                            }else{%>
                            <i><%=getSurvey.getString("text_answer")%></i>
                           <%}%>                                             
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
<%@ include file = "Footer.jsp" %>

