
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*,java.util.*, java.io.*,java.lang.*" %>
<html>
<body>
<%
try{
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mini","root","20031998");
Statement st= con.createStatement();
ResultSet rs=st.executeQuery("select count(*) as count from projectdesc;");
rs.next();
int count=rs.getInt("count");
out.print("<p style='font-style: italic;'>currently there are "+count+" projects in the system</p>");
con.close();
}
catch (Exception e) {
e.printStackTrace();

}
%>
</body>
</html>