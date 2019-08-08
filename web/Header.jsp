<%@page import="Controller.Login" %>  
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="description" content="" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
            />
        <title>Road Safety Education</title>
        <link rel="stylesheet" href="style.css" />
        
    </head>

    <body>
        <div style="height:100%;position: relative;">
            <header class="header-area">
                <!-- Top Header Area -->
                <div class="top-header-area">
                    <div class="container">
                        <div class="top-header-content d-flex justify-content-between">
                            <div class="header-row">
                                <span class="header-logo"><img style='opacity: 0.6;' src='./img/logo.png'/></span>
                                <span class="header-text">
                                    
                                    
                                    <%
                                        String email=(String)session.getAttribute("email");
                                        String username=(String)session.getAttribute("username");                                         
                                        //redirect user to login page if not logged in
                                        if(email==null)
                                           {%>
                                                 <a href="Login.jsp">Login</a>
                                                 <a href="Register.jsp">Register</a>
                                            <%}else{%>                                         
                                            <span style='color:#fff;font-weight: bold;'>
                                                <%=username.toUpperCase()%> |<a href="logout.jsp">Logout</a>
                                            
                                            </span>
                                             
                                            <% }%>                                   
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Navbar Area -->
                <div class="nav-menu-area" id="stickyMenu">
                    <div class="classy-nav-container breakpoint-off">
                        <div class="container">
                            <!-- Menu -->
                            <nav class="classy-navbar" id="newspaperNav">
                                <!-- Navbar Responsive Toggler -->
                                <div class="classy-navbar-toggler" style="margin-left: 5px;">
                                    <span class="navbarToggler"
                                          ><span></span><span></span><span></span
                                        ></span>
                                </div>

                                <!-- Menu -->
                                <div class="classy-menu">
                                    <!-- Re close btn -->
                                    <div class="classycloseIcon">
                                        <div class="cross-wrap">
                                            <span class="top"></span><span class="bottom"></span>
                                        </div>
                                    </div>

                                    <!-- Nav Start -->
                                 
                                    <div class="classynav" style="margin-left:-10px;">
                                        <div id="myDIV" class="menu-link">  
                                       <% String app=(String)session.getAttribute("email");
                                                if(app!=null && app.length()>0){ 
                                            %>
                                            
                                         <%}else{%> 
                                         <a href="index.jsp" >Home</a>
                                         <%}%>
                                            <% String user_type=(String)session.getAttribute("user_type");
                                                if(user_type!=null && user_type.equals("admin")){ 
                                            %>
                                            <a href="QuizSetup.jsp">Quiz SetUp</a>
                                            <a href="SurveyResult.jsp">Survey Result</a>
                                            <%}  if(user_type!=null){ %>
                                            <a href="survey.jsp">Survey</a>
                                            <a href="Quiz.jsp">Quiz</a>
                                            <a href="QuizResult.jsp">Quiz Result</a>
                                             
                                            <%}%>
                                            <a href="Contact.jsp">Contact Us</a>
                                          
                                        
                                       
                                        </div>
                                    </div>
                                    <!-- Nav End -->
                                </div>
                            </nav>
                        </div>
                    </div>
                </div>
            </header>