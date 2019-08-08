<%@page import="Controller.Login" %>  
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
            <div class="content-section-area">
                <div class='form '>
                  
                     <% if (request.getParameter("success") != null && request.getParameter("success").length() !=0){%>
                               <span class='success-message' id='hideblock'>  ${param.success}<img style='height:7px;width:7px;margin-left:12px;cursor:pointer;' onclick="hideMessage();" src='img/success.png'/> </span>
                          <%  }   %>
                    
                                                       
                      <h4 style='margin-top:20px;'>Login</h4>
                    <span style='font-size: 12px;color:#828282;margin-left:2px'>Enter your valid Email/Password</span>
                    <form style='margin-top:5px' autocomplete="off" action='Login'>
                        <div>
                            <input type="email" name="email" placeholder="Email" />
                        </div>
                        <div>
                            <input type="password" name="password" placeholder="Password" />
                        </div>
                        <button class='signup-bottom' type="submit" >Sign In</button>
                        

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file = "Footer.jsp" %>
