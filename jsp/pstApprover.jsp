<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*,java.util.*, java.io.*,java.lang.*" %>

<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- font awesome cdn -->
    <script src="https://use.fontawesome.com/56030c5688.js"></script>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
        integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    
        <link rel="icon" href="../favicon.ico">    

    <!-- external css -->
    <link rel="stylesheet" href="../css/home.css">

    <title>PS Approver</title>

</head>

<body>

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

    <%
                
                String teamcode=request.getParameter("team");
                //out.print(teamcode);
                Connection con=null;
                PreparedStatement ps=null;
                String pstmt=null;
                try
                {
                Class.forName("com.mysql.jdbc.Driver");
                con=DriverManager.getConnection("jdbc:mysql://localhost:3306/miniPrj","java1","ironman@3");   
                  ps=con.prepareStatement("select descPs,pstmt,code from projectDesc where teamCode='"+teamcode+"';");
                 ResultSet rs2=ps.executeQuery();  
                 if(!rs2.next()){
                     out.print("<script>alert('Problem statement is not submitted...');window.history.back();</script>");
                 }
                 else{
                     pstmt=rs2.getString("pstmt");
                     if(rs2.getString("code")!=null){
                         out.print("<script>window.location='viewProject.jsp?team="+teamcode+"';</script>");
                     }
                 }
                 
       
               %>
    <div class="container p-5 shadow"
        style="border:1px solid #cecece; background-color: rgb(245, 245, 245); width: 70%; margin-top: 30px;">
        <h4><%=pstmt%></h4>
        <hr><br>

        <div class="modal-body">
            <form method="post">
                <%
                    ps=con.prepareStatement(" select enroll,fname from student where enroll in(select enroll from studentTeams where teamcode ='"+teamcode+"');");
                    ResultSet rs=ps.executeQuery(); 
                    while(rs.next())
                    {
                    String roll = rs.getString("enroll");
                    String name = rs.getString("fname");
                %>

                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="name">Name of Student</label>
                        <input type="text" class="form-control" id="name" value=<%=name%> disabled>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="eno">Enroll no.</label>
                        <input type="text" class="form-control" id="eno" value=<%=roll%> disabled>
                    </div>
                </div><br>
                <%
                    }
                    String Desc=rs2.getString("descPs");
                %>

                <div class="form-group">
                    <label for="psd">Problem Statement Description:</label>
                    <textarea class="form-control" id="psd" rows="3" disabled><%=Desc%></textarea>
                </div><br>
                <%
                    }
                    catch(SQLException sqe)
                    {
                    out.println(sqe);
                    }
    
                %>
                <label for="status">I have verified your problem statement you can further proceed with your statement
                </label>
                <div float="left">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1"
                            value="option1">
                        <label class="form-check-label" for="inlineRadio1">YES</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2"
                            value="option2">
                        <label class="form-check-label" for="inlineRadio2">NO</label>
                    </div>
                </div>
                <br>
                <div class="form-group">
                    <label for="discription">Suggestion :</label>
                    <textarea class="form-control" rows="5" id="discription" placeholder="..." name="suggestion"
                        maxlength="300" autocomplete="off" required></textarea>
                </div><br>
                <br>
                <div class="text-center">
                    <button type="submit" name="accept" class="btn btn-success"
                        style="text-align: center;">SUBMIT</button>
                </div><br>
            </form>
        </div>
    </div><br>

    <%

        if(request.getParameter("accept")!=null){
                String Psstatus;
                if(request.getParameter("inlineRadioOptions").equals("option1"))
                    Psstatus="Problem Statement Accepted";
                else
                    Psstatus="Problem Statement Rejected";

                try
                {
                    String sugg=request.getParameter("suggestion");
                    ps=con.prepareStatement("update  projectDesc set PsStatus=(?),suggestion=(?) where teamCode='"+teamcode+"';");
                    ps.setString(1,Psstatus);
                    ps.setString(2,sugg);
                    int x=ps.executeUpdate();
                    if(x!=-1)
                    {
                        out.print("<script>alert('Status Updated...');window.location='instructorHome.jsp';</script>");   
                    }
                    else
                    {
                        out.print("<script>alert('Failed...');</script>");   
                    }
                }
                catch(Exception e)
                {
                    out.println(e);
                }    
        }

    %>
    <!-- bootstrap cdn -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx"
        crossorigin="anonymous"></script>

    <!-- Footer for contact-us -->
    <footer class="page-footer p-4 bg-dark text-light d-print-none" style="position:relative;bottom:0;width:100%;">
        <p class="lead"> Contact Us : &emsp;
            <i class="fa fa-github fa-lg" aria-hidden="true"></i> Github &emsp;
            <i class="fa fa-envelope fa-lg" aria-hidden="true"></i> Gmail
        </p>
    </footer>
</body>

</html>