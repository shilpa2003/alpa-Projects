<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*,java.util.*, java.io.*,java.lang.*" %>
<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- font awesome cdn -->
    <script src="https://use.fontawesome.com/56030c5688.js">
    </script>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
        integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

    <!-- icon -->
    <link rel="icon" href="../favicon.ico">

    <title>afterApproved</title>

    <!-- external css -->
    <link rel="stylesheet" href="../css/home.css">

</head>


<body>
    
    <%
    String teamCode=request.getParameter("team");
    PreparedStatement ps=null;
    Connection con=null;
    String enroll=null;

    try
    {
        Class.forName("com.mysql.jdbc.Driver");
        con=DriverManager.getConnection("jdbc:mysql://localhost:3306/miniPrj","java1","ironman@3"); 
        enroll=(String)session.getAttribute("user");

            //check Dates
            String checkDt="select dateValidator(?) as dateStatus;";
            ps=con.prepareStatement(checkDt); 
            ps.setString(1,teamCode);
            ResultSet check=ps.executeQuery();   
            if(check.next()){
                if("Code Submission Date Is Expired..".equals(check.getString("dateStatus"))){
                    out.print("<script>alert('Submission not allowed...\\nDate Expired');window.location='stdHome.jsp';</script>");
                }
            }

        //check ps Submission
        String checkSb="select abstract as status from projectDesc where teamCode='"+teamCode+"';";
        ps=con.prepareStatement(checkSb);    
        check=ps.executeQuery();
        
        if(check.next()){
            out.print(check.getString("status"));
            if(check.getString("status")!=null){
                out.print("<script>window.location='codeSubmission.jsp?team="+teamCode+"';</script>");
            }
        }
        else{
            out.print("<script>alert('Submission not allowed...\\nDate Expired');window.location='stdHome.jsp';</script>");
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

    <%
    
            String domain=null,pstmt=null,desc=null;
        try
        {

            ps=con.prepareStatement("select * from  projectDesc where teamCode = '"+teamCode+"';");
            ResultSet rs=ps.executeQuery(); 
            while(rs.next())
            {
                domain = rs.getString("domain");
                pstmt = rs.getString("pstmt");
                desc = rs.getString("descPs");

            }

        }
        catch(Exception e){
            out.println("<script>alert('"+e+"')</script>");
        }
    %>

       <div class="container p-5 shadow my-5">
        <h2 style="text-align: center;">Problem Statement Submission  
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
     <hr class="mb-4">
    <div class="modal-body">
        <div class="container" style="border:1px solid #cecece; background-color: rgb(252, 252, 252); width: 70%;">
            <br>

            <form action="abstract.jsp" method="POST" enctype = "multipart/form-data">
                <div class="form-group">
                    <label for="dmn">Domain:</label>
                    <input type="text" class="form-control" value=<%= domain %> id="dmn" placeholder="disabled input" disabled>
                </div>
                <div class="form-group">
                    <label for="ps">Problem Statement:</label>
                    <input type="text" class="form-control" id="ps" value=<%=pstmt%> placeholder="disabled input" disabled>
                </div>
                <div class="form-group">
                    <label for="discription">Discription:</label>
                    <textarea class="form-control" rows="5" id="discription"
                    placeholder="disabled input" disabled><%=desc%></textarea>
                </div>

                <div class="form-group">
                    <label for="dmn">Abstract:</label>
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" id="pfile"  name="fileName" placeholder="filename format : abstract.pdf " onchange="return pfileValidation()" / required>
                        <label class="custom-file-label" for="customFile">Choose file</label>
                    </div>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-success" style="text-align: center;">Submit</button>
                </div><br>
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