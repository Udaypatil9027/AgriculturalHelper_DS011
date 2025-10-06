<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Farmer Dashboard - AgriHelp Portal</title>
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
        
        /* Background Video with Blur Effect */
        .video-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -2;
            overflow: hidden;
        }
        
      #bgVideo {
    position: absolute;
    top: 50%;
    left: 50%;
    min-width: 100%;
    min-height: 100%;
    width: auto;
    height: auto;
    transform: translateX(-50%) translateY(-50%);
    object-fit: cover;
    filter: brightness(0.9); /* keep it normal, slightly dim for readability */
}


        
        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--overlay-dark);
            z-index: -1;
        }
        
        .dashboard-container {
            max-width: 1400px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }
        
        /* Enhanced Header */
        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
            padding: 25px 30px;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            border-radius: 20px;
            color: var(--white);
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
        }
        
        .dashboard-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(to bottom right, rgba(255, 255, 255, 0.1), transparent);
            transform: rotate(-15deg);
            pointer-events: none;
        }
        
        .welcome-section h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            margin-bottom: 8px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }
        
        .welcome-section p {
            opacity: 0.9;
            font-size: 1.1rem;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
        }
        
        .header-actions {
            display: flex;
            gap: 15px;
            align-items: center;
        }
        
        .notification-btn, .dev-info-btn {
            background: rgba(255, 255, 255, 0.25);
            border: none;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            color: var(--white);
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            transition: var(--transition);
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .notification-btn:hover, .dev-info-btn:hover {
            background: rgba(255, 255, 255, 0.4);
            transform: translateY(-3px);
        }
        
        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: var(--secondary-color);
            color: var(--white);
            border-radius: 50%;
            width: 24px;
            height: 24px;
            font-size: 0.8rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
        }
        
        .btn-logout {
            display: inline-flex;
            align-items: center;
            gap: 12px;
            padding: 12px 24px;
            background: linear-gradient(135deg, #ff5252 0%, #b33939 100%);
            color: var(--white);
            text-decoration: none;
            border-radius: 12px;
            transition: var(--transition);
            font-weight: 600;
            border: none;
            cursor: pointer;
            box-shadow: 0 10px 20px rgba(179, 57, 57, 0.3);
            font-size: 1rem;
        }
        
        .btn-logout:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 15px 30px rgba(179, 57, 57, 0.4);
        }
        
        /* Main Content Layout */
        .dashboard-content {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 30px;
            margin-bottom: 40px;
        }
        
        .main-content {
            display: flex;
            flex-direction: column;
            gap: 30px;
        }
        
        .sidebar {
            display: flex;
            flex-direction: column;
            gap: 30px;
        }
        
        /* Enhanced Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 25px;
            text-align: center;
            box-shadow: var(--shadow);
            transition: var(--transition);
            backdrop-filter: blur(10px);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            border: 1px solid rgba(255, 255, 255, 0.3);
            position: relative;
            overflow: hidden;
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, var(--primary-color), var(--primary-light));
        }
        
        .stat-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }
        
        .stat-icon {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 15px;
            width: 70px;
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(76, 175, 80, 0.1);
            border-radius: 20px;
            transition: var(--transition);
        }
        
        .stat-card:hover .stat-icon {
            transform: scale(1.1) rotate(5deg);
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary-color) 100%);
            color: var(--white);
        }
        
        .stat-value {
            font-size: 2.2rem;
            font-weight: 800;
            color: var(--primary-dark);
            margin: 10px 0;
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary-color) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .stat-label {
            font-size: 0.9rem;
            color: var(--text-light);
            font-weight: 500;
        }
        
        /* Enhanced Action Cards */
        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }
        
        .action-card {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 30px 25px;
            text-align: center;
            box-shadow: var(--shadow);
            transition: var(--transition);
            cursor: pointer;
            backdrop-filter: blur(10px);
            display: flex;
            flex-direction: column;
            align-items: center;
            border: 1px solid rgba(255, 255, 255, 0.3);
            position: relative;
            overflow: hidden;
        }
        
        .action-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary-color) 100%);
            opacity: 0;
            transition: var(--transition);
            z-index: -1;
        }
        
        .action-card:hover {
            transform: translateY(-10px) scale(1.03);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.2);
            color: var(--white);
        }
        
        .action-card:hover::before {
            opacity: 1;
        }
        
        .action-card:hover .action-icon,
        .action-card:hover .action-title,
        .action-card:hover .action-desc {
            color: var(--white);
        }
        
        .action-icon {
            font-size: 3rem;
            margin-bottom: 20px;
            color: var(--primary-color);
            transition: var(--transition);
        }
        
        .action-card:hover .action-icon {
            transform: scale(1.2) rotate(10deg);
        }
        
        .action-title {
            font-weight: 700;
            margin-bottom: 12px;
            color: var(--primary-dark);
            font-size: 1.3rem;
            transition: var(--transition);
        }
        
        .action-desc {
            color: var(--text-light);
            font-size: 0.9rem;
            line-height: 1.5;
            transition: var(--transition);
        }
        
        /* Enhanced Info Cards */
        .info-card {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 30px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            transition: var(--transition);
        }
        
        .info-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }
        
        .section-title {
            font-size: 1.5rem;
            color: var(--primary-dark);
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 3px solid var(--primary-light);
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .section-title i {
            background: linear-gradient(135deg, var(--primary-light) 0%, var(--primary-color) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        /* Enhanced Weather Cards */
        .weather-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(130px, 1fr));
            gap: 15px;
        }
        
        .weather-card {
            background: rgba(255, 255, 255, 0.9);
            padding: 20px 15px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            transition: var(--transition);
        }
        
        .weather-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        }
        
        .weather-icon {
            font-size: 2.2rem;
            color: var(--secondary-color);
            margin-bottom: 12px;
            filter: drop-shadow(0 3px 5px rgba(0, 0, 0, 0.1));
        }
        
        .day-name {
            font-weight: 700;
            font-size: 1rem;
            margin-bottom: 8px;
            color: var(--primary-dark);
        }
        
        .weather-temp {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--primary-dark);
            margin-bottom: 5px;
        }
        
        .weather-desc {
            font-size: 0.85rem;
            color: var(--text-light);
            font-weight: 500;
        }
        
        /* Enhanced Quick Tips */
        .quick-tips {
            background: linear-gradient(135deg, rgba(255, 152, 0, 0.15) 0%, rgba(255, 152, 0, 0.05) 100%);
            border-left: 5px solid var(--secondary-color);
            padding: 20px;
            border-radius: 0 15px 15px 0;
            margin: 15px 0;
            transition: var(--transition);
        }
        
        .quick-tips:hover {
            transform: translateX(5px);
        }
        
        .quick-tips h4 {
            color: var(--secondary-color);
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1.1rem;
        }
        
        .quick-tips p {
            font-size: 0.95rem;
            line-height: 1.6;
            color: var(--text-dark);
        }
        
        /* Enhanced App Guide */
        .app-guide {
            margin-top: 20px;
        }
        
        .guide-item {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 15px;
            padding: 15px;
            border-radius: 15px;
            background: rgba(76, 175, 80, 0.08);
            transition: var(--transition);
        }
        
        .guide-item:hover {
            background: rgba(76, 175, 80, 0.15);
            transform: translateX(5px);
        }
        
        .guide-number {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            color: var(--white);
            width: 32px;
            height: 32px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
            font-weight: 700;
            flex-shrink: 0;
            box-shadow: 0 5px 15px rgba(76, 175, 80, 0.3);
        }
        
        .guide-text {
            font-size: 0.95rem;
            line-height: 1.5;
            color: var(--text-dark);
        }
        
        /* Developer Info Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }
        
        .modal-content {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 30px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.3);
            position: relative;
            transform: translateY(-50px);
            opacity: 0;
            transition: all 0.4s ease;
        }
        
        .modal.show .modal-content {
            transform: translateY(0);
            opacity: 1;
        }
        
        .close-modal {
            position: absolute;
            top: 20px;
            right: 20px;
            font-size: 1.5rem;
            color: var(--text-light);
            cursor: pointer;
            transition: var(--transition);
        }
        
        .close-modal:hover {
            color: var(--primary-color);
            transform: rotate(90deg);
        }
        
        .dev-info h3 {
            color: var(--primary-dark);
            margin-bottom: 20px;
            text-align: center;
            font-size: 1.8rem;
        }
        
        .dev-info p {
            margin-bottom: 15px;
            line-height: 1.6;
        }
        
        .dev-contact {
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid rgba(0, 0, 0, 0.1);
        }
        
        /* Footer */
        .footer {
            text-align: center;
            margin-top: 50px;
            color: var(--text-light);
            font-size: 0.9rem;
        }
        
        /* Responsive Design */
        @media (max-width: 1200px) {
            .dashboard-content {
                grid-template-columns: 1fr;
            }
            
            .sidebar {
                order: -1;
            }
        }
        
        @media (max-width: 900px) {
            .dashboard-header {
                flex-direction: column;
                text-align: center;
                gap: 20px;
                padding: 20px;
            }
            
            .header-actions {
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .actions-grid {
                grid-template-columns: 1fr 1fr;
            }
            
            .welcome-section h2 {
                font-size: 2rem;
            }
        }
        
        @media (max-width: 600px) {
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .actions-grid {
                grid-template-columns: 1fr;
            }
            
            body {
                padding: 15px;
            }
            
            .stat-card, .action-card, .info-card {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <!-- Background Video Container -->
    <div class="video-container">
        <video autoplay muted loop id="bgVideo">
            <source src="resources/bgt_Farmer.mp4" type="video/mp4">
            Your browser does not support HTML5 video.
        </video>
    </div>

    <!-- Dark Overlay -->
    <div class="overlay"></div>

    <%
        // Check if session exists
        if (session.getAttribute("fname") == null) {
            response.sendRedirect("Farmer_Login33.html");
            return;
        }

        String fname = (String) session.getAttribute("fname");
    %>

    <!-- Developer Info Modal -->
    <div class="modal" id="devModal">
        <div class="modal-content">
            <span class="close-modal">&times;</span>
            <div class="dev-info">
                <h3><i class="fas fa-code"></i> About Us</h3>
                <p><strong>AgriHelp Portal</strong> is developed to assist farmers with crop management and disease diagnosis.</p>
                <p>Our team of agricultural experts and developers work together to provide the best solutions for your farming needs.</p>
                <div class="dev-contact">
                    <p><i class="fas fa-envelope"></i> Contact: support@agrihelp.com</p>
                    <p><i class="fas fa-phone"></i> Helpline: +91 9021064800</p>
                    <p><i class="fas fa-globe"></i> Website: www.agrihelpportal.com</p>
                </div>
            </div>
        </div>
    </div>

    <div class="dashboard-container">
        <!-- Header Section -->
        <div class="dashboard-header">
            <div class="welcome-section">
                <h2>Welcome, <%=fname%>!To Farmer Dashoard</h2>
                <p>Your Personal Farming Assistant - AgriHelp Portal</p>
            </div>
            
            <div class="header-actions">
                <button class="dev-info-btn" id="devInfoBtn">
                    <i class="fas fa-code"></i>
                </button>
                
                <a href="Farmer_Login33.html" class="btn-logout" onclick="return confirm('Are you sure you want to logout?');">
    <i class="fas fa-sign-out-alt"></i> Logout
</a>
            </div>
        </div>
        
        <!-- Main Content -->
        <div class="dashboard-content">
            <div class="main-content">
                
                <!-- Action Cards -->
                <div class="actions-grid">
                    <div class="action-card" onclick="location.href='Farmer_YourReports33.jsp'">
                        <i class="fas fa-bug action-icon"></i>
                        <h3 class="action-title">Report Disease</h3>
                        <p class="action-desc">Submit crop issues and get expert advice within 24 hours</p>
                    </div>
                    
                    <div class="action-card" onclick="location.href='View_YourReports33.jsp'">
                        <i class="fas fa-clipboard-list action-icon"></i>
                        <h3 class="action-title">Your Reports</h3>
                        <p class="action-desc">Track status of all your submitted crop reports</p>
                    </div>
                    
                    <div class="action-card" onclick="location.href='View_AllYourSolution33.jsp'">
                        <i class="fas fa-lightbulb action-icon"></i>
                        <h3 class="action-title">View Solutions</h3>
                        <p class="action-desc">Access expert solutions for your crop problems</p>
                    </div>
                    
                    <div class="action-card" onclick="location.href='ResetPassword_Farmer33.jsp'">
                        <i class="fas fa-key action-icon"></i>
                        <h3 class="action-title">Reset Password</h3>
                        <p class="action-desc">Update your account security settings</p>
                    </div>
                </div>
                
                <!-- App Information -->
                <div class="info-card">
                    <h3 class="section-title"><i class="fas fa-info-circle"></i> About AgriHelp Portal</h3>
                    <p>AgriHelp connects farmers with agricultural experts to solve crop problems quickly and efficiently. Our platform helps you get professional advice for your farming challenges.</p>
                    
                    <div class="app-guide">
                        <div class="guide-item">
                            <span class="guide-number">1</span>
                            <span class="guide-text">Report crop issues with photos for accurate diagnosis</span>
                        </div>
                        <div class="guide-item">
                            <span class="guide-number">2</span>
                            <span class="guide-text">Receive expert solutions within 24 hours</span>
                        </div>
                        <div class="guide-item">
                            <span class="guide-number">3</span>
                            <span class="guide-text">Track your report status and history</span>
                        </div>
                        <div class="guide-item">
                            <span class="guide-number">4</span>
                            <span class="guide-text">Access preventive tips for common crop diseases</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Sidebar -->
            <div class="sidebar">
                <!-- Weather Forecast -->
                <div class="info-card">
                    <h3 class="section-title"><i class="fas fa-cloud-sun"></i> Weather Forecast</h3>
                    <div class="weather-cards">
                        <div class="weather-card">
                            <i class="fas fa-sun weather-icon"></i>
                            <div class="day-name">Today</div>
                            <div class="weather-temp">28°C</div>
                            <div class="weather-desc">Sunny</div>
                        </div>
                        <div class="weather-card">
                            <i class="fas fa-cloud-sun weather-icon"></i>
                            <div class="day-name">Tomorrow</div>
                            <div class="weather-temp">26°C</div>
                            <div class="weather-desc">Partly Cloudy</div>
                        </div>
                        <div class="weather-card">
                            <i class="fas fa-cloud-rain weather-icon"></i>
                            <div class="day-name">Next Day</div>
                            <div class="weather-temp">24°C</div>
                            <div class="weather-desc">Light Rain</div>
                        </div>
                    </div>
                </div>
                
                <!-- Farming Tips -->
                <div class="info-card">
                    <h3 class="section-title"><i class="fas fa-lightbulb"></i> Farming Tips</h3>
                    <div class="quick-tips">
                        <h4><i class="fas fa-seedling"></i> Crop Rotation</h4>
                        <p>Rotate your crops seasonally to maintain soil health and reduce pest problems.</p>
                    </div>
                    <div class="quick-tips">
                        <h4><i class="fas fa-tint"></i> Water Management</h4>
                        <p>Water your crops early morning to reduce evaporation and prevent fungal diseases.</p>
                    </div>
                    <div class="quick-tips">
                        <h4><i class="fas fa-bug"></i> Pest Control</h4>
                        <p>Use natural predators like ladybugs for organic pest control in your fields.</p>
                    </div>
                </div>
               
            </div>
        </div>
        
        <!-- Footer -->
        <div class="footer">
            <p>&copy; 2023 AgriHelp Portal ~ By Uday Patil | Connecting Farmers with Experts</p>
        </div>
    </div>

    <script>
        // Enhanced animations and video handling
        document.addEventListener('DOMContentLoaded', function() {
            const video = document.getElementById('bgVideo');
            
            // Try to play video with better error handling
            const playVideo = () => {
                video.play().catch(e => {
                    console.log("Video play failed, will retry after interaction");
                });
            };
            
            playVideo();
            
            // Retry on user interaction
            document.addEventListener('click', function() {
                playVideo();
            }, { once: true });
            
            // Enhanced animations for cards with staggered delay
            const cards = document.querySelectorAll('.stat-card, .action-card, .info-card, .quick-tips');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(30px) scale(0.95)';
                card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                
                setTimeout(() => {
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0) scale(1)';
                }, 150 * index);
            });
            
            // Add subtle floating animation to action cards
            setInterval(() => {
                document.querySelectorAll('.action-card').forEach(card => {
                    card.style.transform = 'translateY(-5px)';
                    setTimeout(() => {
                        card.style.transform = 'translateY(0)';
                    }, 3000);
                });
            }, 6000);
            
            // Modal functionality
            const modal = document.getElementById('devModal');
            const devInfoBtn = document.getElementById('devInfoBtn');
            const closeModal = document.querySelector('.close-modal');
            
            devInfoBtn.addEventListener('click', () => {
                modal.style.display = 'flex';
                setTimeout(() => {
                    modal.classList.add('show');
                }, 10);
            });
            
            closeModal.addEventListener('click', () => {
                modal.classList.remove('show');
                setTimeout(() => {
                    modal.style.display = 'none';
                }, 400);
            });
            
            window.addEventListener('click', (e) => {
                if (e.target === modal) {
                    modal.classList.remove('show');
                    setTimeout(() => {
                        modal.style.display = 'none';
                    }, 400);
                }
            });
        });
    </script>
</body>
</html>