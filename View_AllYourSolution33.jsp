<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="agriHelp.DbConnection"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>All Solutions - AgriHelp Portal</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4caf50;
            --primary-light: #80e27e;
            --primary-dark: #087f23;
            --secondary-color: #ff9800;
            --accent-color: #ffeb3b;
            --text-dark: #2e3b0b;
            --text-light: #78909c;
            --white: #ffffff;
            --card-bg: rgba(255, 255, 255, 0.98);
            --overlay-dark: rgba(0, 0, 0, 0.7);
            --shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            --transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Roboto', sans-serif;
            color: var(--text-dark);
            line-height: 1.6;
            min-height: 100vh;
            padding: 20px;
            position: relative;
            overflow-x: hidden;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        }
        
        /* Background with subtle pattern */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(76, 175, 80, 0.1) 0%, rgba(255, 152, 0, 0.1) 100%);
            z-index: -1;
        }
        
        .container {
            max-width: 1400px;
            width: 100%;
            margin: 0 auto;
        }
        
        /* Header */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 25px 30px;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            border-radius: 15px;
            color: var(--white);
            box-shadow: var(--shadow);
        }
        
        .welcome-section h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2.2rem;
            margin-bottom: 8px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }
        
        .welcome-section p {
            opacity: 0.9;
            font-size: 1.1rem;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 12px 24px;
            background: rgba(255, 255, 255, 0.2);
            color: var(--white);
            text-decoration: none;
            border-radius: 12px;
            transition: var(--transition);
            font-weight: 600;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        
        .btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-3px);
        }
        
        /* Solutions Container */
        .solutions-container {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 30px;
            box-shadow: var(--shadow);
            margin-bottom: 30px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        
        .solutions-title {
            font-size: 1.8rem;
            color: var(--primary-dark);
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        /* Stats Overview */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            box-shadow: var(--shadow);
            transition: var(--transition);
            border-left: 4px solid var(--primary-color);
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }
        
        .stat-icon {
            font-size: 2rem;
            color: var(--primary-color);
            margin-bottom: 10px;
        }
        
        .stat-value {
            font-size: 2.2rem;
            font-weight: 800;
            color: var(--primary-dark);
            margin: 5px 0;
        }
        
        .stat-label {
            font-size: 0.9rem;
            color: var(--text-light);
            font-weight: 500;
        }
        
        /* Solutions Table */
        .solutions-table-container {
            overflow-x: auto;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }
        
        .solutions-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .solutions-table th {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            color: var(--white);
            padding: 16px;
            text-align: left;
            font-weight: 600;
            position: sticky;
            top: 0;
        }
        
        .solutions-table td {
            padding: 14px 16px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            vertical-align: top;
        }
        
        .solutions-table tr {
            transition: var(--transition);
            background: rgba(255, 255, 255, 0.9);
        }
        
        .solutions-table tr:nth-child(even) {
            background: rgba(248, 250, 248, 0.9);
        }
        
        .solutions-table tr:hover {
            background: rgba(232, 245, 233, 0.7);
            transform: translateY(-2px);
        }
        
        /* Solution content styling */
        .solution-content {
            max-width: 300px;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }
        
        .view-solution-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 12px;
            background: var(--primary-light);
            color: var(--primary-dark);
            text-decoration: none;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: 600;
            transition: var(--transition);
        }
        
        .view-solution-btn:hover {
            background: var(--primary-color);
            color: var(--white);
            transform: translateY(-2px);
        }
        
        /* Agronomist info */
        .agronomist-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .agronomist-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }
        
        /* No Solutions Message */
        .no-solutions {
            text-align: center;
            padding: 60px 40px;
            color: var(--text-light);
        }
        
        .no-solutions-icon {
            font-size: 4rem;
            color: #e0e0e0;
            margin-bottom: 20px;
        }
        
        .no-solutions h3 {
            color: var(--text-light);
            margin-bottom: 15px;
        }
        
        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            justify-content: center;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 10px 20px rgba(76, 175, 80, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(76, 175, 80, 0.4);
            color: white;
        }
        
        .btn-secondary {
            background: rgba(255, 255, 255, 0.9);
            color: var(--primary-dark);
            padding: 12px 25px;
            border: 2px solid var(--primary-color);
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-secondary:hover {
            background: var(--primary-light);
            transform: translateY(-3px);
            color: var(--primary-dark);
        }
        
        /* Responsive Design */
        @media (max-width: 1200px) {
            .solutions-table-container {
                overflow-x: auto;
            }
            
            .solutions-table {
                min-width: 1000px;
            }
        }
        
        @media (max-width: 900px) {
            .header {
                flex-direction: column;
                text-align: center;
                gap: 20px;
            }
            
            .welcome-section h2 {
                font-size: 1.8rem;
            }
            
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .action-buttons {
                flex-direction: column;
                align-items: center;
            }
        }
        
        @media (max-width: 600px) {
            body {
                padding: 15px;
            }
            
            .solutions-container {
                padding: 20px;
            }
            
            .solutions-title {
                font-size: 1.5rem;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .btn {
                padding: 10px 16px;
                font-size: 0.9rem;
            }
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
    z-index: -2;
    transform: translate(-50%, -50%);
    object-fit: cover;
    filter: brightness(0.65); /* darkens video */
}

/* Dark Overlay */
.overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.4);
    z-index: -1;
}
        
    </style>
