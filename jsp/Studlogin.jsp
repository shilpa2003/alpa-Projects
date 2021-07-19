
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*,java.util.*, java.io.*,java.lang.*" %>
<%
String uname=request.getParameter("unameS");
session.putValue("uname",uname);
String psw=request.getParameter("pswS");
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/miniPrj","java1","ironman@3"); 
Statement st= con.createStatement();

ResultSet rs=st.executeQuery("select * from student where enroll='"+uname+"' and psw='"+psw+"'");
try{
rs.next();
if(rs.getString("psw").equals(psw) && rs.getString("enroll").equals(uname))
{
//out.print("Welcome " +uname);
session.setAttribute("user",rs.getString("enroll"));
response.sendRedirect("stdHome.jsp");
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