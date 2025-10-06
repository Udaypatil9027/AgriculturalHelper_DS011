<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="agriHelp.DbConnection"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>View Solutions - AgriHelp Portal</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4a8e3c;
            --primary-dark: #3a6e2f;
            --secondary: #f9a826;
            --light: #f5f9f4;
            --dark: #2c3e26;
            --gray: #6c757d;
            --white: #ffffff;
            --danger: #e74c3c;
            --info: #3498db;
            --purple: #9b59b6;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Roboto', sans-serif;
        }
        
        body {
            color: var(--dark);
            line-height: 1.6;
            overflow-x: hidden;
            position: relative;
            min-height: 100vh;
        }
        
        /* Background Video Styling */
        #bgVideo {
            position: fixed;
            right: 0;
            bottom: 0;
            width: 120%;
            height: 117%;
            z-index: -2;
           object-fit: contain;  /* avoids cropping */
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
        }
        
        /* Dark overlay */
        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 50, 0, 0.7);
            z-index: -1;
        }
        
        /* Header */
        header {
            padding: 20px 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: rgba(255, 255, 255, 0.9);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        
        .logo {
            display: flex;
            align-items: center;
        }
        
        .logo h1 {
            font-family: 'Playfair Display', serif;
            color: var(--primary);
            font-size: 28px;
            margin-left: 10px;
        }
        
        .logo-icon {
            color: var(--primary);
            font-size: 32px;
        }
        
        nav ul {
            display: flex;
            list-style: none;
        }
        
        nav ul li {
            margin-left: 25px;
        }
        
        nav ul li a {
            text-decoration: none;
            color: var(--dark);
            font-weight: 500;
            transition: color 0.3s;
        }
        
        nav ul li a:hover {
            color: var(--primary);
        }
        
        /* Solutions Container */
        .solutions-container {
            padding: 30px 5%;
            max-width: 1800px;
            margin: 0 auto;
        }
        
        .solutions-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 20px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            backdrop-filter: blur(10px);
        }
        
        .solutions-header h2 {
            color: var(--white);
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            margin: 0;
        }
        
        .welcome-message {
            color: var(--secondary);
            font-weight: 500;
            font-size: 1.1rem;
        }
        
        /* Stats Bar */
        .stats-bar {
            display: flex;
            justify-content: space-between;
            background: rgba(255, 255, 255, 0.1);
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            backdrop-filter: blur(10px);
            color: var(--white);
        }
        
        .stat-item {
            text-align: center;
        }
        
        .stat-number {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--secondary);
            display: block;
        }
        
        .stat-label {
            font-size: 0.9rem;
            opacity: 0.9;
        }
        
        /* Search Container */
        .search-container {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        
        .search-input {
            flex: 1;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
        }
        
        .search-btn {
            background: var(--primary);
            color: var(--white);
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        /* Solutions Table */
        .solutions-table {
            width: 100%;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            border-collapse: collapse;
        }
        
        .solutions-table th {
            background-color: var(--primary);
            color: var(--white);
            padding: 15px;
            text-align: left;
            font-weight: 600;
        }
        
        .solutions-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #eee;
        }
        
        .solutions-table tr:last-child td {
            border-bottom: none;
        }
        
        .solutions-table tr:hover {
            background-color: rgba(74, 142, 60, 0.05);
        }
        
        /* Action Buttons */
        .action-cell {
            text-align: center;
            white-space: nowrap;
        }
        
        .btn-delete {
            background: var(--danger);
            color: var(--white);
            border: none;
            padding: 8px 12px;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            font-size: 14px;
        }
        
        .btn-delete:hover {
            background: #c0392b;
        }
        
        .btn-view {
            background: var(--info);
            color: var(--white);
            border: none;
            padding: 8px 12px;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            font-size: 14px;
            text-decoration: none;
            margin-right: 5px;
        }
        
        .btn-view:hover {
            background: #2980b9;
        }
        
        /* Back Button */
        .table-footer {
            margin-top: 20px;
            text-align: center;
        }
        
        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: var(--gray);
            color: var(--white);
            padding: 12px 20px;
            border-radius: 8px;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .btn-back:hover {
            background: #444;
        }
        
        /* Suggestion Text */
        .suggestion-text {
            max-width: 300px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        
        .suggestion-text:hover {
            white-space: normal;
            overflow: visible;
            position: absolute;
            background: white;
            padding: 10px;
            border-radius: 6px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            z-index: 10;
            max-width: 400px;
        }
        
        /* Responsive Design */
        @media (max-width: 992px) {
            .solutions-table {
                display: block;
                overflow-x: auto;
            }
        }
        
        @media (max-width: 768px) {
            .solutions-container {
                padding: 20px 3%;
            }
            
            .solutions-header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
            
            .stats-bar {
                flex-direction: column;
                gap: 15px;
            }
            
            .solutions-table th,
            .solutions-table td {
                padding: 10px;
                font-size: 14px;
            }
            
            .btn-delete, .btn-view {
                padding: 6px 10px;
                font-size: 12px;
            }
            
            .search-container {
                flex-direction: column;
            }
        }
        
        @media (max-width: 480px) {
            .solutions-header h2 {
                font-size: 1.6rem;
            }
            
            .solutions-table {
                font-size: 12px;
            }
            
            .action-cell {
                display: flex;
                flex-direction: column;
                gap: 5px;
            }
        }
    </style>
</head>
<body>
    <!-- Background Video -->
    <video autoplay muted loop id="bgVideo">
        <source src="resources/bgt_video.mp4" type="video/mp4">
        Your browser does not support HTML5 video.
    </video>

    <!-- Dark Overlay -->
    <div class="overlay"></div>

    <!-- Header -->
    <header>
        <div class="logo">
            <i class="fas fa-leaf logo-icon"></i>
            <h1>AgriHelp Portal</h1>
        </div>
        <nav>
            <ul>
                <li><a href="Admin_Dashboard11.jsp">Dashboard</a></li>
                <li><a href="Admin_Login11.html" onclick="return confirm('Are you sure you want to logout?');"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </nav>
    </header>

    <!-- Solutions Container -->
    <div class="solutions-container">
        <div class="solutions-header">
            <h2><i class="fas fa-lightbulb"></i> Solutions Management</h2>
            <div class="welcome-message">Welcome, <%= session.getAttribute("aemail") %>!</div>
        </div>
        
        <% 
        // Get solution statistics
        int totalSolutions = 0;
        int recentSolutions = 0;
        
        try {
            Connection con = DbConnection.connect();
            
            // Total solutions
            PreparedStatement totalStmt = con.prepareStatement("SELECT COUNT(*) FROM solutions");
            ResultSet totalRs = totalStmt.executeQuery();
            if (totalRs.next()) totalSolutions = totalRs.getInt(1);
            
            // Recent solutions (last 7 days)
            PreparedStatement recentStmt = con.prepareStatement("SELECT COUNT(*) FROM solutions WHERE dateProvided >= DATE_SUB(NOW(), INTERVAL 7 DAY)");
            ResultSet recentRs = recentStmt.executeQuery();
            if (recentRs.next()) recentSolutions = recentRs.getInt(1);
            
            // Close resources
            totalRs.close(); totalStmt.close();
            recentRs.close(); recentStmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
        
        <div class="stats-bar">
            <div class="stat-item">
                <span class="stat-number"><%= totalSolutions %></span>
                <span class="stat-label">Total Solutions</span>
            </div>
           
        </div>
        
        <div class="search-container">
            <input type="text" class="search-input" placeholder="Search solutions by farmer name, agronomist, or suggestion..." id="searchInput">
            <button class="search-btn">
                <i class="fas fa-search"></i> Search
            </button>
        </div>

        <table class="solutions-table">
            <thead>
                <tr>
                    <th>Solution ID</th>
                    <th>Report ID</th>
                    <th>Farmer Name</th>
                    <th>Agronomist Name</th>
                    <th>Suggestion</th>
                    <th>Date Provided</th>
                    <th class="action-cell">Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                Connection con = null;
                Statement st = null;
                ResultSet rs = null;
                try {
                    con = DbConnection.connect();
                    st = con.createStatement();
                    String sql = "SELECT * FROM solutions ORDER BY dateProvided DESC";
                    rs = st.executeQuery(sql);
                    
                    while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("solutionId") %></td>
                    <td><%= rs.getInt("reportId") %></td>
                    <td><%= rs.getString("fname") %></td>
                    <td><%= rs.getString("agname") %></td>
                    <td>
                        <div class="suggestion-text" title="<%= rs.getString("suggestion") %>">
                            <%= rs.getString("suggestion") %>
                        </div>
                    </td>
                    <td><%= rs.getDate("dateProvided") %></td>
                    <td class="action-cell">
                        
                        <form action="Admin_DeleteSolution11" method="post" class="delete-form" 
                              onsubmit="return confirm('Are you sure you want to delete this solution?');">
                            <input type="hidden" name="sid" value="<%= rs.getInt("solutionId") %>">
                            <button type="submit" class="btn-delete">
                                <i class="fas fa-trash"></i> Delete
                            </button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
                    try { if (st != null) st.close(); } catch (Exception e) { e.printStackTrace(); }
                    try { if (con != null) con.close(); } catch (Exception e) { e.printStackTrace(); }
                }
                %>
            </tbody>
        </table>
        
        <div class="table-footer">
            <a href="Admin_Dashboard11.jsp" class="btn-back">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </div>

    <script>
        // Search functionality
        document.getElementById('searchInput').addEventListener('keyup', function() {
            const searchText = this.value.toLowerCase();
            const rows = document.querySelectorAll('.solutions-table tbody tr');
            
            rows.forEach(row => {
                const farmerName = row.cells[2].textContent.toLowerCase();
                const agronomistName = row.cells[3].textContent.toLowerCase();
                const suggestion = row.cells[4].textContent.toLowerCase();
                
                if (farmerName.includes(searchText) || agronomistName.includes(searchText) || suggestion.includes(searchText)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
        
        // Make search button work
        document.querySelector('.search-btn').addEventListener('click', function() {
            document.getElementById('searchInput').focus();
        });
    </script>
    <script>
    // Slow down the background video to half speed
    document.getElementById("bgVideo").playbackRate = 0.5;
</script>
    
</body>
</html>