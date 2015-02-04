<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.net.URLEncoder" %>
<%
  StringBuilder builder = new StringBuilder();
  String line;
  try {
    while ((line = request.getReader().readLine()) != null) {
      builder.append(line);
    }
  } catch (IOException e) {
    throw new RuntimeException(e);
  }
  String postBody = URLEncoder.encode(builder.toString(), "UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

  <script type="text/javascript" src="//www.gstatic.com/authtoolkit/js/gitkit.js"></script>
  <link type="text/css" rel="stylesheet" href="//www.gstatic.com/authtoolkit/css/gitkit.css" />
  <script type="text/javascript">
    var config = {
        apiKey: 'AIza...',
        signInSuccessUrl: '/index.jsp',
        idps: ["google"],
        idpButtons: 1,
        oobActionUrl: '/',
        siteName: 'this site'
    };
    // The HTTP POST body should be escaped by the server to prevent XSS
    window.google.identitytoolkit.start(
       '#gitkitWidgetDiv', // accepts any CSS selector
       config,
       '<%= postBody %>');
  </script>
  <script type="text/javascript" src="//apis.google.com/js/client.js?onload=load"></script>
</head>
<body>
<!-- Placeholder for the GAT widget panels -->
<div id="gitkitWidgetDiv"></div>
</body></html>
