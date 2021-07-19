
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*,java.util.*,java.text.*,java.util.Date"%>
<html>
<head>
<title>Status</title></head>
<body>
<%
String uname=request.getParameter("iuname");
String id=request.getParameter("iid");
String firstName=request.getParameter("ifname");
String lastName=request.getParameter("ilname"); 
String email=request.getParameter("iemail");
String phoneno=request.getParameter("ipno");
String psw=request.getParameter("ipsw");
String pswre=request.getParameter("ipswre");

try
{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/miniPrj","java1","ironman@3"); 

    PreparedStatement st = con.prepareStatement("select * from instructor where email = ?");
    st.setString(1, email);
    ResultSet r1=st.executeQuery();
    if(r1.next()) {
        out.println("<script>alert(' Account is available with this email.... \\n Please Login...');window.location='../index.html';</script>");
    }
    else
    {
    PreparedStatement ps=con.prepareStatement("insert into instructor(instructorId,uname,fname,lname,email,pno,psw) values(?,?,?,?,?,?,?);");
    ps.setString(1,id);
    ps.setString(2,uname);
    ps.setString(3,firstName);
    ps.setString(4,lastName);
    ps.setString(5,email);
    ps.setString(6,phoneno);
    ps.setString(7,psw);
    int x=ps.executeUpdate();
    if(x!=-1)
    {
      out.println("<script>alert(' Registration success.... \\n Welcome to alpha Projects ! \\n Please Login...');window.location='../index.html';</script>");

    }
    else
    {
      out.println("<script>alert(' Registration failed.... ');window.location='../index.html';</script>");
    }
    }
}
catch(Exception e)
{
    out.println(e);
}    
%>
</body>
</html>