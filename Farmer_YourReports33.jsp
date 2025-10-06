<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="agriHelp.farmer_gs" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Report Crop Disease - AgriHelp Portal</title>
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
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
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
            max-width: 800px;
            width: 100%;
            margin: 0 auto;
        }
        
        /* Header */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 20px;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            border-radius: 15px;
            color: var(--white);
            box-shadow: var(--shadow);
        }
        
        .welcome-section h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            margin-bottom: 5px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }
        
        .welcome-section p {
            opacity: 0.9;
            font-size: 1rem;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
        }
        
        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: rgba(255, 255, 255, 0.2);
            color: var(--white);
            text-decoration: none;
            border-radius: 10px;
            transition: var(--transition);
            font-weight: 600;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        
        .btn-back:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-3px);
        }
        
        /* Form Container */
        .form-container {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 30px;
            box-shadow: var(--shadow);
            margin-bottom: 30px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        
        .form-title {
            font-size: 1.8rem;
            color: var(--primary-dark);
            margin-bottom: 25px;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }
        
        .form-group {
            margin-bottom: 25px;
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
    filter: brightness(0.6); /* dim a little for readability */
}

/* Overlay */
.overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.3);
    z-index: -1;
}
        
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--primary-dark);
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .form-input, .form-textarea {
            width: 100%;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1rem;
            transition: var(--transition);
            background: rgba(255, 255, 255, 0.9);
        }
        
        .form-input:focus, .form-textarea:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.2);
        }
        
        .form-textarea {
            min-height: 120px;
            resize: vertical;
        }
        
        .file-upload {
            position: relative;
            display: inline-block;
            width: 100%;
        }
        
        .file-upload-label {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 30px;
            border: 2px dashed #c8e6c9;
            border-radius: 10px;
            background: rgba(232, 245, 233, 0.5);
            cursor: pointer;
            transition: var(--transition);
            text-align: center;
        }
        
        .file-upload-label:hover {
            border-color: var(--primary-color);
            background: rgba(232, 245, 233, 0.8);
        }
        
        .file-upload-icon {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 15px;
        }
        
        .file-upload-text {
            color: var(--text-light);
            margin-bottom: 10px;
        }
        
        .file-upload-btn {
            padding: 8px 16px;
            background: var(--primary-color);
            color: white;
            border-radius: 6px;
            font-size: 0.9rem;
            transition: var(--transition);
        }
        
        .file-upload-label:hover .file-upload-btn {
            background: var(--primary-dark);
        }
        
        #fileName {
            margin-top: 10px;
            font-size: 0.9rem;
            color: var(--primary-dark);
            font-weight: 500;
        }
        
        .btn-submit {
            display: block;
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            color: var(--white);
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 10px 20px rgba(76, 175, 80, 0.3);
        }
        
        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(76, 175, 80, 0.4);
        }
        
        /* Tips Section */
        .tips-container {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 25px;
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        
        .tips-title {
            font-size: 1.3rem;
            color: var(--primary-dark);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .tip-item {
            display: flex;
            align-items: flex-start;
            gap: 15px;
            margin-bottom: 15px;
            padding: 15px;
            border-radius: 10px;
            background: rgba(255, 152, 0, 0.08);
            transition: var(--transition);
        }
        
        .tip-item:hover {
            background: rgba(255, 152, 0, 0.12);
            transform: translateX(5px);
        }
        
        .tip-icon {
            color: var(--secondary-color);
            font-size: 1.2rem;
            margin-top: 2px;
        }
        
        .tip-text {
            color: var(--text-dark);
            line-height: 1.5;
        }
        
        /* Responsive Design */
        @media (max-width: 900px) {
            .header {
                flex-direction: column;
                text-align: center;
                gap: 15px;
            }
            
            .welcome-section h2 {
                font-size: 1.7rem;
            }
        }
        
        @media (max-width: 600px) {
            body {
                padding: 15px;
            }
            
            .form-container, .tips-container {
                padding: 20px;
            }
            
            .form-title {
                font-size: 1.5rem;
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

    <div class="container">
        <!-- Header -->
        <div class="header">
            <div class="welcome-section">
                <h2>Welcome, <%=fname%>!</h2>
                <p>Report Crop Issues - AgriHelp Portal</p>
            </div>
            
            <a href="Farmer_Dashboard33.jsp" class="btn-back">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>

        <!-- Form Container -->
        <div class="form-container">
            <h2 class="form-title"><i class="fas fa-bug"></i> Report Crop Disease</h2>
            
            <form action="Farmer_YourReports33" method="post" enctype="multipart/form-data" id="reportForm">
                <div class="form-group">
                    <label class="form-label"><i class="fas fa-leaf"></i> Crop Name</label>
                    <input type="text" name="crop" class="form-input" placeholder="Enter crop name (e.g., Wheat, Rice, Corn)" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label"><i class="fas fa-first-aid"></i> Symptoms</label>
                    <textarea name="sym" class="form-textarea" placeholder="Describe the symptoms you've observed (e.g., yellow leaves, spots, wilting)" required></textarea>
                </div>
                
                <div class="form-group">
                    <label class="form-label"><i class="fas fa-camera"></i> Upload Image (Optional)</label>
                    <div class="file-upload">
                        <label for="image" class="file-upload-label">
                            <i class="fas fa-cloud-upload-alt file-upload-icon"></i>
                            <span class="file-upload-text">Click to upload or drag and drop</span>
                            <span class="file-upload-btn">Choose File</span>
                            <span id="fileName">No file chosen</span>
                        </label>
                        <input type="file" name="image" id="image" accept="image/*" class="form-input" style="display: none;">
                    </div>
                </div>
                
                <button type="submit" class="btn-submit">
                    <i class="fas fa-paper-plane"></i> Submit Report
                </button>
            </form>
        </div>

        <!-- Tips Section -->
        <div class="tips-container">
            <h3 class="tips-title"><i class="fas fa-lightbulb"></i> Tips for Better Reports</h3>
            
            <div class="tip-item">
                <i class="fas fa-check-circle tip-icon"></i>
                <p class="tip-text">Provide clear, detailed descriptions of symptoms and when they first appeared.</p>
            </div>
            
            <div class="tip-item">
                <i class="fas fa-check-circle tip-icon"></i>
                <p class="tip-text">Take photos in good lighting from multiple angles for accurate diagnosis.</p>
            </div>
            
            <div class="tip-item">
                <i class="fas fa-check-circle tip-icon"></i>
                <p class="tip-text">Include information about weather conditions and soil type if possible.</p>
            </div>
            
            <div class="tip-item">
                <i class="fas fa-check-circle tip-icon"></i>
                <p class="tip-text">Mention any treatments you've already tried and their results.</p>
            </div>
        </div>
    </div>

    <script>
        // File upload name display
        document.getElementById('image').addEventListener('change', function(e) {
            var fileName = e.target.files[0] ? e.target.files[0].name : 'No file chosen';
            document.getElementById('fileName').textContent = fileName;
        });
        
        // Form validation
        document.getElementById('reportForm').addEventListener('submit', function(e) {
            var cropInput = document.querySelector('input[name="crop"]');
            var symInput = document.querySelector('textarea[name="sym"]');
            
            if (!cropInput.value.trim()) {
                e.preventDefault();
                alert('Please enter a crop name');
                cropInput.focus();
                return;
            }
            
            if (!symInput.value.trim()) {
                e.preventDefault();
                alert('Please describe the symptoms');
                symInput.focus();
                return;
            }
        });

        // Add animation to form elements
        document.addEventListener('DOMContentLoaded', function() {
            const formElements = document.querySelectorAll('.form-group, .tips-container');
            formElements.forEach((element, index) => {
                element.style.opacity = '0';
                element.style.transform = 'translateY(20px)';
                element.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                
                setTimeout(() => {
                    element.style.opacity = '1';
                    element.style.transform = 'translateY(0)';
                }, 100 * index);
            });
        });
    </script>
</body>
</html>

</html>