</head>
<body>
  <body>
    <!-- Background Video -->
    <video autoplay muted loop id="bgVideo">
        <source src="resources/bgt_Farmer.mp4" type="video/mp4">
        Your browser does not support HTML5 video.
    </video>

    <!-- Dark overlay -->
    <div class="overlay"></div>

    <%
    if (session.getAttribute("fname") == null) {
        response.sendRedirect("Farmer_Login33.html");
        return;
    }
    String fcontact = (String) session.getAttribute("fcontact");
    String fname = (String) session.getAttribute("fname");
    
    int fid = 0;
    int totalSolutions = 0;
    int uniqueAgronomists = 0;
    int reportsWithSolutions = 0;
    
    Connection con = DbConnection.connect();

    // Get farmerId using session contact
    PreparedStatement pt1 = con.prepareStatement("SELECT farmerId FROM farmer WHERE fcontact=?");
    pt1.setString(1, fcontact);
    ResultSet rs1 = pt1.executeQuery();
    if(rs1.next()){
        fid = rs1.getInt("farmerId");
    }
    %>

    
    <div class="container">
        <!-- Header -->
        <div class="header">
            <div class="welcome-section">
                <h2>Welcome, <%= fname %>!</h2>
                <p>All Expert Solutions for Your Reports</p>
            </div>
            
            <a href="Farmer_Dashboard33.jsp" class="btn">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
        
        <!-- Solutions Container -->
        <div class="solutions-container">
            <h2 class="solutions-title"><i class="fas fa-lightbulb"></i> All Solutions</h2>
            
            <%
            // Get statistics
            String statsQuery = "SELECT " +
                "COUNT(DISTINCT s.solutionId) as totalSolutions, " +
                "COUNT(DISTINCT s.agroId) as uniqueAgronomists, " +
                "COUNT(DISTINCT s.reportId) as reportsWithSolutions " +
                "FROM solutions s INNER JOIN reports r ON s.reportId = r.reportId " +
                "WHERE r.farmerId=?";
                
            PreparedStatement statsStmt = con.prepareStatement(statsQuery);
            statsStmt.setInt(1, fid);
            ResultSet statsRs = statsStmt.executeQuery();
            
            if(statsRs.next()) {
                totalSolutions = statsRs.getInt("totalSolutions");
                uniqueAgronomists = statsRs.getInt("uniqueAgronomists");
                reportsWithSolutions = statsRs.getInt("reportsWithSolutions");
            }
            %>
            
            <!-- Statistics Overview -->
            <div class="stats-grid">
                <div class="stat-card">
                    <i class="fas fa-lightbulb stat-icon"></i>
                    <div class="stat-value"><%= totalSolutions %></div>
                    <div class="stat-label">Total Solutions</div>
                </div>
                
                <div class="stat-card">
                    <i class="fas fa-user-tie stat-icon"></i>
                    <div class="stat-value"><%= uniqueAgronomists %></div>
                    <div class="stat-label">Agronomists</div>
                </div>
                
                <div class="stat-card">
                    <i class="fas fa-clipboard-list stat-icon"></i>
                    <div class="stat-value"><%= reportsWithSolutions %></div>
                    <div class="stat-label">Reports with Solutions</div>
                </div>
            </div>
            
            <%
            // Get all solutions for all reports of this farmer
            String query = "SELECT s.solutionId, s.reportId, s.agroId, s.agname, s.suggestion, s.dateProvided " +
                           "FROM solutions s INNER JOIN reports r ON s.reportId = r.reportId " +
                           "WHERE r.farmerId=? ORDER BY s.dateProvided DESC";
            PreparedStatement pt2 = con.prepareStatement(query);
            pt2.setInt(1, fid);
            ResultSet rs2 = pt2.executeQuery();

            boolean hasData = rs2.isBeforeFirst();
            %>
            
            <% if(hasData) { %>
            <div class="solutions-table-container">
                <table class="solutions-table">
                    <thead>
                        <tr>
                            <th>Solution ID</th>
                            <th>Report ID</th>
                            <th>Agronomist</th>
                            <th>Solution Preview</th>
                            <th>Date Provided</th>
                          
                        </tr>
                    </thead>
                    <tbody>
                    <%
                    while(rs2.next()) {
                        String agronomistName = rs2.getString("agname");
                        String agronomistInitial = agronomistName.substring(0, 1).toUpperCase();
                        String suggestion = rs2.getString("suggestion");
                        String dateProvided = rs2.getString("dateProvided");
                    %>
                        <tr>
                            <td><%= rs2.getInt("solutionId") %></td>
                            <td>#<%= rs2.getInt("reportId") %></td>
                            <td>
                                <div class="agronomist-info">
                                    <div class="agronomist-avatar">
                                        <%= agronomistInitial %>
                                    </div>
                                    <div>
                                        <div><%= agronomistName %></div>
                                        <small>ID: <%= rs2.getInt("agroId") %></small>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="solution-content">
                                    <%= suggestion.length() > 150 ? suggestion.substring(0, 150) + "..." : suggestion %>
                                </div>
                            </td>
                            <td><%= dateProvided %></td>
                            
                        </tr>
                    <%
                    }
                    %>
                    </tbody>
                </table>
            </div>
            <% } else { %>
                <div class="no-solutions">
                    <i class="fas fa-lightbulb no-solutions-icon"></i>
                    <h3>No Solutions Available Yet</h3>
                    <p>Our agronomists haven't provided solutions for your reports yet.</p>
                    <p>Check back later or submit new reports for assistance.</p>
                </div>
            <% } %>
            
            <div class="action-buttons">
                <a href="View_YourReports33.jsp" class="btn-primary">
                    <i class="fas fa-list"></i> View Your Reports
                </a>
                <a href="Farmer_Dashboard33.jsp" class="btn-secondary">
                    <i class="fas fa-home"></i> Back to Dashboard
                </a>
            </div>
        </div>
    </div>
    
    <script>
        // Add animation to table rows
        document.addEventListener('DOMContentLoaded', function() {
            const tableRows = document.querySelectorAll('.solutions-table tbody tr');
            tableRows.forEach((row, index) => {
                row.style.opacity = '0';
                row.style.transform = 'translateX(-20px)';
                row.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                
                setTimeout(() => {
                    row.style.opacity = '1';
                    row.style.transform = 'translateX(0)';
                }, 100 * index);
            });
            
            // Animate stat cards
            const statCards = document.querySelectorAll('.stat-card');
            statCards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                
                setTimeout(() => {
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, 200 * index);
            });
        });
    </script>
</body>
</html>