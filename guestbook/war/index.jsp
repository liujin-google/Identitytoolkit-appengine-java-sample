     <!DOCTYPE html>
     <html>
       <head>
         <%@ page import="com.google.identitytoolkit.GitkitClient" %>
         <%@ page import="com.google.identitytoolkit.GitkitUser" %>
         <%@ page import="java.io.FileInputStream" %>
         <%@ page import="java.io.FileNotFoundException" %>
        <%
         GitkitUser gitkitUser = null;
         try {
           ServletContext context = getServletContext();
           GitkitClient gitkitClient = GitkitClient.newBuilder()
             .setGoogleClientId("...")
             .setServiceAccountEmail("...")
             .setKeyStream(new FileInputStream(context.getRealPath("/WEB-INF/serviceaccountkey.data")))
             .setWidgetUrl("/gitkit.jsp")
             .build();
           gitkitUser = gitkitClient.validateTokenInRequest(request);
         } catch (FileNotFoundException e) {
             e.printStackTrace();
         }
        %>
         <script type="text/javascript" src="//www.gstatic.com/authtoolkit/js/gitkit.js"></script>
         <link type=text/css rel=stylesheet href="//www.gstatic.com/authtoolkit/css/gitkit.css" />
         <script type=text/javascript>
              window.google.identitytoolkit.signInButton(
                  '#navbar', // accepts any CSS selector
                  {
                    widgetUrl: "/gitkit",
                    signOutUrl: "/index.jsp",
                  }
                );
         </script>

         <!-- End configuration -->

       </head>
       <body>
      <div id="navbar"></div>
      <p>
      <% if (gitkitUser != null) { %>
        Welcome back!<br><br>
        Email: <%= gitkitUser.getEmail() %><br>
        Id: <%= gitkitUser.getLocalId() %><br>
        Provider: <%= gitkitUser.getCurrentProvider() %>
      <% } else { %>
        You are not logged in yet.
      <% } %>
      </p>
     </body></html>
