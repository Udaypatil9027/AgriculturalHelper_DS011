<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="agriHelp.DbConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Your Reports - AgriHelp Portal</title>
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
        
        .btn-back {
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
        
        .btn-back:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-3px);
        }
        
        /* Reports Container */
        .reports-container {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 30px;
            box-shadow: var(--shadow);
            margin-bottom: 30px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            overflow-x: auto;
        }
        
        .reports-title {
            font-size: 1.8rem;
            color: var(--primary-dark);
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        /* Table Styling */
        .reports-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        
        .reports-table th {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            color: var(--white);
            padding: 16px;
            text-align: left;
            font-weight: 600;
            position: sticky;
            top: 0;
        }
        
        .reports-table td {
            padding: 14px 16px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            vertical-align: middle;
        }
        
        .reports-table tr {
            transition: var(--transition);
        }
        
        .reports-table tr:hover {
            background: rgba(76, 175, 80, 0.05);
            transform: translateY(-2px);
        }
        
        /* Status Badges */
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-block;
        }
        
        .status-pending {
            background: #fff3cd;
            color: #856404;
        }
        
        .status-processing {
            background: #cce5ff;
            color: #004085;
        }
        
        .status-completed {
            background: #d4edda;
            color: #155724;
        }
        
        /* Image Preview */
        .report-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
            border: 2px solid #e0e0e0;
            cursor: pointer;
            transition: var(--transition);
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
    filter: brightness(0.6); /* darken video slightly */
}

