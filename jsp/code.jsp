<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "javax.servlet.http.*" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "org.apache.commons.fileupload.disk.*" %>
<%@ page import = "org.apache.commons.fileupload.servlet.*" %>
<%@ page import = "org.apache.commons.io.output.*" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*,java.lang.*" %>
<%!
    String fileName ,code,output,report;
%>
<%
   File file ;
   String teamcode1=(String)session.getAttribute("team");
   int maxFileSize = 50000 * 1024;
   int maxMemSize = 50000 * 1024;
   String path="/opt/tomcat/webapps/miniPrj/team";
   ServletContext context = pageContext.getServletContext();
   String filePath = context.getInitParameter("file-upload");

   // Verify the content type
   String contentType = request.getContentType();
   
   if ((contentType.indexOf("multipart/form-data") >= 0)) {
      DiskFileItemFactory factory = new DiskFileItemFactory();
      // maximum size that will be stored in memory
      factory.setSizeThreshold(maxMemSize);
      
      // Location to save data that is larger than maxMemSize.
      factory.setRepository(new File("/opt/tomcat/webapps/miniPrj/temp"));

      // Create a new file upload handler
      ServletFileUpload upload = new ServletFileUpload(factory);
      
      // maximum file size to be uploaded.
      upload.setSizeMax( maxFileSize );
      
      try { 
         // Parse the request to get file items.
         List fileItems = upload.parseRequest(request);

         // Process the uploaded file items
         Iterator i = fileItems.iterator();

         out.println("<html>");
         out.println("<head>");
         out.println("<title>JSP File upload</title>");  
         out.println("</head>");
         out.println("<body>");
         int count=0;
         while ( i.hasNext () ) {
            FileItem fi = (FileItem)i.next();
            count++;
            if ( !fi.isFormField () ) {
               String fileName = fi.getName();
                if(count==1)
                    {fileName=teamcode1+"_Code"+(fileName.substring(fileName.indexOf(".")));
                     code=fileName;
                    }
                if(count==2)
                    {fileName=teamcode1+"_Output"+(fileName.substring(fileName.indexOf(".")));
                     output=fileName;
                    }
                if(count==3)
                    {fileName=teamcode1+"_Report"+(fileName.substring(fileName.indexOf(".")));
                     report=fileName;
                    }
              
               // Write the file
               file=new File(path,fileName);
               fi.write( file ) ;
               out.println("Uploaded Filename: " + fileName + "<br>");
            }
         }
         out.println("</body>");
         out.println("</html>");
      } catch(Exception ex) {
         System.out.println(ex);
      }
   } else {
      out.println("<html>");
      out.println("<head>");
      out.println("<title>Servlet upload</title>");  
      out.println("</head>");
      out.println("<body>");
      out.println("<p>No file uploaded</p>"); 
      out.println("</body>");
      out.println("</html>");
   }
%>
<%
try{
   
         Class.forName("com.mysql.jdbc.Driver");
         Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/miniPrj","java1","ironman@3"); 
         PreparedStatement ps=con.prepareStatement("update  projectDesc set code=(?),output=(?),report=(?) where teamCode='"+teamcode1+"';");
         ps.setString(1,code);
         ps.setString(2,output);
         ps.setString(3,report);
         int x=ps.executeUpdate();

          if(x>0){
            out.print("<script>alert('Submission Success...');window.location='stdHome.jsp';</script>");
         }
         else{
            out.print("<script>alert('Failed...');window.location='stdHome.jsp';</script>");
         }

         con.close();
    }
catch(Exception e)
{
    out.print("<script>alert('"+e.getMessage()+"');window.location='stdHome.jsp';</script>");
} 
        
%>