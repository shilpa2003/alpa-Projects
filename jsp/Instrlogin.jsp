
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*,java.util.*, java.io.*,java.lang.*" %>
<%
String uname=request.getParameter("unameI");
session.putValue("uname",uname);
String psw=request.getParameter("pswI");
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/miniPrj","java1","ironman@3"); 
Statement st= con.createStatement();
ResultSet rs=st.executeQuery("select * from instructor where instructorId='"+uname+"' and psw='"+psw+"'");
try{
rs.next();
if(rs.getString("psw").equals(psw)&&rs.getString("instructorId").equals(uname))
{
session.setAttribute("user",rs.getString("instructorId"));
response.sendRedirect("instructorHome.jsp");
}
}
catch (Exception e) {
e.printStackTrace();
%> 
<script>
window.alert("Invalid username or password\nRe-enter the details"); 
document.location="../index.html";
</script>

<%
}
%>