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
            --shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
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
            display: flex;
            justify-content: center;
            align-items: center;
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
            width: 100%;
            max-width: 500px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }
        
        .header {
            text-align: center;
            margin-bottom: 30px;
            padding: 20px;
            background: linear-gradient(135deg, var(--header-bg) 0%, rgba(0, 96, 15, 0.9) 100%);
            border-radius: 10px;
            color: var(--white);
            box-shadow: var(--shadow);
            backdrop-filter: blur(5px);
        }
        
        .header h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            margin-bottom: 5px;
        }
        
        .header p {
            opacity: 0.9;
        }
        
        .card {
            background: var(--card-bg);
            border-radius: 10px;
            padding: 30px;
            box-shadow: var(--shadow);
            margin-bottom: 20px;
            backdrop-filter: blur(5px);
        }
        
        .welcome-text {
            text-align: center;
            margin-bottom: 25px;
            color: var(--primary-dark);
            font-size: 1.2rem;
        }
        
        .welcome-text i {
            color: var(--primary-color);
            margin-right: 10px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-dark);
        }
        
        .input-with-icon {
            position: relative;
        }
        
        .input-with-icon i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary-color);
        }
        
        .input-with-icon input {
            width: 100%;
            padding: 12px 15px 12px 45px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
            transition: var(--transition);
            background: rgba(255, 255, 255, 0.9);
        }
        
        .input-with-icon input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(56, 142, 60, 0.2);
        }
        
        .btn-group {
            display: flex;
            gap: 15px;
            margin-top: 25px;
        }
        
        .btn {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
        }
        
        .btn-submit {
            background: var(--primary-color);
            color: var(--white);
        }
        
        .btn-submit:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
        }
        
        .btn-reset {
            background: var(--secondary-color);
            color: var(--white);
        }
        
        .btn-reset:hover {
            background: #b71c1c;
            transform: translateY(-2px);
        }
        
        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: var(--primary-light);
            color: var(--white);
            text-decoration: none;
            border-radius: 5px;
            transition: var(--transition);
        }
        
        .btn-back:hover {
            background: var(--primary-color);
            transform: translateY(-2px);
        }
        
        .message {
            padding: 12px 15px;
            margin-bottom: 20px;
            border-radius: 6px;
            backdrop-filter: blur(5px);
            text-align: center;
        }
        
        .error {
            background: rgba(242, 222, 222, 0.9);
            color: #a94442;
            border-left: 4px solid #a94442;
        }
        
        .password-rules {
            background: rgba(232, 245, 233, 0.8);
            border-left: 4px solid var(--primary-color);
            padding: 15px;
            border-radius: 0 8px 8px 0;
            margin: 20px 0;
            font-size: 0.9rem;
        }
        
        .password-rules h4 {
            margin-bottom: 10px;
            color: var(--primary-dark);
        }
        
        .password-rules ul {
            padding-left: 20px;
        }
        
        .password-rules li {
            margin-bottom: 5px;
        }
        
        @media (max-width: 576px) {
            .btn-group {
                flex-direction: column;
            }
            
            .card {
                padding: 20px;
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
    // Session check first
    if (session.getAttribute("aname") == null || session.getAttribute("acontact") == null) {
        response.sendRedirect("Agronomist_Login22.html");
        return;
    }

    String aname = (String) session.getAttribute("aname");
    String acontact = (String) session.getAttribute("acontact");

    String oldpass = request.getParameter("opass");
    String newpass = request.getParameter("npass");
    String errorMessage = null;

    if (oldpass != null && newpass != null) {
        Connection con = DbConnection.connect();

        PreparedStatement pt1 = con.prepareStatement("SELECT apass FROM agronomist WHERE acontact=?");
        pt1.setString(1, acontact);
        ResultSet rs1 = pt1.executeQuery();
        String pass = "";
        if (rs1.next()) {
            pass = rs1.getString("apass");
        }
        rs1.close();
        pt1.close();

        if (pass.equals(oldpass)) {
            PreparedStatement pt2 = con.prepareStatement("UPDATE agronomist SET apass=? WHERE acontact=?");
            pt2.setString(1, newpass);
            pt2.setString(2, acontact);
            int i = pt2.executeUpdate();
            pt2.close();

            if (i > 0) {
                con.close();
                response.sendRedirect("Agronomist_Login22.html");
                return;
            }
        } else {
            errorMessage = "Old password is incorrect. Please try again.";
        }

        con.close();
    }
%>

<div class="container">
    <div class="header">
        <h2>Reset Password</h2>
        <p>AgriHelp Portal - Agronomist Account</p>
    </div>
    
    <div class="card">
        <div class="welcome-text">
            <i class="fas fa-user-shield"></i> Welcome, <%=aname%>!
        </div>
        
        <% if (errorMessage != null) { %>
        <div class="message error">
            <i class="fas fa-exclamation-circle"></i> <%= errorMessage %>
        </div>
        <% } %>
        
        <div class="password-rules">
            <h4><i class="fas fa-info-circle"></i> Password Requirements</h4>
            <ul>
                <li>Minimum 8 characters</li>
                <li>At least one uppercase letter</li>
                <li>At least one number</li>
                <li>At least one special character</li>
            </ul>
        </div>
        
        <form method="post">
            <div class="form-group">
                <label for="opass">Current Password</label>
                <div class="input-with-icon">
                    <i class="fas fa-lock"></i>
                    <input type="password" id="opass" name="opass" placeholder="Enter your current password" required>
                </div>
            </div>
            
            <div class="form-group">
                <label for="npass">New Password</label>
                <div class="input-with-icon">
                    <i class="fas fa-key"></i>
                    <input type="password" id="npass" name="npass" placeholder="Enter your new password" required>
                </div>
            </div>
            
            <div class="btn-group">
                <button type="submit" class="btn btn-submit">
                    <i class="fas fa-sync-alt"></i> Update Password
                </button>
                <button type="reset" class="btn btn-reset">
                    <i class="fas fa-eraser"></i> Clear
                </button>
            </div>
        </form>
    </div>
    
    <a href="Agronomist_Dashboard22.jsp" class="btn-back">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>
</div>

<script>
    // Simple password strength indicator (optional enhancement)
    document.addEventListener('DOMContentLoaded', function() {
        const passwordInput = document.getElementById('npass');
        const passwordRequirements = document.querySelector('.password-rules');
        
        passwordInput.addEventListener('focus', function() {
            passwordRequirements.style.display = 'block';
        });
        
        passwordInput.addEventListener('blur', function() {
            passwordRequirements.style.display = 'block';
        });
    });
</script>
</body>
</html>