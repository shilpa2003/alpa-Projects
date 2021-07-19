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
    <title>Project View</title>

    <!-- external css -->
    <link rel="stylesheet" href="../css/home.css">


    <script type="text/javascript">
            function openTab(th)
            {
                window.open(th.name,'_blank');
            }
    </script>
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
    Connection con=null;
    try
    {
     Class.forName("com.mysql.jdbc.Driver");
     con=DriverManager.getConnection("jdbc:mysql://localhost:3306/miniPrj","java1","ironman@3"); 
     PreparedStatement ps1=con.prepareStatement("select pstmt,output,report from projectDesc where teamcode='"+teamcode+"';");
     ResultSet rs1=ps1.executeQuery();  
     if(!rs1.next()){
        out.print("<script>alert('Code not submitted...');window.history.back();</script>");
     }
     String pstmt=rs1.getString("pstmt");
     String fileoutput=rs1.getString("output");
     String report=rs1.getString("report");
     session.setAttribute("team",teamcode);
     %>

     
     <div class="container p-5 shadow my-5">
    <h2 style="text-align: center;"><%=pstmt%></h2>
        <hr>
    <div class="modal-body">
                <!-- Auto width -->
                
                <div >
                    <span id="download1" onclick="router(this)" style="cursor: pointer;"><i class="fa fa-download"></i> &emsp; Download Project Code</span>
                </div>
                <hr>
                 <div>
                    <span id="download2" onclick="router(this)" style="cursor: pointer;"><i class="fa fa-download"></i> &emsp; Download Project Output</span>
                    <a href="#" style="padding-left: 100px;" onclick="window.open('../team/<%=fileoutput%>', '_blank', 'fullscreen=yes'); return false;"><i class="fa fa-eye fa-lg" ></i></a>
                    
                </div>
                <hr>
                <div >
                    <span id="download1" onclick="router(this)" style="cursor: pointer;"><i class="fa fa-download"></i> &emsp; Download Project Report</span>
                    <a href="#" style="padding-left: 100px;" onclick="window.open('../team/<%=report%>', '_blank', 'fullscreen=yes'); return false;"><i class="fa fa-eye fa-lg" ></i></a>
                </div>

                <hr>
                <br>
                <%-- <div class="row ml-3"><h3>#Reviewer Handler</h3></div> --%>
                <hr>
                <form class="form-inline" method="post">
                    <div class="form-group ">
                            <div class="form-group col-md-2.5">
                                <select class="form-control" name="reviewer">
                                 <option value="0"> select the reviewer name</option>
                            <%
                            PreparedStatement ps3=con.prepareStatement("select fname,lname,instructorId from instructor ;");
                            ResultSet rs3=ps3.executeQuery();  
                            while(rs3.next())
                            {
                                String fname=rs3.getString("fname");
                                String lname=rs3.getString("lname");
                                String instId=rs3.getString("instructorId");
                                String name=fname+" "+lname;
    
                            %>
                                <option value= "<%=instId%>"> <%=name%> </option>
                            <% } %>
                                <option value="1">all</option>
                                </select>
                        </div>
                    </div>
                    
                    <div class="form-group mx-2">
                        <button name="add" type="submit" class="form-control btn btn-outline-success mx-1">Add</button>
                        <button name="remove" type="submit" class="form-control btn btn-outline-danger mx-1">Remove</button>
                    </div>

                </form>

                <hr>
                <br>
                <%-- <div class="row ml-3"><h3>#Your view</h3></div> --%>
                <hr>

            <form  method="post">
                <div class="form-group">
                    <label for="marks">Marks:</label>
                    <input type="number" class="form-control col-md-4" id="marks" name="marks" placeholder="add marks" maxlength="3" required>
                </div>
                <hr>
                <div class="form-group ">
                    <label for="discription">Comments:</label>
                    <textarea class="form-control" rows="5" id="discription" placeholder="enter your comments" name="comment" required></textarea>
                </div>
                <div >
                <button type="submit" name="submit" class="btn btn-outline-primary col-md-2" style="text-align: center;">Submit</button><br><br>
                </div>

                <hr>
                <br>
                <div class="row ml-3"><h3>Comments</h3></div>
                <hr>

                <%
        
                PreparedStatement ps2=con.prepareStatement("select comment_by,comment,date from Comment_Table where teamcode='"+teamcode+"' order by date desc;");
                ResultSet rs2=ps2.executeQuery();  
                while(rs2.next())
                {
                String reviewer=rs2.getString("comment_by");
                String comment=rs2.getString("comment");
                String dateC=rs2.getString("date");
                %>
                <div class="card mb-3"  >
                    <div class="row no-gutters">
                      <div class="col-md-1">
                        <span width="100" height="100" style="padding: 10px;" class="fa fa-user-circle-o fa-5x" id="user"> </span>
                      </div>
                      <div class="col-md-11">
                        <div class="card-body">
                          <h5 class="card-title"><%=reviewer%></h5>
                          <p class="card-text"><%=comment%><br>
                          <small style="float:right;"><%=dateC%></small></p>
                          
                        </div>
                      </div>
                    </div>
                </div>
                
                <%
                }
                }
                catch(Exception e)
                {
                    out.println(e);
                }    
                %>
            </form>
        </div>
    </div>

    <script>
        function router(route){
            window.location=route.id+".jsp?team='"+request.getParameter("team")+"'";
        }
    </script>

    <!-- JSP -->
    <%
        int x=0;
        
        String instructorId=(String)session.getAttribute("user");
        try{

            //reviewer adder
            if(request.getParameter("add")!=null){
                String reviewer=request.getParameter("reviewer");
                //check if reviewer 
                if(!"0".equals(reviewer)){
                    PreparedStatement ps1=con.prepareStatement("insert into reviewer values((?),(?));");
                    ps1.setString(1,teamcode);
                    ps1.setString(2,reviewer);

                    x=ps1.executeUpdate();
                    
                    if(x>0)
                        out.print("<script>alert('Reviewer added...');window.location='viewProject.jsp?team="+teamcode+"';</script>");  
                    else
                        out.print("<script>alert('Failed...');</script>");

                }else{
                    out.print("<script>alert('Reviewer Not Selected...');</script>");
                }
            }

            //reviwer remover
            if(request.getParameter("remove")!=null){
                String reviewer=request.getParameter("reviewer");
                //check if reviewer 
                if(!"0".equals(reviewer)){
                    PreparedStatement ps1=con.prepareStatement("delete from reviewer where teamCode=? and reviewer=?");
                    ps1.setString(1,teamcode);
                    ps1.setString(2,reviewer);
                    
                    x=ps1.executeUpdate();
                    
                    if(x>0)
                        out.print("<script>alert('Reviewer removed...');window.location='viewProject.jsp?team="+teamcode+"';</script>");     
                    else
                        out.print("<script>alert('Failed...');</script>");
                }
                else{
                    out.print("<script>alert('Reviewer Not Selected...');</script>");
                }
            }

            //comment and mark adder
            if(request.getParameter("submit")!=null){                
                String comment=request.getParameter("comment");
                int marks=Integer.parseInt(request.getParameter("marks"));

                String query = "{ call getName(?) }";
                CallableStatement stmt = con.prepareCall(query);
                stmt.setString(1, instructorId);
                ResultSet rs = stmt.executeQuery();
                rs.next();
                String instructorName= rs.getString("fname") + " "+ rs.getString("lname");
                
                PreparedStatement ps=con.prepareStatement("insert into Comment_Table(teamcode,comment_by,comment) values((?),(?),(?));");
                ps.setString(1,teamcode);
                ps.setString(2,instructorName);
                ps.setString(3,comment);
                x=ps.executeUpdate();
                
                //if comment successfully added then
                if(x>0){
                    PreparedStatement ps2=con.prepareStatement("update projectDesc set marks=(?) where teamcode='"+teamcode+"';");
                    ps2.setInt(1,marks);
                    ps2.executeUpdate();
                    out.print("<script>alert('Thank You...');window.location='viewProject.jsp?team="+teamcode+"';</script>");  
                }
                else{
                    out.print("<script>alert('Failed...');</script>");  
                }
            }
        }
        catch(Exception e)
        {
            out.print(e);   
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