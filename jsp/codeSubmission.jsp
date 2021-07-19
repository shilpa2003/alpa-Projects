<html lang="en">

<head>
    <!-- JSP importing package -->
    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*,java.util.*,org.apache.commons.fileupload.disk.*,org.apache.commons.fileupload.servlet.*,org.apache.commons.fileupload.*,org.apache.commons.io.output.*,java.io.*"%>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- font awesome cdn -->
    <script src="https://use.fontawesome.com/56030c5688.js"></script>

    <!-- bootstrap stylesheet -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
        integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

    <!-- icon -->
    <link rel="icon" href="../favicon.ico">
    <title>Code Submission</title>

    <!-- external css -->
    <link rel="stylesheet" href="../css/home.css">

</head>

<body>
 <%-- JSP connecting to db --%>
    <%
        PreparedStatement ps=null;
        Connection con=null;
        String enroll=null;
        
        String teamCode=request.getParameter("team");

        try{
            Class.forName("com.mysql.jdbc.Driver");
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/miniPrj","java1","ironman@3"); 
            enroll=(String)session.getAttribute("user");

            //check ps Submission
            String checkSb="select marks as status,code from projectDesc where teamCode='"+teamCode+"';";
            ps=con.prepareStatement(checkSb);    
            ResultSet check=ps.executeQuery();
            
            if(check.next()){
                //out.print(check.getString("status"));
                if(("0".equals(check.getString("status"))) && check.getString("code")!=null){
                    out.print("<script>alert('Submission is done \\n wait for marks...');window.location='stdHome.jsp';</script>");
                }
                else if(!"0".equals(check.getString("status")) && check.getString("code")!=null){
                    out.print("<script>window.location='studentProjectView.jsp?team="+teamCode+"';</script>");
                }
            }
            
        }
        catch(Exception e){
            out.println("<script>alert('"+e+"')</script>");
        }
    %>


    <!-- Navbar / Header of website -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light justify-content-between">
        <!-- <div class="container px-5 py-2"> -->
        <a class="navbar-brand text-primary" href="stdHome.jsp" style="font-size: 25px;">
            <i class="fa fa-cloud-upload fa-lg" aria-hidden="true" style="margin:5px; margin-right: 5px;"></i>
            Alpha Projects
        </a>
        
   <div class="profile mr-3">
            <div id="user">
                <span>hi , 
                    <% 
                    if(session.getAttribute("user")==null)
                        response.sendRedirect("../index.html");
                    else   
                        out.print(session.getAttribute("user"));
                    %>
                <i class="fa fa-user-circle-o px-1"> </i></span>
            </div>
            <div id="userMenu">
                <a href="./logout.jsp">LogOut</a>
            </div>
        </div>
        <!-- </div> -->
    </nav>

    <div class="container p-5 shadow my-5">
        <h2 style="text-align: center;">Code Submission  
            <span style="font-size:13px;">
    <% 
        try
        {
            String getDate="select codeSubmissionDate as date from assignPrj where subjectCode=(select subjectCode from teams where teamCode='"+teamCode+"');";
            ps=con.prepareStatement(getDate);    
            ResultSet d=ps.executeQuery();
            
            if(d.next()){
                out.print("#deadline : "+d.getString("date"));
                session.setAttribute("team",teamCode);     
            }

        }catch(Exception e){
            out.println("<script>alert('"+e+"')</script>");
        }
    %>
        </span></h2>
        <hr>
    <div class="container" style="border:1px solid #cecece; background-color: rgb(245, 245, 245); width: 70%;">
        <br>
        <form action="code.jsp" method="POST" enctype="multipart/form-data">

            <div class="w-80 p-3">

                <div class="form-group">
                    <label for="dmn">Upload Code:</label>
                    <div class="custom-file">
                        <input type="file" accept="application/zip" class="custom-file-input" id="zfile"
                            name="fileName" onchange="return zfileValidation()" / required>
                        <label class="custom-file-label" for="customFile">Choose file</label>
                    </div>
                    <small>File format must be .zip</small>
                </div><br>
                <div class="form-group">
                    <label for="ps">Upload Output:</label>
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" id="file" name="fileName"
                            onchange="return fileValidation()" / required>
                        <label class="custom-file-label" for="customFile">Choose file</label>
                    </div>
                    <small>File format must be .pdf</small>
                </div><br>
               
                <div class="form-group">
                    <label for="discription">Project Report:</label>
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" id="pfile" name="fileName"
                            onchange="return pfileValidation()" / required>
                        <label class="custom-file-label" for="customFile">Choose file</label>
                    </div>
                    <small>File format must be .pdf</small>
                </div><br>

                <div class="text-center">
                    <button type="submit" class="btn btn-success" style="text-align: center;">Submit</button>
                </div>
                <br>
            </div>

        </form>
    </div>
    </div>
    <br>

    <!-- bootstrap cdn -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx"
        crossorigin="anonymous"></script>

    <script>
        // Add the following code if you want the name of the file appear on select
        $(".custom-file-input").on("change", function () {
            var fileName = $(this).val().split("\\").pop();
            $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
        });
    </script>

    <script>
        function zfileValidation() {
            var fileInput =
                document.getElementById('zfile');

            var filePath = fileInput.value;

            // Allowing file type 
            var allowedExtensions = /(\.zip)$/i;

            if (!allowedExtensions.exec(filePath)) {
                alert('Invalid file type');
                fileInput.value = '';
                return false;
            }
        } 
    </script>


    <script>
        function fileValidation() {
            var fileInput =
                document.getElementById('file');

            var filePath = fileInput.value;

            // Allowing file type 
            var allowedExtensions = /(\.pdf)$/i;

            if (!allowedExtensions.exec(filePath)) {
                alert('Invalid file type');
                fileInput.value = '';
                return false;
            }
        } 
    </script>

    <script>
        function pfileValidation() {
            var fileInput =
                document.getElementById('pfile');

            var filePath = fileInput.value;

            // Allowing file type 
            var allowedExtensions = /(\.pdf)$/i;

            if (!allowedExtensions.exec(filePath)) {
                alert('Invalid file type');
                fileInput.value = '';
                return false;
            }
        } 
    </script>

    <!-- Footer for contact-us -->
    <footer class="page-footer p-4 bg-dark text-light d-print-none" style="position:relative;bottom:0;width:100%;">
        <p class="lead"> Contact Us : &emsp;
            <i class="fa fa-github fa-lg" aria-hidden="true"></i> Github &emsp;
            <i class="fa fa-envelope fa-lg" aria-hidden="true"></i> Gmail
        </p>
    </footer>

</body>

</html>