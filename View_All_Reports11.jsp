<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="agriHelp.DbConnection"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>View Reports - AgriHelp Portal</title>
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
#bgVideo {
    position: fixed;
    right: 0;
    bottom: 0;
    width: 60%;   /* instead of 100% */
    height: 60%;
    z-index: -2;
    object-fit: contain;  /* avoids cropping */
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%); /* keep centered */
}



:root {
    --primary: #4a8e3c;
    --primary-dark: #3a6e2f;
    --secondary: #f9a826;
    --light: #f5f9f4;
    --dark: #2c3e26;
    --gray: #6c757d;
    --white: #ffffff;
    --danger: #e74c3c;
    --info: #3498db;
}

/* Global Reset */
* { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Roboto', sans-serif; }

body { color: var(--dark); line-height: 1.6; min-height: 100vh; overflow-x: hidden; }

/* Background Video */
#bgVideo { position: fixed; right: 0; bottom: 0; min-width: 100%; min-height: 100%; z-index: -2; object-fit: cover; }
.overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,50,0,0.7); z-index: -1; }

/* Header */
header { padding: 20px 5%; display: flex; justify-content: space-between; align-items: center; background: rgba(255,255,255,0.95); box-shadow: 0 2px 10px rgba(0,0,0,0.1); position: sticky; top: 0; z-index: 100; }
.logo h1 { font-family: 'Playfair Display', serif; color: var(--primary); font-size: 28px; margin-left: 10px; }
.logo-icon { color: var(--primary); font-size: 32px; }
nav ul { display: flex; list-style: none; }
nav ul li { margin-left: 25px; }
nav ul li a { text-decoration: none; color: var(--dark); font-weight: 500; transition: 0.3s; }
nav ul li a:hover { color: var(--primary); }

/* Container */
.table-container { padding: 30px 5%; max-width: 1400px; margin: 0 auto; }
.table-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; padding: 20px; background: rgba(255,255,255,0.1); border-radius: 12px; backdrop-filter: blur(10px); }
.table-header h2 { color: var(--white); font-family: 'Playfair Display', serif; font-size: 2rem; }
.welcome-message { color: var(--secondary); font-weight: 500; font-size: 1.1rem; }

/* Stats */
.stats-bar { display: flex; justify-content: space-around; background: rgba(255,255,255,0.1); padding: 15px 20px; border-radius: 8px; margin-bottom: 20px; backdrop-filter: blur(10px); color: var(--white); }
.stat-item { text-align: center; }
.stat-number { font-size: 1.5rem; font-weight: 700; color: var(--secondary); display: block; }

