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
    <title>Home</title>

    <!-- external css -->
    <link rel="stylesheet" href="../css/home.css">

</head>

<body>

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

                        <a class="dropdown-item" href="#" data-toggle="modal" data-target="#joinTeamModal">
                            <i class="fa fa-users"></i>
                            Join Team
                        </a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#" data-toggle="modal" data-target="#createTeamModal">
                            <i class="fa fa-user-plus"></i>
                            Create Team
                        </a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#" data-toggle="modal" data-target="#leaveTeamModal">
                            <i class="fa fa-sign-out"></i>
                            Leave Team
                        </a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#" data-toggle="modal" data-target="#deleteTeamModal">
                            <i class="fa fa-trash"></i>
                            Delete Team
                        </a>
                    </div>
                </li>
            </ul>
        </div>
        <!--Notification
        -->
        <div style="margin-right:20px;">
            <ul class="navbar-nav">
                <li class="nav-item dropdown" style="font-size: 18px;">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="fa fa-bell" aria-hidden="true"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right" style="width:500px;" aria-labelledby="navbarDropdown">

                     <% 
                                    try{
                                        enroll=(String)session.getAttribute("user");
                                        
                                        String fetchClass="select class as studclass from student where enroll='"+enroll+"';";
                                        ps=conn.prepareStatement(fetchClass);
                                        ResultSet rs=ps.executeQuery();
                                        String Studclass=null;
                                        
                                        if(rs.next())
                                        	Studclass=rs.getString("studclass");
                                        else
                                        	out.println("<script>alert('Data Not Found')</script>");
                                        	
                                        String fetchNotification="select notify,purpose,date,subjectName from notification where class='"+Studclass+"' || teamcode in(select teamCode from studentTeams where enroll='"+enroll+"') order by date desc";
                                        ps=conn.prepareStatement(fetchNotification);
                                        ResultSet r=ps.executeQuery();
                                        while(r.next()){
                                            out.println("<a class='dropdown-item' data-toggle='modal'><b>"+r.getString("subjectName")+"</b><div class='text-primary'>"+r.getString("purpose")+"</div><br>"+r.getString("notify")+"<br><small style='float:right'>"+r.getString("date")+"</small><br></a><div class='dropdown-divider'></div>");
                        
                                        }
                                    }
                                    catch(Exception e){
                                        out.println("<script>alert('"+e+"')</script>");
                                    }
                            
                                %>
    
                    </div>
                </li>
            </ul>
        </div>
        <!-- End notification-->

        <div class="profile mr-1">
            <div id="user">
                <span>hi , 
                    <% 
                    if(session.getAttribute("user")==null)
                        response.sendRedirect("../index.html");
                    else   
                        out.print(session.getAttribute("user"));
                    %>
                <i class="fa fa-user-circle-o px-2" > </i></span>
            </div>
            <div id="userMenu">
                <a href="./logout.jsp">LogOut</a>
                <a data-toggle="modal" data-target="#updateClassModal">My profile</a>
            </div>
        </div>
        <!-- </div> -->
    </nav>


    <!-- Modal for taking join team data -->
    <div class="modal fade" id="joinTeamModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Join Team</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="inputTeamCode">Team code</label>
                            <input type="text" name="joinCode" class="form-control" id="inputTeamCode" required>
                        </div>
                        <hr>
                        <button type="submit" name="joinTeam" class="btn btn-outline-primary col-sm-3">Join</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for taking leave team data -->
    <div class="modal fade" id="leaveTeamModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Leave Team</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="inputTeamCode">Team code</label>
                            <input type="text" name="leaveCode" class="form-control" id="inputTeamCode" required>
                        </div>
                        <hr>
                        <button type="submit" name="leaveTeam" class="btn btn-outline-primary col-sm-3">Leave</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for taking delete team data -->
    <div class="modal fade" id="deleteTeamModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Delete Team</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="inputTeamCode">Team code</label>
                            <input type="text" name="deleteCode" class="form-control" id="inputTeamCode" required>
                        </div>
                        <hr>
                        <button type="submit" name="deleteTeam" class="btn btn-outline-primary col-sm-3">Delete</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!--Modal for updating class-->
    <div class="modal fade" id="updateClassModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Update profile</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="inputTeamCode">Enroll</label>
                            <input type="text" name="enroll" class="form-control" id="enroll" value= <%=enroll%> readonly>
                        </div>
                        <div class="form-group">
                            <label for="inputTeamCode">Class</label>
                             <select class="form-control" id="class" name="class">
                                <option value="FE">FE</option>
                                <option value="SE">SE</option>
                                <option value="TE">TE</option>
                                <option value="BE">BE</option>
                           </select>
                        </div>
                        <hr>
                        <button type="submit" name="updateClass" class="btn btn-outline-primary col-sm-3">Update</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for taking create team data -->
    <div class="modal fade" id="createTeamModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Create Team</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="fileUploader.jsp" method="post" enctype="multipart/form-data">

                        <div class="form-group">
                            <label for="inputTeamName">Team name</label>
                            <input type="text" name="teamName" class="form-control" id="inputTeamName" minLength="3">
                        </div>

                        <div class="form-group">
                            <label for="noOfMembers">No of members</label>
                            <input type="number" name="noOfMembers" class="form-control" id="noOfMembers">
                        </div>

                        <div class="form-group">
                            <label for="projectName">Project name</label>
                            <input type="text" name="prjName" class="form-control" id="projectName" minLength="3">
                        </div>

                        <div class="form-group">
                            <label for="subjectNC">Subject</label>
                            <select name="subjectData" id="subjectNC" class="form-control">
                                <% 
                                    try{
                                        String fetchSubject="select subjectName,subjectCode from subject";
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
                            <label for="inputInstructor">Instructor</label>
                            <select name="instructorName" id="inputInstructor" class="form-control">
                                <% 
                                    try{
                                        String fetchInst="select fname,lname,instructorId from instructor";
                                        ps=conn.prepareStatement(fetchInst);
                                        ResultSet rs=ps.executeQuery();

                                        while(rs.next()){
                                            out.println("<option value='"+rs.getString("instructorId")+"'>"+rs.getString("fname")+" "+rs.getString("lname")+"</option>");
                                        }
                                    }
                                    catch(Exception e){
                                        out.println("<script>alert('"+e+"')</script>");
                                    }
                            
                                %>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="discription">Team logo</label>
                            <div class="custom-file">
                                <input type="file" class="custom-file-input" id="teamLogo" name="teamLogo"
                                    onchange="return fileValidation()" / required>
                                <label class="custom-file-label" for="customFile">Choose file</label>
                            </div>
                            <small class="text-danger">File format must be .png , .jpg , .jpeg , .ico , .svg</small>
                        </div>

                        <!-- <div class="form-group">
                            <label for="teamLogo">Team logo</label>
                            <input type="file" class="form-control-file" name="teamLogo" id="teamLogo" align="right">
                        </div> -->

                        <hr>
                        <button type="submit" name="createTeam" class="btn btn-outline-primary col-sm-3">Create</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- displaying teams of student -->
    <div class="container p-5 my-4 shadow">
        <h2 style="margin-left: 22px;font-weight:bold;"><i class="fa fa-users mx-2"></i>Teams</h2>
        <hr>
        <%
            try{
                String fetch="select teamName,projectName,getSubjectName(subjectCode) as subject,pstStatus(teamCode) as status,teamCode,teamLogoName,getCardStatus(teamCode) as border from teams where teamCode in (select teamCode from studentTeams where enroll='"+enroll+"') order by teamName desc";
                ps=conn.prepareStatement(fetch);
                ResultSet rs=ps.executeQuery();
                
                while(rs.next()){
                    out.println("<div class='card my-3 shadow "+rs.getString("border")+"'  style='border-width: 3px;'><h5 class='card-header' id='"+rs.getString("teamCode")+"' onclick='setTeamVal(this)'>Team Name - "+rs.getString("teamName")+"<img src='../TeamLogo/"+rs.getString("teamLogoName")+"' alt='logo' width='35' height='35' align='right' style='margin-right: 20px;'></h5><ul class='list-group'><li class='list-group-item'> Subject - "+rs.getString("subject") +"</li><li class='list-group-item'> Project name - "+rs.getString("projectName")+"</li><li class='list-group-item'>Team Code - <span  title='click to copy' id='"+ rs.getString("teamCode")+"Copy' onclick='setData(this)'>"+ rs.getString("teamCode")+"</span></li><li class='list-group-item'>"+rs.getString("status")+"</li></ul></div>");
                }

            }catch(Exception e){
                out.println("<script>alert('"+e.getMessage()+"')</script>");
            }
        %>

    </div>


    <script>
        function setTeamVal(team) {
            console.log(team.id);
            window.location="submitPs.jsp?team="+team.id;
        }


        function setData(temp){
            const data=temp.id;
            var textArea=document.createElement("textarea");
            textArea.value=document.getElementById(data).innerText;
            document.body.appendChild(textArea);
            textArea.select();
            document.execCommand("Copy");
            textArea.remove();
        }
    </script>

    <!-- JSP -->
    <%
        //Check form is submitted 
        int checkInsert=0;
        int checkM=0,checkC=0;
        ResultSet rs=null;
        if(request.getParameter("joinTeam")!=null){
            try{
                String joinCode=request.getParameter("joinCode");
                String insertData="insert into studentTeams values(?,?)";

                String checkMembers="select noOfMembers from teams where teamCode='"+joinCode+"'";
                ps=conn.prepareStatement(checkMembers);

                rs=ps.executeQuery();
                if(rs.next()){
                    checkM=rs.getInt("noOfMembers");
                }

                String checkCount="select count(enroll) as count from studentTeams where teamCode='"+joinCode+"'";
                ps=conn.prepareStatement(checkCount);

                rs=ps.executeQuery();
                if(rs.next()){
                    checkC=rs.getInt("count");
                }

                if(checkC>=checkM){
                    out.println("<script>alert('No of members exceeded...')</script>");
                }
                else{

                    ps=conn.prepareStatement(insertData);
                    ps.setString(1,enroll);
                    ps.setString(2,joinCode);

                    checkInsert=ps.executeUpdate();

                        if(checkInsert==0)
                            out.println("<script>alert('Failed...')</script>");
                        else{
                            response.setStatus(response.SC_MOVED_TEMPORARILY);
                            response.setHeader("Location", "stdHome.jsp");
                        }
                }
            }
            catch(Exception e){
                out.println("<script>alert('Team not found...')</script>");
            }
        }

        if(request.getParameter("leaveTeam")!=null){
            try{
                String leaveCode=request.getParameter("leaveCode");
                String deleteData="delete from studentTeams where enroll=? and teamCode=?;";
                ps=conn.prepareStatement(deleteData);
                ps.setString(1,enroll);
                ps.setString(2,leaveCode);

                checkInsert=ps.executeUpdate();

                    if(checkInsert==0)
                        out.println("<script>alert('Failed...')</script>");
                    else{
                        response.setStatus(response.SC_MOVED_TEMPORARILY);
                        response.setHeader("Location", "stdHome.jsp");
                    }

            }
            catch(Exception e){
                out.println("<script>alert('Failed..')</script>");
            }
        }
        int checkUpdate=0;
        if(request.getParameter("updateClass")!=null){
            try{
                String studClass=request.getParameter("class");
                String updateData="update student set class=? where enroll=?;";
                ps=conn.prepareStatement(updateData);
                ps.setString(2,enroll);
                ps.setString(1,studClass);

                checkUpdate=ps.executeUpdate();

                    if(checkUpdate==0)
                        out.println("<script>alert('Failed...')</script>");
                    else{
                        response.setStatus(response.SC_MOVED_TEMPORARILY);
                        response.setHeader("Location", "stdHome.jsp");
                    }

            }
            catch(Exception e){
                out.println("<script>alert('Failed..')</script>");
            }
        }

        int checkDelete=0;
        if(request.getParameter("deleteTeam")!=null){
            try{
                String deleteCode=request.getParameter("deleteCode");
           
                String deleteData="delete from studentTeams where teamCode=? and enroll=?";
                ps=conn.prepareStatement(deleteData);
                ps.setString(1,deleteCode);
                ps.setString(2,enroll);

                ps.executeUpdate();
                String deleteTeamData="delete from teams where enroll=? and teamCode=?;";
                ps=conn.prepareStatement(deleteTeamData);
                ps.setString(1,enroll);
                ps.setString(2,deleteCode);
                
                checkDelete=ps.executeUpdate();
                if(checkDelete==0)
                    out.println("<script>alert('Failed...')</script>");
                else{
                    response.setStatus(response.SC_MOVED_TEMPORARILY);
                    response.setHeader("Location", "stdHome.jsp");
                }

            }
            catch(Exception e){
                out.println("<script>alert('Failed....')</script>");
            }
        }

        /*

        String team=request.getParameter("team");

        if(team!=null){
            String checkStatus="select * from"
        }*/
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
