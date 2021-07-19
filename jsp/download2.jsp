<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*,java.util.*, java.io.*,java.lang.*" %>

<%

    String teamcode="1041";
    
    try
    {
     Class.forName("com.mysql.jdbc.Driver");
     //Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/mini","root","20031998");
     Connection con=DriverManager.getConnection("jdbc:mysql://bmfqadeaynicb7pn4izx-mysql.services.clever-cloud.com:3306/bmfqadeaynicb7pn4izx","uf3zyddfyt288imy","Jwc5yfLdhT7eSsWYsuc3");
     PreparedStatement ps1=con.prepareStatement("select output from projectDesc where teamcode='"+teamcode+"';");
     ResultSet rs1=ps1.executeQuery();  
     rs1.next();
     String filename=rs1.getString("output");
     String filepath="C:/Program Files (x86)/Apache Software Foundation/Tomcat 9.0/webapps/mini/team";
    response.setContentType("APPLICATION/OCTET-STREAM");   
    response.setHeader("Content-Disposition","attachment; filename=\"" + filename + "\"");   
  
  java.io.FileInputStream fileInputStream=new java.io.FileInputStream(filepath + filename);  
            
  int i;   
  while ((i=fileInputStream.read()) != -1) {  
    out.write(i);   
  }   
  fileInputStream.close(); 
    con.close();  
  }catch(Exception e)
                {
                    out.println(e);
                } 
  %>
