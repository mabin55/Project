<%@page import="Controller.Login" %> 
<%@ include file = "Header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
session.invalidate();
response.sendRedirect("index.jsp");
%>
