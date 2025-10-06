<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="agriHelp.DbConnection"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Farmer Reports - AgriHelp Portal</title>
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    :root {
        --primary-color: #388e3c;
        --primary-light: #6abf69;
        --primary-dark: #00600f;
        --secondary-color: #8d6e63;
        --accent-color: #ffa000;
        --text-dark: #263238;
        --text-light: #78909c;
        --white: #ffffff;
        --card-bg: rgba(248, 249, 250, 0.95);
        --header-bg: rgba(56, 142, 60, 0.9);
        --shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        --transition: all 0.3s ease;
    }
    
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Roboto', sans-serif;
    }
    
    body {
        color: var(--text-dark);
        line-height: 1.6;
        padding: 20px;
        position: relative;
        min-height: 100vh;
    }
    
    /* Background Video */
    #bgVideo {
        position: fixed;
        top: 50%;
        left: 50%;
        min-width: 100%;
        min-height: 100%;
        width: auto;
        height: auto;
        transform: translateX(-50%) translateY(-50%);
        z-index: -2;
    }
    
    .overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.6);
        z-index: -1;
    }
    
    .container {
        max-width: 1400px;
        margin: 0 auto;
        position: relative;
        z-index: 1;
    }
    
    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        padding: 20px;
        background: linear-gradient(135deg, var(--header-bg) 0%, rgba(0, 96, 15, 0.9) 100%);
        border-radius: 10px;
        color: var(--white);
        box-shadow: var(--shadow);
        backdrop-filter: blur(5px);
    }
    
    .welcome-section h2 {
        font-family: 'Playfair Display', serif;
        font-size: 2rem;
        margin-bottom: 5px;
    }
    
    .welcome-section p {
        opacity: 0.9;
    }
    
    .content-card {
        background: var(--card-bg);
        border-radius: 10px;
        padding: 25px;
        box-shadow: var(--shadow);
        margin-bottom: 30px;
        backdrop-filter: blur(5px);
    }
    
    .card-title {
        font-size: 1.5rem;
        color: var(--primary-dark);
        margin-bottom: 20px;
        padding-bottom: 10px;
        border-bottom: 2px solid var(--primary-light);
    }
    
    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
        background: rgba(255, 255, 255, 0.8);
        border-radius: 8px;
        overflow: hidden;
    }
    
    th, td {
        padding: 12px 15px;
        text-align: left;
        border-bottom: 1px solid rgba(0, 0, 0, 0.1);
    }
    
    th {
        background-color: var(--primary-color);
        color: var(--white);
        font-weight: 500;
    }
    
    tr:hover {
        background-color: rgba(106, 191, 105, 0.1);
    }
    
    .report-image {
        max-width: 80px;
        max-height: 80px;
        border: 1px solid #ddd;
        border-radius: 4px;
        cursor: pointer;
        transition: var(--transition);
    }
    
    .report-image:hover {
        transform: scale(1.05);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }
    
    .solution-form {
        display: flex;
        gap: 10px;
    }
    
    .solution-input {
        flex: 1;
        padding: 8px 12px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 0.9rem;
    }
    
    .btn {
        display: inline-block;
        padding: 8px 16px;
        background: var(--primary-color);
        color: var(--white);
        border: none;
        border-radius: 4px;
        font-weight: 500;
        cursor: pointer;
        transition: var(--transition);
        text-decoration: none;
    }
    
    .btn:hover {
        background: var(--primary-dark);
        transform: translateY(-2px);
    }
    
    .btn-danger {
        background: var(--secondary-color);
    }
    
    .btn-danger:hover {
        background: #b71c1c;
    }
    
    .btn-back {
        background: var(--primary-light);
        display: inline-flex;
        align-items: center;
        gap: 8px;
        margin-top: 20px;
    }
    
    .btn-back:hover {
        background: var(--primary-color);
    }
    
    .message {
        padding: 12px 15px;
        margin-bottom: 20px;
        border-radius: 6px;
        backdrop-filter: blur(5px);
    }
    
    .success {
        background: rgba(223, 240, 216, 0.9);
        color: #3c763d;
        border-left: 4px solid #3c763d;
    }
    
    .error {
        background: rgba(242, 222, 222, 0.9);
        color: #a94442;
        border-left: 4px solid #a94442;
    }
    
    .status-badge {
        display: inline-block;
        padding: 4px 8px;
        border-radius: 12px;
        font-size: 0.8rem;
        font-weight: 500;
    }
    
    .status-pending {
        background: #fff3cd;
        color: #856404;
    }
    
    .status-solved {
        background: #d4edda;
        color: #155724;
    }
    
    .solution-provided {
        color: var(--primary-color);
        font-weight: 500;
    }
    
    @media (max-width: 1200px) {
        table {
            display: block;
            overflow-x: auto;
        }
    }
    
    @media (max-width: 768px) {
        .header {
            flex-direction: column;
            text-align: center;
        }
        
        .welcome-section {
            margin-bottom: 15px;
        }
        
        .solution-form {
            flex-direction: column;
        }
    }
