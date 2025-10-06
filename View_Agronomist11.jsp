<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="agriHelp.DbConnection"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Agronomist Management - AgriHelp Portal</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Global CSS -->
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            color: #fff;
        }
        /* Background */
        #bgVideo {
            position: fixed;
            right: 0;
            bottom: 0;
            min-width: 100%;
            min-height: 100%;
            object-fit: cover;
            z-index: -1;
        }
        .overlay {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: -1;
        }

        /* Header */
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 40px;
            background: rgba(0,0,0,0.6);
        }
        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #ffdd57;
        }
        .logo-icon {
            font-size: 28px;
        }
        nav ul {
            list-style: none;
            display: flex;
            gap: 20px;
        }
        nav a {
            text-decoration: none;
            color: #fff;
            font-weight: 500;
            transition: 0.3s;
        }
        nav a:hover {
            color: #ffdd57;
        }

        /* Table Container */
        .table-container {
            background: rgba(0, 0, 0, 0.7);
            padding: 30px;
            margin: 40px auto;
            border-radius: 20px;
            box-shadow: 0px 8px 25px rgba(0,0,0,0.6);
            width: 90%;
            backdrop-filter: blur(6px);
        }
        .table-header h2 {
            font-size: 26px;
            margin-bottom: 8px;
            color: #ffdd57;
        }
        .welcome-message {
            font-size: 16px;
            color: #ddd;
            margin-bottom: 20px;
        }

        /* Stats Bar */
        .stats-bar {
            display: flex;
            justify-content: flex-start;
            gap: 20px;
            margin-bottom: 20px;
        }
        .stat-item {
            background: linear-gradient(135deg, #00b09b, #96c93d);
            padding: 15px 25px;
            border-radius: 12px;
            text-align: center;
            min-width: 150px;
            box-shadow: 0px 4px 12px rgba(0,0,0,0.5);
        }
        .stat-number {
            font-size: 28px;
            font-weight: bold;
            display: block;
        }
        .stat-label {
            font-size: 14px;
        }

        /* Search Container */
        .search-container {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 20px;
        }
        .search-input {
            padding: 10px 15px;
            border-radius: 30px 0 0 30px;
            border: none;
            outline: none;
            width: 300px;
        }
        .search-btn {
            padding: 10px 20px;
            background: #ffdd57;
            border: none;
            border-radius: 0 30px 30px 0;
            cursor: pointer;
            color: #000;
            font-weight: 600;
        }

        /* Table */
        .agronomist-table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255,255,255,0.1);
            border-radius: 15px;
            overflow: hidden;
        }
        .agronomist-table th, .agronomist-table td {
            padding: 14px;
            text-align: center;
        }
        .agronomist-table th {
            background: rgba(255, 221, 87, 0.9);
            color: #000;
        }
        .agronomist-table tr:nth-child(even) {
            background: rgba(255, 255, 255, 0.05);
        }
        .agronomist-table tr:hover {
            background: rgba(255, 255, 255, 0.15);
        }

        /* Buttons */
        .action-cell {
            display: flex;
            gap: 10px;
            justify-content: center;
        }
        
        .btn-delete {
            background: #ff4b5c;
            border: none;
            padding: 8px 14px;
            border-radius: 8px;
            color: #fff;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        .btn-delete:hover {
            background: #ff1e38;
            transform: scale(1.05);
        }
        
        .btn-view {
            background: #3498db;
            border: none;
            padding: 8px 14px;
            border-radius: 8px;
            color: #fff;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            text-decoration: none;
        }
        .btn-view:hover {
            background: #2980b9;
            transform: scale(1.05);
        }
        
        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 18px;
            background: #00b09b;
            color: white;
            border-radius: 12px;
            text-decoration: none;
            transition: 0.3s;
        }
        .btn-back:hover {
            background: #029c87;
        }

        .table-footer {
            margin-top: 20px;
            text-align: right;
        }
        
        /* Pagination */
        .pagination {
            margin: 20px 0;
            text-align: center;
        }
        .page-btn {
            background: #333;
            color: #fff;
            border: none;
            padding: 8px 14px;
            margin: 0 5px;
            border-radius: 20px;
            cursor: pointer;
            transition: 0.3s;
        }
        .page-btn.active, .page-btn:hover {
            background: #ffdd57;
            color: #000;
        }
    </style>
