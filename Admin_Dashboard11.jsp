<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Admin Dashboard - AgriHelp Portal</title>

<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Playfair+Display:wght@700&display=swap"
	rel="stylesheet">

<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<!-- Global CSS -->
<link rel="stylesheet" type="text/css" href="resources/css/style.css">
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
				<li><a href="Admin_Dashboard11.jsp" class="active">Dashboard</a></li>
				<li><a href="Admin_Login11.html"
					onclick="return confirm('Are you sure you want to logout?');">
						<i class="fas fa-sign-out-alt"></i> Logout
				</a></li>
			</ul>
		</nav>
	</header>

	<!-- Dashboard Content -->
	<div class="dashboard-container">
		<div class="dashboard-header">
			<h2>Welcome to Admin Dashboard!</h2>
			<p>Manage farmers, agronomists, reports, and solutions</p>
		</div>

		<div class="dashboard-grid">
			<!-- Agronomist Management Card -->
			<div class="dashboard-card">
				<div class="card-icon agronomist-icon">
					<i class="fas fa-user-graduate"></i>
				</div>
				<h3>Agronomist Management</h3>
				<p>Add and manage agronomist accounts</p>
				<div class="card-actions">
					<a href="Add_Agronomist11.jsp" class="btn card-btn"> <i
						class="fas fa-plus"></i> Add Agronomist
					</a> <a href="View_Agronomist11.jsp" class="btn card-btn secondary">
						<i class="fas fa-list"></i> View Agronomists
					</a>
				</div>
			</div>

			<!-- Farmer Management Card -->
			<div class="dashboard-card">
				<div class="card-icon farmer-icon">
					<i class="fas fa-user"></i>
				</div>
				<h3>Farmer Management</h3>
				<p>Add and manage farmer accounts</p>
				<div class="card-actions">
					<a href="Add_Farmer11.html" class="btn card-btn"> <i
						class="fas fa-plus"></i> Add Farmer
					</a> <a href="View_Farmers11.jsp" class="btn card-btn secondary"> <i
						class="fas fa-list"></i> View Farmers
					</a>
				</div>
			</div>


			<!-- Reports Card -->
			<div class="dashboard-card">
				<div class="card-icon reports-icon">
					<i class="fas fa-clipboard-list"></i>
				</div>
				<h3>Reports Management</h3>
				<p>View all farmer reports and issues</p>
				<div class="card-actions">
					<a href="View_All_Reports11.jsp" class="btn card-btn"> <i
						class="fas fa-eye"></i> View All Reports
					</a>
				</div>
			</div>

			<!-- Solutions Card -->
			<div class="dashboard-card">
				<div class="card-icon solutions-icon">
					<i class="fas fa-lightbulb"></i>
				</div>
				<h3>Solutions Management</h3>
				<p>Review all provided solutions</p>
				<div class="card-actions">
					<a href="View_Solution_Admin11.jsp" class="btn card-btn"> <i
						class="fas fa-check-circle"></i> View All Solutions
					</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
