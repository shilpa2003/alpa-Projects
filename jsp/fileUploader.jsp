 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,org.apache.commons.fileupload.*,org.apache.commons.io.output.*,java.io.*"%>

<%-- JSP connecting to db --%>
    <%
        PreparedStatement ps=null;
        Connection conn=null;
        String enroll=null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/miniPrj","java1","ironman@3"); 
            enroll=(String)session.getAttribute("user");
        }
        catch(Exception e){
            out.println("<script>alert('"+e+"')</script>");
        }
    %>

    <%             
        try{
                File file;
                int maxSize=5000*1024;
                int maxFactSize=5000*1024;
                String type=request.getContentType();
                String[] textData=new String[6];
                //out.println(type);
                int j=0;

                if(type.indexOf("multipart/form-data")>=0){
                    //out.println(type);
                    DiskFileItemFactory diskFact=new DiskFileItemFactory();
                    diskFact.setSizeThreshold(maxFactSize);
                    diskFact.setRepository(new File("/opt/tomcat/webapps/miniPrj/temp"));
                    ServletFileUpload upload=new ServletFileUpload(diskFact);
                    upload.setSizeMax(maxSize);
                    List ls=upload.parseRequest(request);
                    Iterator i=ls.iterator();
                    FileItem myFile=null;
                    String fileName=null;

                    while(i.hasNext()){
                         //out.println(i.next());
                        FileItem fitem=(FileItem)i.next();
                        if(!fitem.isFormField()){
                            fileName=fitem.getName();
                            out.println(fileName);
                            myFile=fitem;
                        }
                        else{
                            textData[j]=fitem.getString();
                            j++;
                        }
                    }
                    
                    int x=(int)(Math.random()*10000);

                    String checkInst="select * from subject where instructorId=? and subjectCode=?";
                    ps=conn.prepareStatement(checkInst);
                    ps.setString(1,textData[4]);//instructorId
                    ps.setString(2,textData[3]);//subject

                    ResultSet rs=ps.executeQuery();

                    if(!rs.next()){
                        out.print("<script>alert('Please check subject and instructor...');window.location='stdHome.jsp';</script>");  
                    }
                    else{
                        fileName=textData[0].substring(0,3)+textData[2].substring(0,3)+Integer.toString(x)+fileName.substring(fileName.indexOf("."));
                        out.println(fileName);
                        file=new File("/opt/tomcat/webapps/miniPrj/TeamLogo",fileName);
                        myFile.write(file);

                        String insertData="insert into teams values(?,?,?,?,?,?,?,?)";
                        ps=conn.prepareStatement(insertData);
                        ps.setString(1,enroll);
                        ps.setString(2,textData[0]);
                        ps.setInt(3,Integer.parseInt(textData[1]));
                        ps.setString(4,textData[2]);
                        ps.setString(5,textData[3]);
                        ps.setString(6,textData[4]);
                        ps.setString(7,fileName.substring(0,fileName.indexOf(".")));
                        ps.setString(8,fileName);

                        int checkInsert=ps.executeUpdate();

                        if(checkInsert==0)
                            out.println("<script>alert('Failed...')</script>");
                        else{
                            response.setStatus(response.SC_MOVED_TEMPORARILY);
                            response.setHeader("Location", "stdHome.jsp");
                        }
                    }
                }
            }
            catch(Exception e){
                out.println("<script>alert('"+e+"')</script>");
            }
    %>
