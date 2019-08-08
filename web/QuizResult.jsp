<%@page import="java.security.SecureRandom"%>
<%@page import="java.util.Random"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Model.DBConnection"%>
<!-- ##### Header Area Start ##### -->
<%@ include file = "Header.jsp" %>
<div class="container" style="height: 100%;margin-top: 5px">
    <div class="top-header-content d-flex  justify-content-between">
        <div class="wrapper" style="margin-bottom: 65px;">
            <div class="content-section-area">
                
                <div class="search-form"   style=" margin-bottom:10px">
                    <form method="post" autocomplete="off" action='Search'>
                        <h4>Search by Quiz Name</h4>
                     <input  style='padding:5px' class='search' name='quiz_name' type="text" placeholder="Search.."/>
                      <span class="add-question-span">
                          <button style='font-weight: bold;cursor: pointer;padding:7px;background-color:#7a7aff;color:#fff;border:none' type='submit'>
                              Search
                          </button>
                      </span>   
                    </form>
                </div>

               <table>
                   
                            <tr style="background-color: #7a7aff;color: #fff;">
                                <th>Quiz Level</th>                                
                                <th>Quiz Name</th>
                                <th>Username</th>
                                <th>Obtained Score</th>
                                <th>Total Score</th>
                                <th>Result</th>
                                <th>Played Date</th>
                         </tr>
                            
                         
                            <% 
                                Random RANDOM = new SecureRandom();
                                String letters = "abcdefghjkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ23456789+@";
                                String token = "";
                                for (int i=0; i<10; i++)
                                {   int index = (int)(RANDOM.nextDouble()*letters.length());
                                    token += letters.substring(index, index+1);
                                }
                        
                           try {
                            String whereCondition = "";
                            String quiz_name = "";
                            if(username.equals("admin")){
                            whereCondition ="";
                            }else{
                            whereCondition = "  and upper(a.USERNAME)=upper('"+username+"') ";   
                            }
                            if(request.getParameter("quiz_name")!=null){
                               quiz_name =  request.getParameter("quiz_name");
                               whereCondition +=  " and upper(a.QUIZ_NAME) like upper('%"+quiz_name+"%')";
                            }
                          DBConnection db = new DBConnection();
                            Connection conn = db.getConnection();
                            PreparedStatement level = conn.prepareStatement("select  a.token,a.quiz_id,a.level_id,a.QUIZ_LEVEL,a.QUIZ_NAME,a.USERNAME, case when a.Obtained is null then 0 else a.obtained end Obtained,a.TOTAL,a.QUIZ_RESULT,a.CREATED_DATE from (select a.token, a.QUIZ_ID, a.level_id ,a.QUIZ_LEVEL ,a.QUIZ_NAME ,a.USERNAME USERNAME,b.correct_count Obtained, a.total,case when b.correct_count*100/ a.total>=40 then 'PASS' ElSE 'FAIL' END QUIZ_RESULT,a.CREATED_DATE  FROM (select   a.QUIZ_ID, l.id as level_id, l.level_description QUIZ_LEVEL, c.QUIZ_QUESTION_NAME QUIZ_NAME, b.USERNAME USERNAME, a.created_date,count(*) Total,a.TOKEN from User_answers a left join USERS b on a.ID=b.id left join QUIZ c on a.QUIZ_ID=c.QUIZ_ID and a.QUESTION_LEVEL_ID=c.LEVEL_ID left join LEVEL_NAME l on a.QUESTION_LEVEL_ID=l.id group by  a.QUIZ_ID, l.id ,l.level_description , c.QUIZ_QUESTION_NAME , b.USERNAME , a.created_date,a.token) a "
                                    + "left join ( select user_id,quiz_level, quiz_id,created_date, count(1) correct_count,token from ( SELECT a.ID USER_ID,a.QUESTION_LEVEL_ID quiz_level, a.QUIZ_ID, a.QUESTION_ID, a.USER_ANSWER_ID, b.answer_id,a.TOKEN, case when a.USER_ANSWER_ID=b.answer_id then 'YES' ELSE 'NO' END IS_CORRECTANSWER,a.CREATED_DATE  FROM ROOT.USER_ANSWERS  a  "
                                    + "left join (SELECT question_id, id answer_id, answer_text FROM ROOT.QUIZ_ANSWER where answer_yn=True ) b on a.QUESTION_ID=b.QUESTION_ID )  a where a.is_correctanswer='YES' "
                                    + "group by user_id,quiz_level, quiz_id,created_date,token) b on a.token=b.token)a where a.level_id is not null  " + whereCondition + " order by a.created_date");
                            ResultSet levelSet = level.executeQuery();
                         
                            while (levelSet.next()) {
                    %>                                         
                            <tr>
                                <td><%=levelSet.getString("QUIZ_LEVEL") %></td>
                                <td><%=levelSet.getString("QUIZ_NAME") %></td>
                                <td><%=levelSet.getString("USERNAME") %></td>
                                <td><%=levelSet.getString("Obtained") %></td>
                                <td><%=levelSet.getString("TOTAL") %></td>
                               <td style="float:right"><%
                                   if(levelSet.getString("QUIZ_RESULT").equals("FAIL")){%>
                                 &nbsp;  <a href='PlayQuiz.jsp?Level=<%=levelSet.getString("QUIZ_LEVEL")%>&quiz_id=<%=levelSet.getString("quiz_id")%>&LevelId=<%=levelSet.getString("level_id")%>&quizToken=<%=token%>&currentpage=1&page=previous' style='margin-right:5px;background-color:#7a7aff;padding:3px;color:#fff' >Re-attempt  </a>  
                                  <% } %>
                                  <a href='ViewAnswer.jsp?quiz_id=<%=levelSet.getString("quiz_id")%>&LevelId=<%=levelSet.getString("level_id")%>&token=<%=levelSet.getString("token")%>' style='margin-right:5px;background-color:#7a7aff;padding:3px;color:#fff' >View Answer  </a>
                                   <%=  levelSet.getString("QUIZ_RESULT") %></td>
                               <td><%=levelSet.getString("CREATED_DATE") %></td>

</tr>
                            </tr>
                            
                              <%   }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }%>
                            
                            
                        </table>
               
            </div>
        </div>
    </div>
</div>
<%@ include file = "Footer.jsp" %>

