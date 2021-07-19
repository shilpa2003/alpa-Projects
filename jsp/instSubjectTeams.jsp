<html lang="en">
<head>
    <!-- JSP importing package -->
    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*,java.util.*,java.text.*,java.util.Date"%>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- font awesome cdn -->
    <script src="https://use.fontawesome.com/56030c5688.js"></script>

    <!-- bootstrap stylesheet -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
        integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    
    <link rel="icon" href="../favicon.ico">    

    <!-- external css -->
    <link rel="stylesheet" href="../css/home.css">
    <title>Home</title>
    
</head>

<body>

    <%-- JSP connecting to db --%>
    <%
        PreparedStatement ps=null;
        Connection conn=null;
        String instructorId=null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/miniPrj","java1","ironman@3"); 
            instructorId=(String)session.getAttribute("user");
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


    <!-- displaying teams of student -->
    <div class="container p-5 my-4 shadow">
        <h2 style="margin-left: 22px;font-weight:bold;"><i class="fa fa-users mx-2"></i>Teams</h2>
        <hr>
         <%
            try{
                String fetch="select teamName,projectName,getSubjectName(subjectCode) as subject,teamCode,teamLogoName,pstStatus(teamCode) as status,getCardStatus(teamCode) as border from teams where instructorId='"+instructorId+"' and subjectCode='"+request.getParameter("subjectCode")+"';";
                ps=conn.prepareStatement(fetch);
                ResultSet rs=ps.executeQuery();
                
                while(rs.next()){
                    out.println("<div class='card my-3 shadow "+rs.getString("border")+"' onclick='setTeamVal(this)' id='"+rs.getString("teamCode")+"'><h5 class='card-header'>Team Name - "+rs.getString("teamName")+"<img src='../TeamLogo/"+rs.getString("teamLogoName")+"' alt='logo' width='35' height='35' align='right' style='margin-right: 20px;'></h5><ul class='list-group'><li class='list-group-item'> Subject - "+rs.getString("subject") +"</li><li class='list-group-item'> Prject name - "+rs.getString("projectName")+"</li><li class='list-group-item'>Team Code - "+ rs.getString("teamCode")+"</li><li class='list-group-item'>"+rs.getString("status")+"</li></ul></div>");
                }

            }catch(Exception e){
                out.println("<script>alert('"+e+"')</script>");
            }
        %>
        
    </div>

    <script>
        function setTeamVal(team) {
            console.log(team.id);
            window.location="pstApprover.jsp?team="+team.id;
        }
    </script>

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