/* Search */
.search-container { display: flex; gap: 10px; margin-bottom: 20px; }
.search-input { flex: 1; padding: 12px 15px; border: 1px solid #ddd; border-radius: 8px; font-size: 16px; }
.search-btn { background: var(--primary); color: var(--white); border: none; padding: 12px 20px; border-radius: 8px; cursor: pointer; display: flex; align-items: center; gap: 8px; }
.search-btn:hover { background: var(--primary-dark); }

/* Table */
.reports-table { width: 100%; background: rgba(255,255,255,0.95); border-radius: 12px; overflow: hidden; box-shadow: 0 5px 20px rgba(0,0,0,0.1); border-collapse: collapse; }
.reports-table th { background: var(--primary); color: var(--white); padding: 15px; text-align: left; }
.reports-table td { padding: 12px 15px; border-bottom: 1px solid #eee; }
.reports-table tr:nth-child(even) { background: rgba(74,142,60,0.05); }
.reports-table tr:hover { background: rgba(74,142,60,0.12); }

/* Buttons */
.btn { border: none; padding: 8px 12px; border-radius: 6px; cursor: pointer; transition: 0.3s; text-decoration: none; font-size: 14px; }
.btn-view { background: var(--info); color: var(--white); }
.btn-view:hover { background: #2980b9; }
.btn-delete { background: var(--danger); color: var(--white); }
.btn-delete:hover { background: #c0392b; }

/* Footer */
.table-footer { margin-top: 20px; text-align: center; }
.btn-back { display: inline-flex; align-items: center; gap: 8px; background: var(--gray); color: var(--white); padding: 12px 20px; border-radius: 8px; text-decoration: none; transition: 0.3s; }
.btn-back:hover { background: #444; }

/* Image Modal */
.img-modal { display: none; position: fixed; z-index: 2000; padding-top: 60px; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background: rgba(0,0,0,0.9); }
.img-modal img { margin: auto; display: block; max-width: 80%; max-height: 80%; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.6); animation: zoomIn 0.3s ease-in-out; }
.img-modal .close { position: absolute; top: 20px; right: 35px; color: #fff; font-size: 40px; font-weight: bold; cursor: pointer; transition: 0.3s; }
.img-modal .close:hover { color: var(--secondary); }
@keyframes zoomIn { from { transform: scale(0.8); opacity: 0; } to { transform: scale(1); opacity: 1; } }
</style>
</head>

<body>
    <!-- Background -->
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
            <ul>
                <li><a href="Admin_Dashboard11.jsp">Dashboard</a></li>
                <li><a href="Admin_Login11.html" onclick="return confirm('Are you sure you want to logout?');"><i class="fas fa-sign-out-alt" onclick="return confirm('Are you sure you want to logout?');"></i> Logout</a></li>
            </ul>
        </nav>
    </header>

    <!-- Table Container -->
    <div class="table-container">
        <div class="table-header">
            <h2><i class="fas fa-file-alt"></i> Reports Management</h2>
            <div class="welcome-message">Welcome, Admin! Here are the submitted reports.</div>
        </div>

        <%
            int reportCount = 0;
            try {
                Connection con = DbConnection.connect();
                PreparedStatement countStmt = con.prepareStatement("SELECT COUNT(*) FROM reports");
                ResultSet countRs = countStmt.executeQuery();
                if (countRs.next()) { reportCount = countRs.getInt(1); }
                countRs.close(); countStmt.close(); con.close();
            } catch (Exception e) { e.printStackTrace(); }
        %>

        <!-- Stats -->
        <div class="stats-bar">
            <div class="stat-item"><span class="stat-number"><%=reportCount%></span><span class="stat-label">Total Reports</span></div>
      		<div></div>
      		<div></div>
      		<div></div>
      		<div></div>
      		<div></div>
      		<div></div>
       </div>

        <!-- Search -->
        <div class="search-container">
            <input type="text" class="search-input" placeholder="Search reports by any field..." id="searchInput">
            <button class="search-btn"><i class="fas fa-search"></i> Search</button>
        </div>

        <!-- Reports Table -->
        <table class="reports-table">
            <thead>
                <tr>
                    <th>Report ID</th>
                    <th>Farmer ID</th>
                    <th>Farmer Name</th>
                    <th>Crop Name</th>
                    <th>Symptom</th>
                    <th>Date Reported</th>
                    <th>Status</th>
                    <th>Image</th>
                    <th>Solution</th>
                    <th class="action-cell">Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Connection con = DbConnection.connect();
                        PreparedStatement pt = con.prepareStatement("SELECT * FROM reports ORDER BY reportId DESC");
                        ResultSet rs = pt.executeQuery();
                        while (rs.next()) {
                %>
                <tr>
                    <td><%=rs.getInt("reportId")%></td>
                    <td><%=rs.getString("farmerId")%></td>
                    <td><%=rs.getString("fname")%></td>
                    <td><%=rs.getString("cropName")%></td>
                    <td><%=rs.getString("symptoms")%></td>
                    <td><%=rs.getDate("dateReported")%></td>
                    <td><%=rs.getString("status")%></td>
                    <td>
                        <% if (rs.getBlob("rimage") != null) { %>
                            <img src="ImageOpenServlet?id=<%=rs.getInt("reportId")%>"
                                 alt="Report Image"
                                 onclick="openImageModal('ImageOpenServlet?id=<%=rs.getInt("reportId")%>')"
                                 style="cursor:pointer; width:60px; height:60px; border-radius:6px; object-fit:cover; box-shadow:0 2px 6px rgba(0,0,0,0.2);">
                        <% } else { %>
                            <span style="color:var(--gray); font-style:italic;">No Image</span>
                        <% } %>
                    </td>
                    <td>
                        <a href="View_Solution_Admin11.jsp?rid=<%= rs.getInt("reportId") %>" class="btn btn-view">
                            <i class="fas fa-eye"></i> View
                        </a>
                    </td>
                    <td>
                        <form action="Admin_DeleteReports11" method="post" onsubmit="return confirm('Are you sure you want to delete this report?');">
                            <input type="hidden" name="rid" value="<%= rs.getInt("reportId") %>">
                            <button type="submit" class="btn btn-delete"><i class="fas fa-trash"></i> Delete</button>
                        </form>
                    </td>
                </tr>
                <%  }
                    rs.close(); pt.close(); con.close();
                    } catch (Exception e) { e.printStackTrace(); }
                %>
            </tbody>
        </table>

        <!-- Footer -->
        <div class="table-footer">
            <a href="Admin_Dashboard11.jsp" class="btn-back"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
        </div>
    </div>

    <!-- Search Filter -->
    <script>
        document.getElementById('searchInput').addEventListener('keyup', function() {
            const searchText = this.value.toLowerCase();
            const rows = document.querySelectorAll('.reports-table tbody tr');
            rows.forEach(row => {
                const rowText = row.innerText.toLowerCase();
                row.style.display = rowText.includes(searchText) ? '' : 'none';
            });
        });

        function openImageModal(src) {
            document.getElementById("imgModal").style.display = "block";
            document.getElementById("modalImage").src = src;
        }
        function closeImageModal() {
            document.getElementById("imgModal").style.display = "none";
        }
    </script>

    <!-- Image Modal -->
<div id="imgModal" class="img-modal" onclick="closeImageModal()">
    <span class="close">&times;</span>
    <img class="modal-content" id="modalImage">
</div>

<script>
    // Slow down the background video to half speed
    document.getElementById("bgVideo").playbackRate = 0.5;
</script>

</body>
</html>


</body>
</html>
