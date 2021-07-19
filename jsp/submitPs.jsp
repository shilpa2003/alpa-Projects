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
    <title>Problem Statement</title>

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

            //check Dates
            String checkDt="select dateValidator(?) as dateStatus;";
            ps=con.prepareStatement(checkDt); 
            ps.setString(1,teamCode);
            ResultSet check=ps.executeQuery();   
            if(check.next()){
                if("ProblemStatement Submission Date Is Expired..".equals(check.getString("dateStatus"))){
                    out.print("<script>window.location='afterApprove.jsp?team="+teamCode+"';</script>");
                }
            }

            //check ps Submission
            String checkSb="select PsStatus as status from projectDesc where teamCode='"+teamCode+"';";
            ps=con.prepareStatement(checkSb);    
            check=ps.executeQuery();
            
            if(check.next()){
                if("Problem Statement Accepted".equals(check.getString("status"))){
                    out.print("<script>window.location='afterApprove.jsp?team="+teamCode+"';</script>");
                }
                else if("Problem Statement Submitted".equals(check.getString("status"))){
                    out.print("<script>alert('Problem statement is submitted...\\nwaiting for approval\\n');window.location='stdHome.jsp';</script>");
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
        <a class="navbar-brand text-primary" href="instructorHome.jsp" style="font-size: 25px;">
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
        <h2 style="text-align: center;">Problem Statement Submission  
            <span style="font-size:13px;">
    <% 
        try
        {
            String getDate="select problemStatementDate as date from assignPrj where subjectCode=(select subjectCode from teams where teamCode='"+teamCode+"');";
            ps=con.prepareStatement(getDate);    
            ResultSet d=ps.executeQuery();
            
            if(d.next()){
                out.print("#deadline : "+d.getString("date"));    
            }

        }catch(Exception e){
            out.println("<script>alert('"+e+"')</script>");
        }
    %>
        </span></h2>
     <hr class="mb-4">
    <div class="modal-body">
        <div class="container" style="border:1px solid #cecece; background-color: rgb(245, 245, 245); width: 70%;">
            <br>

            <form method="POST">
                <div class="form-group">
                    <label for="dmn">Domain:</label>
                    <input type="text" name="domain" class="form-control" id="dmn" placeholder="enter the domain"  onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || (event.charCode==32)" / maxlength="100" autocomplete="off" required>
                </div>
                <div class="form-group">
                    <label for="ps">Problem Statement:</label>
                    <input type="text" name="ps" class="form-control" id="ps" placeholder="enter the problem statement" onkeypress="return (event.charCode > 64 && event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || (event.charCode==32)" / maxlength="100" autocomplete="off" required>
                </div>
                <div class="form-group">
                    <label for="discription">Discription:</label>
                    <textarea class="form-control" rows="5" id="discription"
                        placeholder="enter the description of problem statement" name="desc" maxlength="300" autocomplete="off" required></textarea>
                </div><br>

                <div class="text-center">
                    <button type="submit" name="pstButton" class="btn btn-success" style="text-align: center;">Submit</button>
                </div>
                <br>
            </form>
        </div><br>
    </div>
</div>
<%

 //out.print("<h1>"+teamCode+"</h1>");
if(request.getParameter("pstButton")!=null){


String pstmt=request.getParameter("ps");
String domain=request.getParameter("domain");
String desc=request.getParameter("desc");

try
{

    String checkPs="select * from projectDesc where teamCode='"+teamCode+"';";
    ps=con.prepareStatement(checkPs);
    ResultSet rs=ps.executeQuery();
    
    if(rs.next()){
        ps=con.prepareStatement("update projectDesc set domain=?,pstmt=?,descPs=? where teamCode=?;");
        ps.setString(1,domain);
        ps.setString(2,pstmt);
        ps.setString(3,desc);
        ps.setString(4,teamCode);

        int x=ps.executeUpdate();
        if(x!=-1)
        {
            out.print("<script>alert('Problem statement is submitted...\\nwait for approval\\n');window.location='stdHome.jsp';</script>");
        }
        else
        {
            out.print("<script>alert('Failed...');</script>");   
        }
        
    }
    else{
        ps=con.prepareStatement("insert into  projectDesc(domain,pstmt,descPs,teamCode) values(?,?,?,?);");
        ps.setString(1,domain);
        ps.setString(2,pstmt);
        ps.setString(3,desc);
        ps.setString(4,teamCode);
        int x=ps.executeUpdate();
        if(x!=-1)
        {
            out.print("<script>alert('Problem statement is submitted...\\nwait for approval\\n');window.location='stdHome.jsp';</script>");
        }
        else
        {
            out.print("<script>alert('Failed...');</script>");   
        }
        con.close();
    }
}
catch(Exception e)
{
    out.println(e);
}   
} 
%>

    <!-- external js -->
    <script src="../js/validation.js"></script>
    <!-- bootstrap cdn -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx"
        crossorigin="anonymous"></script>


    <!-- Footer for contact-us -->
    <footer class="page-footer p-4 bg-dark text-light d-print-none" style="position:relative;bottom:0;width:100%;">

        <p class="lead ml-2" style="font-size:18px;"> Contact Us &emsp;
        <div class="col-sm-auto mt-1">
            <i class="fa fa-github fa-lg" aria-hidden="true"></i> Github &emsp;
        </div>
        <div class="col-sm-auto mt-1">
            <i class="fa fa-envelope fa-lg" aria-hidden="true"></i> Gmail
        </div>
        </p>

    </footer>
</body>

</html>