</style>
</head>
<body>
    <!-- Background Video -->
    <video autoplay muted loop id="bgVideo">
        <source src="resources/bgt_Agronomist.mp4" type="video/mp4">
        Your browser does not support HTML5 video.
    </video>

    <!-- Dark Overlay -->
    <div class="overlay"></div>

	<%
	if(session.getAttribute("aname")==null){
		response.sendRedirect("Agronomist_Login22.html");
		return;
	}
	String aconatct = (String)session.getAttribute("acontact");
	String aname = (String)session.getAttribute("aname");
	
	
    String success = (String) session.getAttribute("success");
    String error = (String) session.getAttribute("error");
    %>
    
    <div class="container">
        <div class="header">
            <div class="welcome-section">
                <h2>Farmer Reports</h2>
                <p>Review and provide solutions for farmer crop issues</p>
            </div>
            <div>
                <span>Welcome, <%= aname %></span>
            </div>
        </div>
        
        <% if(success != null){ %>
        <div class="message success">
            <i class="fas fa-check-circle"></i> <%= success %>
        </div>
        <%
            session.removeAttribute("success");
        }
        if(error != null){
        %>
        <div class="message error">
            <i class="fas fa-exclamation-circle"></i> <%= error %>
        </div>
        <%
            session.removeAttribute("error");
        }
        %>
    
        <div class="content-card">
            <h3 class="card-title">All Farmer Reports</h3>
            
            <table>
                <thead>
                    <tr>
                        <th>Report ID</th>
                        <th>Farmer Name</th>
                        <th>Farmer ID</th>
                        <th>Crop Name</th>
                        <th>Symptoms</th>
                        <th>Date Reported</th>
                        <th>Status</th>
                        <th>Image</th>
                        <th>Solution</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    Connection con = null;
                    PreparedStatement pt1 = null;
                    ResultSet rs1 = null;
                    
                    try{
                        con = DbConnection.connect();
                        
                        pt1 = con.prepareStatement(
                            "SELECT r.*, s.suggestion " +
                            "FROM reports r " +
                            "LEFT JOIN solutions s ON r.reportId = s.reportId"
                        );
                        rs1 = pt1.executeQuery();
    
                        while (rs1.next()) {
                            boolean hasSolution = rs1.getString("suggestion") != null;
                            String status = rs1.getString("status");
                    %>
                    <tr>
                        <td><%= rs1.getInt("reportId") %></td>
                        <td><%= rs1.getString("fname") %></td>
                        <td><%= rs1.getInt("farmerId") %></td>
                        <td><%= rs1.getString("cropName") %></td>
                        <td><%= rs1.getString("symptoms") %></td>
                        <td><%= rs1.getString("dateReported") %></td>
                        <td>
                            <span class="status-badge <%= "status-" + status.toLowerCase() %>">
                                <%= status %>
                            </span>
                        </td>
                        <td>
                            <% if (rs1.getBlob("rimage") != null) { %>
                                <img src="ImageOpenServlet?id=<%= rs1.getInt("reportId") %>" 
                                     alt="Report Image"
                                     onclick="showImage('<%= rs1.getInt("reportId") %>')"
                                     class="report-image">
                            <% } else { %>
                                No Image
                            <% } %>
                        </td>
                        <td>
                            <% if (!hasSolution) { %>
                                <form action="Add_Solution22" method="post" class="solution-form">
                                    <input type="text" name="solution" class="solution-input" placeholder="Enter solution" required>
                                    <input type="hidden" name="rid" value="<%= rs1.getInt("reportId") %>">
                                    <button type="submit" class="btn">
                                        <i class="fas fa-paper-plane"></i> Submit
                                    </button>
                                </form>
                            <% } else { %>
                                <span class="solution-provided">
                                    <i class="fas fa-check-circle"></i> Solution provided
                                </span>
                            <% } %>
                        </td>
                    </tr>
                    <%
                        }
                    
                    }catch(Exception e){
                        e.printStackTrace();
                    }
                    finally {
                        try { if (rs1 != null) rs1.close(); } catch (Exception e) { e.printStackTrace(); }
                        try { if (pt1 != null) pt1.close(); } catch (Exception e) { e.printStackTrace(); }
                        try { if (con != null) con.close(); } catch (Exception e) { e.printStackTrace(); }
                    }
                    %>
                </tbody>
            </table>
            
            <a href="Agronomist_Dashboard22.jsp" class="btn btn-back">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </div>
    
    <script>
        function showImage(reportId) {
            window.open("ImageOpenServlet?id=" + reportId, "_blank", 
                       "width=600,height=600,scrollbars=yes");
        }
        
        // Simple animation for table rows
        document.addEventListener('DOMContentLoaded', function() {
            const rows = document.querySelectorAll('tbody tr');
            
            rows.forEach((row, index) => {
                row.style.opacity = '0';
                row.style.transform = 'translateX(-20px)';
                row.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                
                setTimeout(() => {
                    row.style.opacity = '1';
                    row.style.transform = 'translateX(0)';
                }, 100 * index);
            });
        });
    </script>
</body>
</html>