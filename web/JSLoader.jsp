<!-- ##### All Javascript Files ##### -->
<script src="js/jquery-2.2.4.min.js"></script>
<script src="js/plugins.js"></script>
<script src="js/active.js"></script>

<script>
    jQuery(document).ready(function($){
  // Get current path and find target link
  var path = window.location.pathname.split("/").pop();
  
  // Account for home page with empty path
  if ( path == '' ) {
    path = 'index.jsp';
  }
      
  var target = $('nav a[href="'+path+'"]');
  // Add active class to target link
  target.addClass('active');
});

function showAnswersOption(elementID){
            var HtmlElement = document.getElementById(elementID);  
            var parentsElement = document.getElementById('addHTMLContent'); 
            parentsElement.innerHTML = HtmlElement.innerHTML;       
            parentsElement.style = 'visible';
        }  

        function hideAnswersOption(elementID) {
                var HtmlElement = document.getElementById(elementID);
                HtmlElement.style.display = 'none';
            }      


  

</script>