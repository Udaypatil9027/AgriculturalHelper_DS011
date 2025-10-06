<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="agriHelp.agronomist_gs" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Agronomist Dashboard - AgriHelp Portal</title>
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
        --card-bg-solid: #f8f9fa;
        --header-bg: rgba(56, 142, 60, 0.9);
        --shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        --transition: all 0.3s ease;
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
    
    .dashboard-container {
        max-width: 1200px;
        margin: 0 auto;
        position: relative;
        z-index: 1;
    }
    
    .dashboard-header {
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
    
    .date-section {
        text-align: right;
    }
    
    .dashboard-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }
    
    .card {
        background: var(--card-bg);
        border-radius: 10px;
        padding: 20px;
        box-shadow: var(--shadow);
        transition: var(--transition);
        backdrop-filter: blur(5px);
    }
    
    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
    }
    
    .card-header {
        display: flex;
        align-items: center;
        margin-bottom: 15px;
        padding-bottom: 10px;
        border-bottom: 1px solid rgba(0, 0, 0, 0.1);
    }
    
    .card-icon {
        width: 40px;
        height: 40px;
        background: var(--primary-light);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-right: 15px;
        color: var(--white);
    }
    
    .card-title {
        font-weight: 500;
        color: var(--primary-dark);
    }
    
    .stat-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 15px;
    }
    
    .stat-item {
        text-align: center;
        padding: 15px;
        background: rgba(255, 255, 255, 0.7);
        border-radius: 8px;
        backdrop-filter: blur(5px);
    }
    
    .stat-value {
        font-size: 1.8rem;
        font-weight: 700;
        color: var(--primary-color);
        margin: 10px 0;
    }
    
    .stat-label {
        font-size: 0.9rem;
        color: var(--text-dark);
    }
    
    .action-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }
    
    .action-card {
        background: var(--card-bg);
        border-radius: 10px;
        padding: 25px;
        text-align: center;
        box-shadow: var(--shadow);
        transition: var(--transition);
        cursor: pointer;
        backdrop-filter: blur(5px);
    }
    
    .action-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        background: linear-gradient(135deg, rgba(106, 191, 105, 0.9) 0%, rgba(56, 142, 60, 0.9) 100%);
        color: var(--white);
    }
    
    .action-card:hover .action-icon,
    .action-card:hover .action-title,
    .action-card:hover .action-desc {
        color: var(--white);
    }
    
    .action-icon {
        font-size: 2.5rem;
        margin-bottom: 15px;
        color: var(--primary-color);
    }
    
    .action-title {
        font-weight: 600;
        margin-bottom: 10px;
        color: var(--primary-dark);
    }
    
    .action-desc {
        color: var(--text-dark);
        font-size: 0.9rem;
    }
    
    .info-section {
        margin-bottom: 30px;
    }
    
    .info-title {
        font-size: 1.5rem;
        margin-bottom: 20px;
        color: var(--white);
        padding-bottom: 10px;
        border-bottom: 2px solid var(--primary-light);
    }
    
    .info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 20px;
    }
    
    .info-card {
        background: var(--card-bg);
        border-radius: 10px;
        padding: 20px;
        box-shadow: var(--shadow);
        backdrop-filter: blur(5px);
    }
    
    .info-card-header {
        display: flex;
        align-items: center;
        margin-bottom: 15px;
    }
    
    .info-card-icon {
        width: 30px;
        height: 30px;
        background: var(--accent-color);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-right: 10px;
        color: var(--white);
    }
    
    .info-card-title {
        font-weight: 500;
        color: var(--primary-dark);
    }
    
    .crop-tip {
        background: linear-gradient(135deg, rgba(232, 245, 233, 0.8) 0%, rgba(200, 230, 201, 0.8) 100%);
        border-left: 4px solid var(--primary-color);
        padding: 15px;
        border-radius: 0 8px 8px 0;
        margin: 15px 0;
        backdrop-filter: blur(5px);
    }
    
    .btn {
        display: inline-block;
        padding: 12px 24px;
        background: var(--primary-color);
        color: var(--white);
        border: none;
        border-radius: 5px;
        font-weight: 500;
        cursor: pointer;
        transition: var(--transition);
        text-decoration: none;
        margin: 5px;
        box-shadow: var(--shadow);
    }
    
    .btn:hover {
        background: var(--primary-dark);
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
    }
    
    .btn-logout {
        background: var(--secondary-color);
    }
    
    .btn-logout:hover {
        background: #b71c1c;
    }
    
    .dashboard-stats {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }
    
    .stat-card {
        background: var(--card-bg);
        border-radius: 10px;
        padding: 20px;
        text-align: center;
        box-shadow: var(--shadow);
        backdrop-filter: blur(5px);
    }
    
    .stat-card i {
        font-size: 2rem;
        color: var(--primary-color);
        margin-bottom: 10px;
    }
    
    .stat-card h3 {
        font-size: 1.8rem;
        color: var(--primary-dark);
        margin: 10px 0;
    }
    
    .stat-card p {
        color: var(--text-dark);
        font-size: 0.9rem;
    }
    
    @media (max-width: 768px) {
        .dashboard-header {
            flex-direction: column;
            text-align: center;
        }
        
        .date-section {
            text-align: center;
            margin-top: 15px;
        }
        
        .action-grid {
            grid-template-columns: 1fr;
        }
        
        .dashboard-stats {
            grid-template-columns: repeat(2, 1fr);
        }
    }
    
    @media (max-width: 480px) {
        .dashboard-stats {
            grid-template-columns: 1fr;
        }
        
        body {
            padding: 10px;
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

<% if (session.getAttribute("aname") == null) {
    response.sendRedirect("Agronomist_Login22.html");
    return;
}
String aname = (String) session.getAttribute("aname");
%>

<div class="dashboard-container">
    <div class="dashboard-header">
        <div class="welcome-section">
            <h2>Welcome, <%= aname %></h2>
            <p>Agronomist Dashboard - AgriHelp Portal</p>
        </div>
       
        <div class="date-section">
            <p><%= new java.util.Date() %></p>
        </div>
         <a href="Agronomist_Login22.html" class="btn btn-logout" onclick="return confirm('Are you sure you want to logout?');">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>        
   
    <div class="action-grid">
        <div class="action-card" onclick="location.href='View_FarmerReports22.jsp'">
            <div class="action-icon">
                <i class="fas fa-clipboard-list"></i>
            </div>
            <h3 class="action-title">View Farmer Reports</h3>
            <p class="action-desc">Review and respond to farmer crop issues and concerns</p>
        </div>
        
        <div class="action-card" onclick="location.href='Agronomist_Solutions22.jsp'">
            <div class="action-icon">
                <i class="fas fa-lightbulb"></i>
            </div>
            <h3 class="action-title">Your Suggestions</h3>
            <p class="action-desc">View and manage your previously provided solutions</p>
        </div>
        
        <div class="action-card" onclick="location.href='ResetPass_Agronomist22.jsp'">
            <div class="action-icon">
                <i class="fas fa-key"></i>
            </div>
            <h3 class="action-title">Reset Password</h3>
            <p class="action-desc">Update your account password for security purposes</p>
        </div>
    </div>
    
    <div class="info-section">
        <h3 class="info-title">Crop Health Tips</h3>
        <div class="info-grid">
            <div class="info-card">
                <div class="info-card-header">
                    <div class="info-card-icon">
                        <i class="fas fa-bug"></i>
                    </div>
                    <h4 class="info-card-title">Pest Alert</h4>
                </div>
                <p>Increased reports of Fall Armyworm in maize crops. Recommend regular monitoring and early intervention with approved biopesticides.</p>
            </div>
            
            <div class="info-card">
                <div class="info-card-header">
                    <div class="info-card-icon">
                        <i class="fas fa-tint"></i>
                    </div>
                    <h4 class="info-card-title">Irrigation Advice</h4>
                </div>
                <p>With temperatures rising, recommend drip irrigation in the morning hours to reduce water evaporation and ensure optimal absorption.</p>
            </div>
            
            <div class="info-card">
                <div class="info-card-header">
                    <div class="info-card-icon">
                        <i class="fas fa-seedling"></i>
                    </div>
                    <h4 class="info-card-title">Crop Rotation</h4>
                </div>
                <p>For farmers growing legumes, recommend rotating with cereals next season to improve soil nitrogen levels naturally.</p>
            </div>
        </div>
    </div>
    
    <div style="text-align: center; margin-top: 30px;">
        <a href="View_FarmerReports22.jsp" class="btn">
            <i class="fas fa-clipboard-list"></i> View Reports
        </a>
        <a href="Agronomist_Solutions22.jsp" class="btn">
            <i class="fas fa-lightbulb"></i> View Your Suggestions
        </a>
        <a href="ResetPass_Agronomist22.jsp" class="btn">
            <i class="fas fa-key"></i> Reset Password
        </a>
       
    </div>
</div>

<script>
    // Simple animation for cards when they come into view
    document.addEventListener('DOMContentLoaded', function() {
        const cards = document.querySelectorAll('.card, .action-card, .stat-card, .info-card');
        
        cards.forEach(card => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';
            card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
        });
        
        setTimeout(() => {
            cards.forEach((card, index) => {
                setTimeout(() => {
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, 100 * index);
            });
        }, 100);
    });
</script>
</body>
</html>