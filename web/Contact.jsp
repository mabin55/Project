
            <!-- ##### Header Area Start ##### -->
            <%@ include file = "Header.jsp" %>
            <!-- ##### Header Area End ##### -->
<script language="javascript" type="text/javascript">
  function hideMessage(){
             var x = document.getElementById("hideblock");
             x.style.display = "none";
             }
    </script>
            <!-- ##### Hero Area Start ##### -->
            <div class="container" style="height: 100%;margin-top: 5px">
                <div class="top-header-content d-flex  justify-content-between">
                    <div class="wrapper" style="margin-bottom: 65px;">
                        <div class="content-section-area" style="padding:2px !important">
                            <div class="form" style="padding:1px">
                                
                                 <% if (request.getParameter("success") != null && request.getParameter("success").length() !=0){%>
                               <span class='success-message' id='hideblock'>  ${param.success}<img style='width:15px;margin-left:12px;cursor:pointer;' onclick="hideMessage();" src='img/success.png'/> </span>
                          <%  }   %>
                               
                                <h4>Contact Us</h4>
                                <span style="font-size: 12px;color:#828282;margin-left:2px">
                                    Got a question? We'd love to hear from you. Send us a message
                                    and we'll response as soon as possible</span
                                >

                                <form style="margin-top:1px " autocomplete="off" method='Post' action="contact">
                                    <div>
                                        <label class="label">Name<span style="color:red">*</span></label>
                                        <input class="inputbox" type="text" name="username" placeholder="Username"/>
                                    </div>
                                    <div>
                                        <label class="label">Email<span style="color:red">*</span></label>
                                        <input class="inputbox" type="email" name="email" placeholder="Email"/>
                                    </div>
                                    <div>
                                        <label class="label">Message<span style="color:red">*</span></label>
                                        <textarea name="textarea" paceholder="Type your message here..."></textarea>
                                    </div>

                                    <button class="signup-bottom" type="submit">Send Message</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%@ include file = "Footer.jsp" %>
        
