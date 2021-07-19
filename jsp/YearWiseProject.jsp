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
    <link rel="stylesheet" href="../css/YearWiseProject.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <title>YearWiseProject</title>
</head>


<body>
 <%
    try
    {
     Class.forName("com.mysql.jdbc.Driver");
     Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/miniPrj","java1","ironman@3");
     //Connection con=DriverManager.getConnection("jdbc:mysql://bmfqadeaynicb7pn4izx-mysql.services.clever-cloud.com:3306/bmfqadeaynicb7pn4izx","uf3zyddfyt288imy","Jwc5yfLdhT7eSsWYsuc3");
     PreparedStatement ps;
     ResultSet rs;
 %>

    <!-- Navbar / Header of website -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <!-- <div class="container px-5 py-2"> -->
        <a class="navbar-brand text-primary" href="#" style="font-size: 25px;">
            <i class="fa fa-cloud-upload fa-lg" aria-hidden="true" style="margin:5px; margin-right: 5px;"></i>
            Alpha Projects</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
    </nav>
    <br>


    <!-- displaying teams of student -->

    <div class="container p-5 my-4 shadow">

    <h2 style="text-align: center;"><i class="fa fa-cube primary mx-2" aria-hidden="true"></i> Projects</h2><hr>
    <%  
     ps=con.prepareStatement("select count(*) as countPrj from displayPrj where report!='';");
     rs=ps.executeQuery();  
     rs.next();
     String tot=rs.getString("countPrj");
    %>
    <div style="padding-left:100px;padding-right:100px;">
    <p class="text-info" style="padding:5px"> * Their are total <%=tot%> projects in our system</p>
    <hr>
    <div class="modal-body">

    <%  
      ps=con.prepareStatement("select pstmt,report,domain,prjAssignDate from displayPrj where report!='';");
      rs=ps.executeQuery();  
     while(rs.next())
     {
     String report=rs.getString("report");
     String pstmt=rs.getString("pstmt");
     String domain=rs.getString("domain");
     String prjAssignDate=rs.getString("prjAssignDate");
    %>
            <form>
                <div class="card" style="width:100%;">
                <div class="card-header text-primary">
                     <%=domain%>
                     <div style="float:right" class="text-secondary"><%=prjAssignDate%></div>
                </div>
                <ul class="list-group list-group-flush">
                  <li class="list-group-item"><%=pstmt%> </li>
                  <li class="list-group-item">
                    <a href="#" style="float: right;" onclick="window.open('../team/<%=report%>', '_blank', 'fullscreen=yes'); return false;">View Project Report <i class="fa fa-eye fa-lg" ></i></a>
                  </li>
                </ul>
                </div>
            </form>
            <br>
    <%
    }           
    con.close();
    }
    catch(Exception e)
    {
         out.println(e);
    }    
%>
    </div>
    </div>
    </div>

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