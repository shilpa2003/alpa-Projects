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
    <title>Home</title>

    <!-- external css -->
    <link rel="stylesheet" href="../css/home.css">
    
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
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <!-- <div class="container px-5 py-2"> -->
        <a class="navbar-brand text-primary" href="#" style="font-size: 25px;">
            <i class="fa fa-cloud-upload fa-lg" aria-hidden="true" style="margin:5px; margin-right: 5px;"></i>
            Alpha Projects</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav" style="margin-left: 50px;">
            <ul class="navbar-nav">
                <li class="nav-item dropdown" style="font-size: 18px;">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="fa fa-bars" aria-hidden="true"></i>
                        Menu
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">

                        <a class="dropdown-item" href="#" data-toggle="modal" data-target="#subjectModal">
                            <i class="fa fa-plus"></i>
                            Add Subject
                        </a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#" data-toggle="modal" data-target="#projectModal">
                            <i class="fa fa-plus"></i>
                            Assign Project
                        </a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#" data-toggle="modal" data-target="#updateDeadlineModal">
                            <i class="fa fa-wrench"></i>
                            Update Deadline
                        </a>
                    </div>
                </li>
            </ul>
        </div>
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

    <!-- Modal for taking subject data -->
    <div class="modal fade" id="subjectModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Add subject</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="" method="post">
                        <div class="form-group">
                            <label for="subjectName">Subject name</label>
                            <input type="text" name="subjectName" class="form-control" id="subjectName">
                        </div>
                        <div class="form-group">
                            <label for="subjectCode">Subject code</label>
                            <input type="text" name="subjectCode" class="form-control" id="subjectCode">
                        </div>
                        <hr>
                        <button type="submit" name="subject" class="btn btn-outline-primary col-sm-3">Add</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for taking assign project data -->
    <div class="modal fade" id="projectModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Assign project</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="" method="post">
                        <div class="form-group">
                            <label for="subjectNC">Subject</label>
                            <select name="subjectData" id="subjectNC" class="form-control">
                                <% 
                                    try{
                                        String fetchSubject="select subjectName,subjectCode from subject where instructorId='"+instructorId+"';";
                                        ps=conn.prepareStatement(fetchSubject);
                                        ResultSet rs=ps.executeQuery();

                                        while(rs.next()){
                                            out.println("<option value='"+rs.getString("subjectCode")+"'>"+rs.getString("subjectName")+" "+rs.getString("subjectCode")+"</option>");
                                        }
                                    }
                                    catch(Exception e){
                                        out.println("<script>alert('"+e+"')</script>");
                                    }
                            
                                %>
                            </select>
                        </div>
                        <label for="sClass"> Class</label>
                        <select class="form-control" id="sClass" name="sClass">
                             <option value="FE">FE</option>
                             <option value="SE">SE</option>
                             <option value="TE">TE</option>
                              <option value="BE">BE</option>
                        </select>
                        <div class="form-group">
                            <label for="pstDate">Project starting date</label>
                            <input type="date" name="prjAssignDate" class="form-control" id="pstDate" required>
                        </div>
                        <div class="form-group">
                            <label for="pstDate">Problem statement deadline</label>
                            <input type="date" name="pstDate" class="form-control" id="pstDate" required>
                        </div>
                        <div class="form-group">
                            <label for="codeDate">Code Submission deadline</label>
                            <input type="date" name="codeSbDate" class="form-control" id="codeDate" required>
                        </div>
                        <hr>
                        <button type="submit" name="assignPrj" class="btn btn-outline-primary col-sm-3">Assign</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for updating deadline -->
    <div class="modal fade" id="updateDeadlineModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Update Deadline</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="alert alert-danger" role="alert" style="font-size:14px;">
                        Add date to required fields , Rest field are not required to be filled...
                    </div>
                    <hr>
                    <form action="" method="post">
                         <div class="form-group">
                            <label for="subjectNC">Subject</label>
                            <select name="updateSubjectData" id="subjectNC" class="form-control">
                                <% 
                                    try{
                                        String fetchSubject="select subjectName,subjectCode from subject where instructorId='"+instructorId+"';";
                                        ps=conn.prepareStatement(fetchSubject);
                                        ResultSet rs=ps.executeQuery();

                                        while(rs.next()){
                                            out.println("<option value='"+rs.getString("subjectCode")+"'>"+rs.getString("subjectName")+" "+rs.getString("subjectCode")+"</option>");
                                        }
                                    }
                                    catch(Exception e){
                                        out.println("<script>alert('"+e+"')</script>");
                                    }
                            
                                %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="pstDate">Project starting date</label>
                            <input type="date" name="updatePrjAssignDate" class="form-control" id="pstDate" >
                        </div>
                        <div class="form-group">
                            <label for="pstDate">Problem statement deadline</label>
                            <input type="date" name="updatePstDate" class="form-control" id="pstDate" >
                        </div>
                        <div class="form-group">
                            <label for="codeDate">Code Submission deadline</label>
                            <input type="date" name="updateCodeSbDate" class="form-control" id="codeDate" >
                        </div>
                        <hr>
                        <button type="submit" name="updateDeadline" class="btn btn-outline-primary col-sm-3">Update</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- displaying current projects under subject -->
    <div class="container my-4 p-5 shadow">
        <h2 style="margin-left: 20px;font-weight:bold;"><i class="fa fa-cube primary mx-2" aria-hidden="true"></i>Assigned Projects</h2>
        <hr>
        <%
            try{
                String fetch="select getSubjectName(subjectCode) as subject,subjectCode,prjAssignDate,problemStatementDate,codeSubmissionDate,teamCount(subjectCode) as teamCount from assignPrj where instructorId='"+instructorId+"';";
                ps=conn.prepareStatement(fetch);
                ResultSet rs=ps.executeQuery();
                
                while(rs.next()){
                    out.println("<div class='card my-3 shadow' ><h5 class='card-header text-primary' id='"+rs.getString("subjectCode")+"' onclick='setSubjectVal(this)'>Subject Name - "+rs.getString("subject")+"</h5><ul class='list-group'><li class='list-group-item text-success'>Teams Enrolled - "+ rs.getString("teamCount")+" </li><li class='list-group-item text-primary'>Project start date - "+rs.getString("prjAssignDate")+"</li><li class='list-group-item text-danger'>Problem statement deadline date - "+rs.getString("problemStatementDate")+"</li><li class='list-group-item text-danger'>Code submission deadline date - "+rs.getString("codeSubmissionDate")+"</li></ul></div>");
                }

            }catch(Exception e){
                out.println("<script>alert('"+e+"')</script>");
            }
        %>
    
    </div>

    <!-- displaying current projects for review -->
    <div class="container my-4 p-5 shadow">
        <h2 style="margin-left: 20px;font-weight:bold;"><i class="fa fa-cube primary mx-2" aria-hidden="true"></i>Projects For Review</h2>
        <hr>
        <%
            try{
                String fetch="select teamName,projectName,getSubjectName(subjectCode) as subject,pstStatus(teamCode) as status,teamCode,teamLogoName from teams where teamCode in (select teamCode from reviewer where reviewer='"+instructorId+"')";
                ps=conn.prepareStatement(fetch);
                ResultSet rs=ps.executeQuery();
                
                while(rs.next()){
                    out.println("<div class='card my-3 shadow'  ><h5 class='card-header text-primary' id='"+rs.getString("teamCode")+"' onclick='setReviewVal(this)' >Team Name - "+rs.getString("teamName")+"<img src='../TeamLogo/"+rs.getString("teamLogoName")+"' alt='logo' width='35' height='35' align='right' style='margin-right: 20px;'></h5><ul class='list-group'><li class='list-group-item'> Subject - "+rs.getString("subject") +"</li><li class='list-group-item'> Prject name - "+rs.getString("projectName")+"</li><li class='list-group-item'>Team Code - "+ rs.getString("teamCode")+"</li><li class='list-group-item'>"+rs.getString("status")+"</li></ul></div>");
                }

            }catch(Exception e){
                out.println("<script>alert('"+e+"')</script>");
            }
        %>
    
    </div>

    <script>
        function setSubjectVal(subject) {
            console.log(subject.id);
            window.location="instSubjectTeams.jsp?subjectCode="+subject.id;   
             
        }

        function setReviewVal(team) {
            console.log(team.id);
            window.location="viewProjectReviewer.jsp?team="+team.id;   
             
        }
        // var url=new URL(window.location.href);
        // console.log(url.searchParams.get("id"));
    </script>

    <!-- JSP -->
    <%
        //Check form is submitted 
        int checkInsert=0;

        //subject form
        if(request.getParameter("subject")!=null){
            try{

                String subjectName=request.getParameter("subjectName");
                String subjectCode=request.getParameter("subjectCode");

                String checkSubject="select * from subject where subjectCode='"+subjectCode+"'";
                ps=conn.prepareStatement(checkSubject);
                ResultSet check=ps.executeQuery();

                //duplicate subject
                if(check.next()){
                    out.print("<script>alert('Subject already available....');</script>");
                }
                else{
                    String insertSubjectData="insert into subject values(?,?,?)";
        
                    ps=conn.prepareStatement(insertSubjectData);
                    ps.setString(1,instructorId);
                    ps.setString(2,subjectName);
                    ps.setString(3,subjectCode);

                    checkInsert=ps.executeUpdate();
                    if(checkInsert==0)
                        out.println("<script>alert('Failed...')</script>");

                        response.setStatus(response.SC_MOVED_TEMPORARILY);
                        response.setHeader("Location", "instructorHome.jsp");
                }
            }
            catch(Exception e){
                out.println("<script>alert('"+e.getMessage()+"')</script>");
            }
        }

        //project assign form
        if(request.getParameter("assignPrj")!=null){
             try{

                String subjectData=request.getParameter("subjectData");
                String prjAssignDate=new String(request.getParameter("prjAssignDate"));
                String pstDate=new String(request.getParameter("pstDate"));
                String codeSbDate=new String(request.getParameter("codeSbDate"));
                String sClass=request.getParameter("sClass");

                String insertData="insert into assignPrj values(?,?,?,?,?,?)";
                ps=conn.prepareStatement(insertData);
                ps.setString(1,instructorId);
                ps.setString(2,subjectData);
                ps.setString(3,prjAssignDate);
                ps.setString(4,pstDate);
                ps.setString(5,codeSbDate); 
                ps.setString(6,sClass);               

                checkInsert=ps.executeUpdate();
                if(checkInsert==0)
                    out.println("<script>alert('Failed...')</script>");
                else{
                    response.setStatus(response.SC_MOVED_TEMPORARILY);
                    response.setHeader("Location", "instructorHome.jsp");
                }    

             }
             catch(Exception e){
                out.println("<script>alert('"+e.getMessage()+"')</script>");
            }
        }

            //update deadline form
            if(request.getParameter("updateDeadline")!=null){
             try{

                String updateSubjectData=request.getParameter("updateSubjectData");
                String updatePrjAssignDate=new String(request.getParameter("updatePrjAssignDate"));
                String updatePstDate=new String(request.getParameter("updatePstDate"));
                String updateCodeSbDate=new String(request.getParameter("updateCodeSbDate"));

                String updateDeadline="update assignPrj set ";

                if(!updatePrjAssignDate.equals("")){
                    updateDeadline=updateDeadline+"prjAssignDate='"+updatePrjAssignDate+"',";
                }

                if(!updatePstDate.equals("")){
                    updateDeadline=updateDeadline+"problemStatementDate='"+updatePstDate+"',";
                }

                if(!updateCodeSbDate.equals("")){
                    updateDeadline=updateDeadline+"codeSubmissionDate='"+updateCodeSbDate+"',";
                }

                updateDeadline=updateDeadline.substring(0,updateDeadline.length() - 1)+" where subjectCode='"+updateSubjectData+"';";


                //out.println(updateDeadline);

                ps=conn.prepareStatement(updateDeadline);                

                checkInsert=ps.executeUpdate();
                if(checkInsert==0)
                    out.println("<script>alert('Failed...')</script>");
                else{
                    response.setStatus(response.SC_MOVED_TEMPORARILY);
                    response.setHeader("Location", "instructorHome.jsp");
                }

             }
             catch(Exception e){
                out.println("<script>alert('"+e.getMessage()+"')</script>");
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