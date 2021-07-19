<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "javax.servlet.http.*" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "org.apache.commons.fileupload.disk.*" %>
<%@ page import = "org.apache.commons.fileupload.servlet.*" %>
<%@ page import = "org.apache.commons.io.output.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*,java.lang.*" %>
<%!
String fileName ;
%>
<%
   File file ;
   String teamCode=(String)session.getAttribute("team");
    
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
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
         
         while ( i.hasNext () ) {
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () ) {
               fileName = fi.getName();
               fileName=teamCode+"_abstract"+".pdf";    //change name with extension
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
         PreparedStatement ps=con.prepareStatement("update projectDesc set abstract=(?) where teamcode='"+teamCode+"';");
         ps.setString(1,fileName);
         int x=ps.executeUpdate();

         if(x>0){
            out.print("<script>alert('Abstract is submitted...');window.location='stdHome.jsp';</script>");
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