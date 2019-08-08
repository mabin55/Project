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
                        <h4>Search by User Name </h4>
                     <input  style='padding:5px' class='search' name='username' type="text" placeholder="Search.."/>
                     <input type="hidden" name='survey' value='search_survey'/>
                      <span class="add-question-span">
                          <button style='font-weight: bold;cursor: pointer;padding:7px;background-color:#7a7aff;color:#fff;border:none' type='submit'>
                              Search
                          </button>
                      </span>   
                    </form>
                </div>

               <table>
                   
                            <tr style="background-color: #7a7aff;color: #fff;">
                                <th>USERNAME</th>                                
                                <th>SURVEY LEVEL</th>
                                <th>CREATED DATE</th>
                                <th>User Survey</th>
                               
                         </tr>
                            
                         
                            <% 
                        
                           try {
                            String whereCondition = "";
                            String USERNAME = "";
                           
                            
                             if(request.getParameter("USERNAME")!=null){
                               USERNAME =  request.getParameter("USERNAME");
                              
                               whereCondition =  " and upper(a.b.USERNAME) like upper('%"+USERNAME+"%')  ";
                            }
                          
                            DBConnection db = new DBConnection();
                            Connection conn = db.getConnection();
                            PreparedStatement level = conn.prepareStatement("select a.ID USER_ID, b.USERNAME USERNAME, a.QUIZ_ID QUIZ_ID,c.SECTION_NAME SURVEY_LEVEL , TOKEN, CREATED_DATE From USER_ANSWERS  a "
                                                                           + "left join USERS b on a.ID=b.ID left join SURVEY_SECTION c on a.QUIZ_ID=c.SURVEY_LEVEL_ID where text_answer is not null " + whereCondition + " "
                                                                           + "group by a.ID,b.USERNAME,QUIZ_ID,TOKEN,c.SECTION_NAME,CREATED_DATE order by a.created_date");
                            ResultSet levelSet = level.executeQuery();
                         
                            while (levelSet.next()) {
                    %>         
                   
                            <tr>
                                <td><%=levelSet.getString("USERNAME") %></td>
                                <td><%=levelSet.getString("SURVEY_LEVEL") %></td>
                                <td><%=levelSet.getString("CREATED_DATE") %></td>
                                <td>
                               <a href='ViewSurvey.jsp?token=<%=levelSet.getString("TOKEN")%>&SURVEY_LEVEL=<%=levelSet.getString("SURVEY_LEVEL")%>' style='margin-right:5px;background-color:#7a7aff;padding:3px;color:#fff' >View Survey </a>
                                
                                </td>

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

