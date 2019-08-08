<!-- ##### Header Area Start ##### -->

<%@ include file = "Header.jsp" %>

<script type="text/javascript">
    function Validate() {
        var password = document.getElementById("password").value;
        var confirmPassword = document.getElementById("Confirm_password").value;
        if (password != confirmPassword) {
            alert("Passwords do not match. Please try Again");
            return false;
        }
        return true;
    }
</script>
<div class="container" style="height: 100%;margin-top: 5px">
    <div class="top-header-content d-flex  justify-content-between">
        <div class="wrapper" style="margin-bottom: 65px;">
            <div class="content-section-area">
                <span style='font-size: 8px;margin-left:12px'>
                    <a style='color:blue;font-size: 12px' href='Login.jsp'>
                        Click here to login if you have already registered.... </a>
                </span>
${param.success}
                <div class='form '>

                    <h4 >Create Account</h4>
                    <span style='font-size: 12px;color:#828282;margin-left:2px'>It's free hardly and takes more then 30 seconds</span>

                    <form  style='margin-top:5px' autocomplete="off" action='UsersRegister' method="Post" onsubmit="return Validate()">
                        <div>

                            <input type="text" name="username" placeholder="Username"/>
                        </div>
                        <div>

                            <input type="email" name="email" placeholder="Email"/>
                        </div>
                        <div>

                            <input type="password" name="password" id="password" placeholder="Password"  />
                        </div>
                        <div >

                            <input type="password" name="CPassword" id="Confirm_password" placeholder="Confirm Password" />
                        </div>
                        
                        <button  class='signup-bottom' type="submit">Sign Up</button>


                        <div class="title-text">
                            By clicking the Sign Up button, you agree to our Terms &
                            Conditions, and Privacy Policy
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file = "Footer.jsp" %>

