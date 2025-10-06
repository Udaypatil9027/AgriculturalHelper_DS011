<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="agriHelp.DbConnection"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Your Suggestions - AgriHelp Portal</title>
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
        display: flex;
        align-items: center;
        gap: 10px;
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
        position: sticky;
        top: 0;
    }
    
    tr:hover {
        background-color: rgba(106, 191, 105, 0.1);
    }
    
    .btn {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 10px 20px;
        background: var(--primary-color);
        color: var(--white);
        border: none;
        border-radius: 5px;
        font-weight: 500;
        cursor: pointer;
        transition: var(--transition);
        text-decoration: none;
        margin-top: 20px;
    }
    
    .btn:hover {
        background: var(--primary-dark);
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }
    
    .suggestion-cell {
        max-width: 300px;
        word-wrap: break-word;
    }
    
    .empty-state {
        text-align: center;
        padding: 40px;
        color: var(--text-light);
    }
    
    .empty-state i {
        font-size: 3rem;
        margin-bottom: 15px;
        color: var(--primary-light);
    }
    
    .stats-bar {
        display: flex;
        justify-content: space-around;
        margin-bottom: 25px;
        flex-wrap: wrap;
        gap: 15px;
    }
    
    .stat-item {
        background: rgba(255, 255, 255, 0.9);
        padding: 15px 20px;
        border-radius: 8px;
        text-align: center;
        box-shadow: var(--shadow);
        flex: 1;
        min-width: 150px;
    }
    
    .stat-number {
        font-size: 1.8rem;
        font-weight: 700;
        color: var(--primary-color);
        margin-bottom: 5px;
    }
    
    .stat-label {
        font-size: 0.9rem;
        color: var(--text-dark);
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
        
        .stats-bar {
            flex-direction: column;
        }
        
        th, td {
            padding: 8px 10px;
            font-size: 0.9rem;
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
		if (session.getAttribute("aname") == null) {
			response.sendRedirect("Agronomist_Login22.html");
			return;
		}
		String aname = (String) session.getAttribute("aname");
		String acontact = (String) session.getAttribute("acontact");
		
		int suggestionCount = 0;
	%>
	
	<div class="container">
        <div class="header">
            <div class="welcome-section">
                <h2>Your Suggestions</h2>
                <p>Review all the solutions you've provided to farmers</p>
            </div>
            <div>
                <span>Welcome, <%= aname %></span>
            </div>
        </div>
        
        <div class="content-card">
            <h3 class="card-title">
                <i class="fas fa-lightbulb"></i> Your Agricultural Solutions
            </h3>
            
            <div class="stats-bar">
                <%
                    Connection con=null;
                    PreparedStatement pt = null;
                    ResultSet rs=null;
                    int aid = 0;
                    
                    try {
                        con = DbConnection.connect();
                        pt = con.prepareStatement("SELECT * FROM agronomist WHERE acontact=?");
                        pt.setString(1, acontact);
                        rs = pt.executeQuery();
                        if(rs.next()){
                            aid = rs.getInt("agroId");
                        }
                        
                        // Get suggestion count
                        pt = con.prepareStatement("SELECT COUNT(*) as count FROM solutions WHERE agroId=?");
                        pt.setInt(1, aid);
                        rs = pt.executeQuery();
                        if(rs.next()){
                            suggestionCount = rs.getInt("count");
                        }
                %>
                <div class="stat-item">
                    <div class="stat-number"><%= suggestionCount %></div>
                    <div class="stat-label">Total Suggestions</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">
                        <%
                            pt = con.prepareStatement("SELECT COUNT(DISTINCT farmerId) as count FROM solutions WHERE agroId=?");
                            pt.setInt(1, aid);
                            rs = pt.executeQuery();
                            if(rs.next()){
                                out.print(rs.getInt("count"));
                            }
                        %>
                    </div>
                    <div class="stat-label">Farmers Helped</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">
                        <%
                            pt = con.prepareStatement("SELECT COUNT(DISTINCT reportId) as count FROM solutions WHERE agroId=?");
                            pt.setInt(1, aid);
                            rs = pt.executeQuery();
                            if(rs.next()){
                                out.print(rs.getInt("count"));
                            }
                        %>
                    </div>
                    <div class="stat-label">Problems Solved</div>
                </div>
                <%
                    } catch(Exception e) {
                        e.printStackTrace();
                    }
                %>
            </div>
            
            <% if(suggestionCount > 0) { %>
            <table>
                <thead>
                    <tr>
                        <th>Solution ID</th>
                        <th>Report ID</th>
                        <th>Farmer ID</th>
                        <th>Farmer Name</th>
                        <th>Agronomist ID</th>
                        <th>Agronomist Name</th>
                        <th>Suggestion</th>
                        <th>Date Provided</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            pt = con.prepareStatement("SELECT * FROM solutions WHERE agroId=? ORDER BY dateProvided DESC");
                            pt.setInt(1, aid);
                            rs = pt.executeQuery();
                            
                            while(rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("solutionId") %></td>
                        <td><%= rs.getInt("reportId") %></td>
                        <td><%= rs.getInt("farmerId") %></td>
                        <td><%= rs.getString("fname") %></td>
                        <td><%= rs.getInt("agroId") %></td>
                        <td><%= rs.getString("agname") %></td>
                        <td class="suggestion-cell"><%= rs.getString("suggestion") %></td>
                        <td><%= rs.getString("dateProvided") %></td>
                    </tr>
                    <%
                            }
                        } catch(Exception e) {
                            e.printStackTrace();
                        } finally {
                            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
                            try { if (pt != null) pt.close(); } catch (Exception e) { e.printStackTrace(); }
                            try { if (con != null) con.close(); } catch (Exception e) { e.printStackTrace(); }
                        }
                    %>
                </tbody>
            </table>
            <% } else { %>
            <div class="empty-state">
                <i class="fas fa-lightbulb"></i>
                <h3>No Suggestions Yet</h3>
                <p>You haven't provided any solutions to farmers yet. Start helping farmers by solving their crop problems.</p>
                <a href="View_FarmerReports22.jsp" class="btn">
                    <i class="fas fa-clipboard-list"></i> View Farmer Reports
                </a>
            </div>
            <% } %>
            
            <a href="Agronomist_Dashboard22.jsp" class="btn">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </div>
    
    <script>
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