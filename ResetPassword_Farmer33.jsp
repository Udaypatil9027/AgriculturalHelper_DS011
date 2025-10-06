<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="agriHelp.DbConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reset Password - AgriHelp Portal</title>
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
            max-width: 500px;
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
            font-size: 2rem;
            margin-bottom: 8px;
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
            position: relative;
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
        
        .form-input {
            width: 100%;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1rem;
            transition: var(--transition);
            background: rgba(255, 255, 255, 0.9);
            padding-left: 45px;
        }
        
        .form-input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.2);
        }
        
        .input-icon {
            position: absolute;
            left: 15px;
            top: 42px;
            color: var(--primary-color);
            font-size: 1.2rem;
        }
        
        .password-toggle {
            position: absolute;
            right: 15px;
            top: 42px;
            color: var(--text-light);
            cursor: pointer;
            font-size: 1.2rem;
            transition: var(--transition);
        }
        
        .password-toggle:hover {
            color: var(--primary-color);
        }
        
        .password-strength {
            height: 5px;
            margin-top: 8px;
            border-radius: 5px;
            background: #f0f0f0;
            overflow: hidden;
        }
        
        .strength-meter {
            height: 100%;
            width: 0%;
            border-radius: 5px;
            transition: var(--transition);
        }
        
        .strength-weak {
            background: #ff5252;
            width: 33%;
        }
        
        .strength-medium {
            background: #ffb142;
            width: 66%;
        }
        
        .strength-strong {
            background: #2ed573;
            width: 100%;
        }
        
        .strength-text {
            font-size: 0.8rem;
            margin-top: 5px;
            color: var(--text-light);
        }
        
        .form-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        
        .btn-reset {
            flex: 1;
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
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        
        .btn-reset:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(76, 175, 80, 0.4);
        }
        
        .btn-clear {
            flex: 1;
            padding: 16px;
            background: rgba(255, 255, 255, 0.9);
            color: var(--primary-dark);
            border: 2px solid var(--primary-color);
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        
        .btn-clear:hover {
            background: var(--primary-light);
            transform: translateY(-3px);
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
            animation: fadeIn 0.5s ease;
        }
        
        .message-error {
            background: #f8d7da;
            color: #721c24;
            border-left: 4px solid #dc3545;
        }
        
        /* Password Tips */
        .password-tips {
            background: rgba(255, 248, 225, 0.5);
            padding: 20px;
            border-radius: 10px;
            margin-top: 25px;
            border-left: 4px solid var(--secondary-color);
        }
        
        .password-tips h4 {
            color: var(--secondary-color);
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .tips-list {
            padding-left: 20px;
        }
        
        .tips-list li {
            margin-bottom: 8px;
            color: var(--text-dark);
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
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
            
            .form-container {
                padding: 20px;
            }
            
            .form-title {
                font-size: 1.5rem;
            }
            
            .form-buttons {
                flex-direction: column;
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
    filter: brightness(0.65); /* Darken video slightly */
}

/* Dark Overlay */
.overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.5);
    z-index: -1;
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
    // Check session before doing anything
    if (session.getAttribute("fname") == null || session.getAttribute("fcontact") == null) {
        response.sendRedirect("Farmer_Login33.html");
        return;
    }

    String fname = (String) session.getAttribute("fname");
    String fcontact = (String) session.getAttribute("fcontact");

    String oldpass = request.getParameter("opass");
    String newpass = request.getParameter("npass");
    String errorMessage = null;

    if (oldpass != null && newpass != null) {
        Connection con = DbConnection.connect();

        // Get current password
        PreparedStatement pt1 = con.prepareStatement("SELECT fpass FROM farmer WHERE fcontact=?");
        pt1.setString(1, fcontact);
        ResultSet rs1 = pt1.executeQuery();
        String pass = "";
        if (rs1.next()) {
            pass = rs1.getString("fpass");
        }
        rs1.close();
        pt1.close();

        // Check old password
        if (pass.equals(oldpass)) {
            PreparedStatement pt2 = con.prepareStatement("UPDATE farmer SET fpass=? WHERE fcontact=?");
            pt2.setString(1, newpass);
            pt2.setString(2, fcontact);
            int i = pt2.executeUpdate();
            pt2.close();

            if (i > 0) {
                con.close();
                response.sendRedirect("Farmer_Login33.html");
                return;
            }
        } else {
            errorMessage = "Old password is incorrect.";
        }

        con.close();
    }
    %>

    <div class="container">
        <!-- Header -->
        <div class="header">
            <div class="welcome-section">
                <h2>Welcome, <%=fname%>!</h2>
                <p>Reset Your Password - AgriHelp Portal</p>
            </div>
            
            <a href="Farmer_Dashboard33.jsp" class="btn-back">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
        
        <!-- Error Message -->
        <% if (errorMessage != null) { %>
            <div class="message message-error">
                <i class="fas fa-exclamation-circle"></i> <%= errorMessage %>
            </div>
        <% } %>
        
        <!-- Form Container -->
        <div class="form-container">
            <h2 class="form-title"><i class="fas fa-key"></i> Reset Password</h2>
            
            <form method="post" id="passwordForm">
                <div class="form-group">
                    <label class="form-label"><i class="fas fa-lock"></i> Current Password</label>
                    <i class="fas fa-lock input-icon"></i>
                    <input type="password" name="opass" id="oldPassword" class="form-input" placeholder="Enter your current password" required>
                    <i class="fas fa-eye password-toggle" id="toggleOldPassword"></i>
                </div>
                
                <div class="form-group">
                    <label class="form-label"><i class="fas fa-key"></i> New Password</label>
                    <i class="fas fa-key input-icon"></i>
                    <input type="password" name="npass" id="newPassword" class="form-input" placeholder="Enter your new password" required>
                    <i class="fas fa-eye password-toggle" id="toggleNewPassword"></i>
                    
                    <div class="password-strength">
                        <div class="strength-meter" id="passwordStrength"></div>
                    </div>
                    <div class="strength-text" id="passwordStrengthText">Password strength</div>
                </div>
                
                <div class="password-tips">
                    <h4><i class="fas fa-lightbulb"></i> Password Tips</h4>
                    <ul class="tips-list">
                        <li>Use at least 8 characters</li>
                        <li>Include uppercase and lowercase letters</li>
                        <li>Add numbers and special characters</li>
                        <li>Avoid common words or phrases</li>
                    </ul>
                </div>
                
                <div class="form-buttons">
                    <button type="submit" class="btn-reset">
                        <i class="fas fa-sync-alt"></i> Reset Password
                    </button>
                    <button type="reset" class="btn-clear" onclick="clearForm()">
                        <i class="fas fa-eraser"></i> Clear
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        // Password visibility toggle
        document.getElementById('toggleOldPassword').addEventListener('click', function() {
            togglePasswordVisibility('oldPassword', this);
        });
        
        document.getElementById('toggleNewPassword').addEventListener('click', function() {
            togglePasswordVisibility('newPassword', this);
        });
        
        function togglePasswordVisibility(inputId, toggleIcon) {
            const passwordInput = document.getElementById(inputId);
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }
        
        // Password strength meter
        document.getElementById('newPassword').addEventListener('input', function() {
            checkPasswordStrength(this.value);
        });
        
        function checkPasswordStrength(password) {
            const strengthBar = document.getElementById('passwordStrength');
            const strengthText = document.getElementById('passwordStrengthText');
            
            // Reset
            strengthBar.className = 'strength-meter';
            strengthBar.style.width = '0%';
            
            if (password.length === 0) {
                strengthText.textContent = 'Password strength';
                return;
            }
            
            // Check password strength
            let strength = 0;
            
            // Length check
            if (password.length >= 8) strength += 1;
            
            // Contains lowercase
            if (/[a-z]/.test(password)) strength += 1;
            
            // Contains uppercase
            if (/[A-Z]/.test(password)) strength += 1;
            
            // Contains numbers
            if (/[0-9]/.test(password)) strength += 1;
            
            // Contains special characters
            if (/[^A-Za-z0-9]/.test(password)) strength += 1;
            
            // Update strength meter
            if (strength <= 2) {
                strengthBar.classList.add('strength-weak');
                strengthText.textContent = 'Weak password';
                strengthText.style.color = '#ff5252';
            } else if (strength <= 4) {
                strengthBar.classList.add('strength-medium');
                strengthText.textContent = 'Medium strength';
                strengthText.style.color = '#ffb142';
            } else {
                strengthBar.classList.add('strength-strong');
                strengthText.textContent = 'Strong password';
                strengthText.style.color = '#2ed573';
            }
        }
        
        // Form validation
        document.getElementById('passwordForm').addEventListener('submit', function(e) {
            const newPassword = document.getElementById('newPassword').value;
            
            if (newPassword.length < 4) {
                e.preventDefault();
                alert('Password must be at least 5 characters long');
                document.getElementById('newPassword').focus();
                return;
            }
        });
        
        function clearForm() {
            document.getElementById('passwordStrength').className = 'strength-meter';
            document.getElementById('passwordStrength').style.width = '0%';
            document.getElementById('passwordStrengthText').textContent = 'Password strength';
            document.getElementById('passwordStrengthText').style.color = 'var(--text-light)';
        }
        
        // Add animation to form elements
        document.addEventListener('DOMContentLoaded', function() {
            const formElements = document.querySelectorAll('.form-group, .password-tips');
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