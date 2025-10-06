<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="agriHelp.DbConnection"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Solutions - AgriHelp Portal</title>
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
            max-width: 1200px;
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
        
        /* Report Info */
        .report-info {
            background: rgba(76, 175, 80, 0.1);
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            border-left: 4px solid var(--primary-color);
        }
        
        .report-info h4 {
            color: var(--primary-dark);
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }
        
        .info-item {
            display: flex;
            flex-direction: column;
        }
        
        .info-label {
            font-size: 0.85rem;
            color: var(--text-light);
            margin-bottom: 5px;
        }
        
        .info-value {
            font-weight: 600;
            color: var(--primary-dark);
        }
        
        /* Solutions List */
        .solutions-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        
        .solution-card {
            background: var(--card-bg);
            border-radius: 15px;
            padding: 25px;
            box-shadow: var(--shadow);
            border: 1px solid rgba(0, 0, 0, 0.05);
            transition: var(--transition);
        }
        
        .solution-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        }
        
        .solution-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid rgba(0, 0, 0, 0.05);
        }
        
        .agronomist-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .agronomist-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            font-weight: bold;
        }
        
        .agronomist-details h4 {
            color: var(--primary-dark);
            margin-bottom: 5px;
        }
        
        .agronomist-details p {
            color: var(--text-light);
            font-size: 0.9rem;
        }
        
        .solution-date {
            color: var(--text-light);
            font-size: 0.9rem;
            text-align: right;
        }
        
        .solution-content {
            margin-bottom: 20px;
        }
        
        .solution-content h5 {
            color: var(--primary-dark);
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .solution-text {
            background: rgba(255, 248, 225, 0.5);
            padding: 20px;
            border-radius: 10px;
            border-left: 4px solid var(--secondary-color);
            line-height: 1.7;
        }
        
        .solution-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 15px;
            border-top: 1px solid rgba(0, 0, 0, 0.05);
            color: var(--text-light);
            font-size: 0.9rem;
        }
        
        /* No Solutions Message */
        .no-solutions {
            text-align: center;
            padding: 40px;
            color: var(--text-light);
        }
        
        .no-solutions-icon {
            font-size: 3rem;
            color: #e0e0e0;
            margin-bottom: 20px;
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
        @media (max-width: 900px) {
            .header {
                flex-direction: column;
                text-align: center;
                gap: 20px;
            }
            
            .welcome-section h2 {
                font-size: 1.8rem;
            }
            
            .solution-header {
                flex-direction: column;
                gap: 15px;
            }
            
            .solution-date {
                text-align: left;
            }
            
            .action-buttons {
                flex-direction: column;
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
            
            .agronomist-info {
                flex-direction: column;
                text-align: center;
            }
            
            .info-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <%
    if (session.getAttribute("fname") == null) {
        response.sendRedirect("Farmer_Login33.html");
        return;
    }
    
    String fcontact = (String) session.getAttribute("fcontact");
    String fname = (String) session.getAttribute("fname");
    
    int fid = 0;
    int rid = 0;
    String cropName = "";
    String symptoms = "";
    String reportDate = "";
    
    Connection con = DbConnection.connect();
    
    // Get farmerId
    PreparedStatement pt1 = con.prepareStatement("SELECT * FROM farmer WHERE fcontact=?");
    pt1.setString(1, fcontact);
    ResultSet rs1 = pt1.executeQuery();
    if(rs1.next()){
        fid = rs1.getInt("farmerId");
    }
    
    if (request.getParameter("rid") != null) {
        rid = Integer.parseInt(request.getParameter("rid"));
        
        // Get report details
        PreparedStatement ptReport = con.prepareStatement(
            "SELECT * FROM reports WHERE reportId=?"
        );
        ptReport.setInt(1, rid);
        ResultSet rsReport = ptReport.executeQuery();
        if(rsReport.next()){
            cropName = rsReport.getString("cropName");
            symptoms = rsReport.getString("symptoms");
            reportDate = rsReport.getString("dateReported");
        }
    } else {
        out.println("<p style='color:red;'>No report selected.</p>");
        return;
    }
    %>

    <div class="container">
        <!-- Header -->
        <div class="header">
            <div class="welcome-section">
                <h2>Welcome, <%= fname %>!</h2>
                <p>Expert Solutions for Your Crop Issues</p>
            </div>
            
            <a href="Farmer_Dashboard33.jsp" class="btn">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
        
        <!-- Solutions Container -->
        <div class="solutions-container">
            <h2 class="solutions-title"><i class="fas fa-lightbulb"></i> Solutions for Report #<%= rid %></h2>
            
            <!-- Report Information -->
            <div class="report-info">
                <h4><i class="fas fa-clipboard-list"></i> Report Details</h4>
                <div class="info-grid">
                    <div class="info-item">
                        <span class="info-label">Crop Name</span>
                        <span class="info-value"><%= cropName %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Symptoms</span>
                        <span class="info-value"><%= symptoms %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Report Date</span>
                        <span class="info-value"><%= reportDate %></span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">Report ID</span>
                        <span class="info-value">#<%= rid %></span>
                    </div>
                </div>
            </div>
            
            <%
            PreparedStatement pt3 = con.prepareStatement(
                "SELECT * FROM solutions WHERE reportId=?"
            );
            pt3.setInt(1, rid);
            ResultSet rs3 = pt3.executeQuery();
            
            if (rs3.isBeforeFirst()) {
            %>
                <div class="solutions-list">
                <%
                while(rs3.next()) {
                    String agronomistName = rs3.getString("agname");
                    String agronomistInitial = agronomistName.substring(0, 1).toUpperCase();
                    String suggestion = rs3.getString("suggestion");
                    String dateProvided = rs3.getString("dateProvided");
                %>
                    <div class="solution-card">
                        <div class="solution-header">
                            <div class="agronomist-info">
                                <div class="agronomist-avatar">
                                    <%= agronomistInitial %>
                                </div>
                                <div class="agronomist-details">
                                    <h4><%= agronomistName %></h4>
                                    <p>Agronomist ID: <%= rs3.getInt("agroId") %></p>
                                </div>
                            </div>
                            <div class="solution-date">
                                <i class="far fa-calendar-alt"></i> <%= dateProvided %>
                            </div>
                        </div>
                        
                        <div class="solution-content">
                            <h5><i class="fas fa-seedling"></i> Expert Solution</h5>
                            <div class="solution-text">
                                <%= suggestion %>
                            </div>
                        </div>
                        
                        <div class="solution-meta">
                            <span>Solution ID: <%= rs3.getInt("solutionId") %></span>
                            <span>Report ID: <%= rs3.getInt("reportId") %></span>
                        </div>
                    </div>
                <%
                }
                %>
                </div>
            <%
            } else {
            %>
                <div class="no-solutions">
                    <i class="fas fa-lightbulb no-solutions-icon"></i>
                    <h3>No Solutions Yet</h3>
                    <p>Our agronomists are reviewing your report and will provide solutions soon.</p>
                </div>
            <%
            }
            %>
            
            <div class="action-buttons">
                <a href="View_YourReports33.jsp" class="btn-primary">
                    <i class="fas fa-list"></i> View All Reports
                </a>
                <a href="Farmer_Dashboard33.jsp" class="btn-secondary">
                    <i class="fas fa-home"></i> Back to Dashboard
                </a>
            </div>
        </div>
    </div>
    
    <script>
        // Add animation to solution cards
        document.addEventListener('DOMContentLoaded', function() {
            const solutionCards = document.querySelectorAll('.solution-card');
            solutionCards.forEach((card, index) => {
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