</head>
<body>
    <!-- Background Video -->
    <video autoplay muted loop id="bgVideo">
        <source src="resources/bgt_video.mp4" type="video/mp4">
    </video>
    <div class="overlay"></div>

    <!-- Header -->
    <header>
        <div class="logo">
            <i class="fas fa-leaf logo-icon"></i>
            <h1>AgriHelp Portal</h1>
        </div>
        <nav>
            <a href="Admin_Login11.html" onclick="return confirm('Are you sure you want to logout?');">
  <i class="fas fa-sign-out-alt"></i> Logout
</a>
        </nav>
    </header>

    <!-- Table Container -->
    <div class="table-container">
        <div class="table-header">
            <h2><i class="fas fa-user-graduate"></i> Agronomist Management</h2>
            <% String email = (String)session.getAttribute("aemail"); %>
            <div class="welcome-message">Welcome, <%= email != null ? email : "Admin" %></div>
        </div>
        
        <% 
        int agronomistCount = 0;
        try {
            Connection con = DbConnection.connect();
            PreparedStatement countStmt = con.prepareStatement("SELECT COUNT(*) FROM agronomist");
            ResultSet countRs = countStmt.executeQuery();
            if (countRs.next()) {
                agronomistCount = countRs.getInt(1);
            }
            countRs.close();
            countStmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
        
        <!-- Stats Bar -->
        <div class="stats-bar">
            <div class="stat-item">
                <span class="stat-number"><%= agronomistCount %></span>
                <span class="stat-label">Total Agronomists</span>
            </div>
            <div class="stat-item">
                <span class="stat-number"><%= agronomistCount %></span>
                <span class="stat-label">Active Agronomists</span>
            </div>
            <div class="stat-item">
                <span class="stat-number">0</span>
                <span class="stat-label">New This Week</span>
            </div>
        </div>

        <!-- Search Bar -->
        <div class="search-container">
            <input type="text" class="search-input" placeholder="Search agronomists by name, expertise, or email..." id="searchInput">
            <button class="search-btn"><i class="fas fa-search"></i></button>
        </div>

        <!-- Agronomist Table -->
        <table class="agronomist-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Agronomist Name</th>
                    <th>Expertise</th>
                    <th>Email</th>
                    <th>Contact</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                try {
                    Connection con = DbConnection.connect();
                    PreparedStatement pt1 = con.prepareStatement("SELECT * FROM agronomist ORDER BY agroId");
                    ResultSet rs1 = pt1.executeQuery();
                    
                    while (rs1.next()) {
                %>
                <tr>
                    <td><%= rs1.getInt("agroId") %></td>
                    <td><%= rs1.getString("aname") %></td>
                    <td><%= rs1.getString("aexpertise") %></td>
                    <td><%= rs1.getString("aemail") %></td>
                    <td><%= rs1.getString("acontact") %></td>
                    <td>
                        
                            <form action="Delete_Agro11" method="post" class="delete-form" onsubmit="return confirmDelete()">
                                <input type="hidden" name="agroId" value="<%= rs1.getInt("agroId") %>">
                                <button type="submit" class="btn-delete">
                                    <i class="fas fa-trash"></i> Delete
                                </button>
                            </form>
                    </td>
                </tr>
                <% 
                    }
                    rs1.close();
                    pt1.close();
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %>
            </tbody>
        </table>
        
        <!-- Pagination -->
        <% if (agronomistCount > 10) { %>
        <div class="pagination">
            <button class="page-btn active">1</button>
            <button class="page-btn">2</button>
            <button class="page-btn">3</button>
            <button class="page-btn">Next</button>
        </div>
        <% } %>
        
        <!-- Footer -->
        <div class="table-footer">
            <a href="Admin_Dashboard11.jsp" class="btn-back"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
        </div>
    </div>

    <script>
        function confirmDelete() {
            return confirm("Are you sure you want to delete this agronomist?");
        }
        
        // Search functionality
        document.getElementById('searchInput').addEventListener('keyup', function() {
            const searchText = this.value.toLowerCase();
            const rows = document.querySelectorAll('.agronomist-table tbody tr');
            
            rows.forEach(row => {
                const name = row.cells[1].textContent.toLowerCase();
                const expertise = row.cells[2].textContent.toLowerCase();
                const email = row.cells[3].textContent.toLowerCase();
                
                row.style.display = (name.includes(searchText) || expertise.includes(searchText) || email.includes(searchText)) ? '' : 'none';
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