/* Dark overlay */
.overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.35);
    z-index: -1;
}
        
        
        .report-image:hover {
            transform: scale(1.05);
            border-color: var(--primary-color);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .no-image {
            color: var(--text-light);
            font-style: italic;
        }
        
        /* Action Buttons */
        .btn-action {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 8px 16px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            text-decoration: none;
            gap: 6px;
        }
        
        .btn-view {
            background: var(--primary-light);
            color: var(--primary-dark);
        }
        
        .btn-view:hover {
            background: var(--primary-color);
            color: var(--white);
            transform: translateY(-2px);
        }
        
        .btn-delete {
            background: #ffebee;
            color: #c62828;
        }
        
        .btn-delete:hover {
            background: #ffcdd2;
            transform: translateY(-2px);
        }
        
        /* Messages */
        .message {
            padding: 15px 20px;
            margin-bottom: 25px;
            border-radius: 10px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 12px;
            box-shadow: var(--shadow);
        }
        
        .message-success {
            background: #d4edda;
            color: #155724;
            border-left: 4px solid #28a745;
        }
        
        .message-error {
            background: #f8d7da;
            color: #721c24;
            border-left: 4px solid #dc3545;
        }
        
        /* No Reports Message */
        .no-reports {
            text-align: center;
            padding: 40px;
            color: var(--text-light);
        }
        
        .no-reports-icon {
            font-size: 3rem;
            color: #e0e0e0;
            margin-bottom: 20px;
        }
        
        /* Responsive Design */
        @media (max-width: 1200px) {
            .reports-container {
                overflow-x: auto;
            }
            
            .reports-table {
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
        }
        
        @media (max-width: 600px) {
            body {
                padding: 15px;
            }
            
            .reports-container {
                padding: 20px;
            }
            
            .reports-title {
                font-size: 1.5rem;
            }
            
            .btn-back, .btn-action {
                padding: 10px 16px;
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
     <!-- Background Video -->
    <video autoplay muted loop id="bgVideo">
        <source src="resources/bgt_Farmer.mp4" type="video/mp4">
        Your browser does not support HTML5 video.
    </video>

    <!-- Dark overlay for readability -->
    <div class="overlay"></div>

    <%
        // Check if session exists
        if (session.getAttribute("fname") == null) {
            response.sendRedirect("Farmer_Login33.html");
            return;
        }
        String fcontact = (String) session.getAttribute("fcontact");
        String fname = (String) session.getAttribute("fname");

        // Display success/error messages
        String success = (String) session.getAttribute("success");
        String error = (String) session.getAttribute("error");
    %>

    <div class="container">
        <!-- Header -->
        <div class="header">
            <div class="welcome-section">
                <h2>Welcome, <%= fname %>!</h2>
                <p>Your Crop Reports - AgriHelp Portal</p>
            </div>
            
            <a href="Farmer_Dashboard33.jsp" class="btn-back">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
        
        <!-- Messages -->
        <% if (success != null) { %>
            <div class="message message-success">
                <i class="fas fa-check-circle"></i> <%= success %>
            </div>
        <%
            session.removeAttribute("success");
        } %>
        
        <% if (error != null) { %>
            <div class="message message-error">
                <i class="fas fa-exclamation-circle"></i> <%= error %>
            </div>
        <%
            session.removeAttribute("error");
        } %>
        
        <!-- Reports Container -->
        <div class="reports-container">
            <h2 class="reports-title"><i class="fas fa-clipboard-list"></i> Your Reports</h2>
            
            <%
                Connection con = null;
                PreparedStatement pt = null;
                PreparedStatement pt1 = null;
                ResultSet rs = null;
                ResultSet rs1 = null;
                boolean hasReports = false;
                
                try {
                    con = DbConnection.connect();
                    
                    // Get farmerId
                    pt = con.prepareStatement("SELECT farmerId FROM farmer WHERE fcontact=?");
                    pt.setString(1, fcontact);
                    rs = pt.executeQuery();
                    
                    if (rs.next()) {
                        int farmerId = rs.getInt("farmerId");
                        
                        // Get reports for this farmer
                        pt1 = con.prepareStatement("SELECT * FROM reports WHERE farmerId=? ORDER BY dateReported DESC");
                        pt1.setInt(1, farmerId);
                        rs1 = pt1.executeQuery();
                        
                        if (rs1.isBeforeFirst()) {
                            hasReports = true;
            %>
            
            <table class="reports-table">
                <thead>
                    <tr>
                        <th>Report ID</th>
                        <th>Crop Name</th>
                        <th>Symptoms</th>
                        <th>Report Date</th>
                        <th>Status</th>
                        <th>Image</th>
                        <th>Solution</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    while (rs1.next()) {
                        String statusClass = "";
                        String status = rs1.getString("status");
                        if (status != null) {
                            if (status.equalsIgnoreCase("pending")) {
                                statusClass = "status-pending";
                            } else if (status.equalsIgnoreCase("processing")) {
                                statusClass = "status-processing";
                            } else if (status.equalsIgnoreCase("completed")) {
                                statusClass = "status-completed";
                            }
                        }
                %>
                    <tr>
                        <td><%= rs1.getInt("reportId") %></td>
                        <td><%= rs1.getString("cropName") %></td>
                        <td><%= rs1.getString("symptoms") %></td>
                        <td><%= rs1.getString("dateReported") %></td>
                        <td>
                            <span class="status-badge <%= statusClass %>">
                                <%= rs1.getString("status") %>
                            </span>
                        </td>
                        <td>
                            <%
                                if (rs1.getBlob("rimage") != null) {
                            %>
                                <img src="ImageOpenServlet?id=<%= rs1.getInt("reportId") %>" 
                                     class="report-image" 
                                     alt="Report Image" 
                                     onclick="showImage('<%= rs1.getInt("reportId") %>')">
                            <%
                                } else {
                            %>
                                <span class="no-image">No Image</span>
                            <%
                                }
                            %>
                        </td>
                        <td>
                            <a href="View_Solution33.jsp?rid=<%= rs1.getInt("reportId") %>" class="btn-action btn-view">
                                <i class="fas fa-eye"></i> View
                            </a>
                        </td>
                        <td>
                            <form action="Delete_Report33" method="post" onsubmit="return confirm('Are you sure you want to delete this report?');">
                                <input type="hidden" name="rid" value="<%= rs1.getInt("reportId") %>">
                                <button type="submit" class="btn-action btn-delete">
                                    <i class="fas fa-trash"></i> Delete
                                </button>
                            </form>
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
            
            <%
                        } else {
                            // No reports found
                            hasReports = false;
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try { if (rs1 != null) rs1.close(); } catch (Exception e) { e.printStackTrace(); }
                    try { if (pt1 != null) pt1.close(); } catch (Exception e) { e.printStackTrace(); }
                    try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
                    try { if (pt != null) pt.close(); } catch (Exception e) { e.printStackTrace(); }
                    try { if (con != null) con.close(); } catch (Exception e) { e.printStackTrace(); }
                }
                
                if (!hasReports) {
            %>
            
            <div class="no-reports">
                <i class="fas fa-clipboard-list no-reports-icon"></i>
                <h3>No Reports Found</h3>
                <p>You haven't submitted any crop reports yet.</p>
                <br>
                <a href="Farmer_YourReports33.jsp" class="btn-action btn-view">
                    <i class="fas fa-plus"></i> Submit Your First Report
                </a>
            </div>
            
            <%
                }
            %>
        </div>
    </div>
    
    <script>
        function showImage(reportId) {
            window.open("ImageOpenServlet?id=" + reportId, "_blank", 
                       "width=600,height=600,scrollbars=yes");
        }
        
        // Add animation to table rows
        document.addEventListener('DOMContentLoaded', function() {
            const tableRows = document.querySelectorAll('.reports-table tbody tr');
            tableRows.forEach((row, index) => {
                row.style.opacity = '0';
                row.style.transform = 'translateX(-20px)';
                row.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                
                setTimeout(() => {
                    row.style.opacity = '1';
                    row.style.transform = 'translateX(0)';
                }, 100 * index);
            });
        });
    </script>
</body>
</html>