<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Add Agronomist - AgriHelp Portal</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Link CSS -->
    <link rel="stylesheet" type="text/css" href="resources/css/style.css">
    <style>
        /* Form-specific styles */
        .form-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 80px);
            padding: 40px 20px;
        }
        
        .form-card {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 600px;
        }
        
        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .form-header h2 {
            color: var(--primary-dark);
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            margin-bottom: 10px;
        }
        
        .form-header p {
            color: var(--gray);
            font-size: 16px;
        }
        
        .form-icon {
            font-size: 50px;
            color: var(--primary);
            background: rgba(74, 142, 60, 0.1);
            width: 80px;
            height: 80px;
            line-height: 80px;
            border-radius: 50%;
            margin: 0 auto 20px;
        }
        
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group.full-width {
            grid-column: span 2;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--dark);
        }
        
        .input-with-icon {
            position: relative;
        }
        
        .input-with-icon i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary);
            font-size: 18px;
        }
        
        .input-with-icon input, 
        .input-with-icon select, 
        .input-with-icon textarea {
            width: 100%;
            padding: 15px 15px 15px 45px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s;
            font-family: 'Roboto', sans-serif;
        }
        
        .input-with-icon input:focus, 
        .input-with-icon select:focus, 
        .input-with-icon textarea:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(74, 142, 60, 0.2);
            outline: none;
        }
        
        textarea {
            min-height: 100px;
            resize: vertical;
        }
        
        .form-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
            grid-column: span 2;
        }
        
        .btn-submit {
            background: var(--primary);
            color: var(--white);
            border: none;
            padding: 15px 30px;
            font-size: 18px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }
        
        .btn-submit:hover {
            background: var(--primary-dark);
        }
        
        .btn-back {
            background: var(--gray);
            color: var(--white);
            text-decoration: none;
            padding: 15px 30px;
            border-radius: 8px;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s ease;
        }
        
        .btn-back:hover {
            background: #444;
        }
        
        /* Responsive adjustments */
        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
            
            .form-group.full-width {
                grid-column: span 1;
            }
            
            .form-actions {
                flex-direction: column;
                gap: 15px;
            }
            
            .btn-submit, .btn-back {
                width: 100%;
                justify-content: center;
            }
        }
        
        @media (max-width: 480px) {
            .form-card {
                padding: 30px 20px;
            }
            
            .form-header h2 {
                font-size: 24px;
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
                <li><a href="Admin_Login11.html"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </nav>
    </header>

    <!-- Form Container -->
    <div class="form-container">
        <div class="form-card">
            <div class="form-header">
                <div class="form-icon">
                    <i class="fas fa-user-graduate"></i>
                </div>
                <h2>Add New Agronomist</h2>
                <p>Fill in the details to register a new agronomist</p>
            </div>
            
            <form action="Add_Agronomist11" method="post">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="aname">Agronomist Name</label>
                        <div class="input-with-icon">
                            <i class="fas fa-user"></i>
                            <input type="text" id="aname" name="aname" placeholder="Full name" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="contact">Contact Number</label>
                        <div class="input-with-icon">
                            <i class="fas fa-phone"></i>
                            <input type="text" id="contact" name="contact" 
                                   placeholder="Phone number" 
                                   required 
                                   pattern="[0-9]{10}" 
                                   maxlength="10"
                                   title="Enter a valid 10-digit phone number">
                        </div>
                    </div>
                    
                    <div class="form-group full-width">
                        <label for="email">Email Address</label>
                        <div class="input-with-icon">
                            <i class="fas fa-envelope"></i>
                            <input type="email" id="email" name="email" placeholder="Email address" required>
                        </div>
                    </div>
                    
                    <div class="form-group full-width">
                        <label for="expertise">Area of Expertise</label>
                        <div class="input-with-icon">
                            <i class="fas fa-seedling"></i>
                            <input type="text" id="expertise" name="expertise" placeholder="Crop specialties" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="pass">Password</label>
                        <div class="input-with-icon">
                            <i class="fas fa-lock"></i>
                            <input type="password" id="pass" name="pass" placeholder="Create password" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="confirm-pass">Confirm Password</label>
                        <div class="input-with-icon">
                            <i class="fas fa-lock"></i>
                            <input type="password" id="confirm-pass" name="confirm-pass" placeholder="Confirm password" required>
                        </div>
                    </div>
                </div>
                
                <div class="form-actions">
                    <a href="Admin_Dashboard11.jsp" class="btn-back">
                        <i class="fas fa-arrow-left"></i> Back to Dashboard
                    </a>
                    <button type="submit" class="btn-submit">
                        <i class="fas fa-user-plus"></i> Add Agronomist
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const password = document.getElementById('pass').value;
            const confirmPassword = document.getElementById('confirm-pass').value;
            const contact = document.getElementById('contact').value;

            // Password check
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match. Please confirm your password.');
                document.getElementById('confirm-pass').focus();
                return;
            }

            // Contact number check
            const phonePattern = /^[0-9]{10}$/;
            if (!phonePattern.test(contact)) {
                e.preventDefault();
                alert('Please enter a valid 10-digit phone number.');
                document.getElementById('contact').focus();
            }
        });
    </script>
</body>
</html>
