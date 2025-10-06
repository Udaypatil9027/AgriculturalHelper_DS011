package agriHelp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.*;

/**
 * Servlet implementation class Add_Farmer11
 */
public class Add_Farmer11 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Add_Farmer11() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String name = request.getParameter("fname");
		String location = request.getParameter("flocation");
		String email = request.getParameter("femail");
		String contact = request.getParameter("fcontact");
		String pass = request.getParameter("fpass");
		
		try{
			int id=0;
			Connection con = DbConnection.connect();
			PreparedStatement pt = con.prepareStatement("SELECT * FROM farmer WHERE femail=? OR fcontact=?");
			pt.setString(1, email);
			pt.setString(2, contact);
			ResultSet rs = pt.executeQuery();
			if(rs.next()){
				response.sendRedirect("error.html");
				return;
			}else{
				PreparedStatement pt1 = con.prepareStatement("INSERT INTO farmer VALUES (?,?,?,?,?,?)");
				pt1.setInt(1, id);
				pt1.setString(2, name);
				pt1.setString(3, location);
				pt1.setString(4, email);
				pt1.setString(5, contact);
				pt1.setString(6, pass);
				
				int i = pt1.executeUpdate();
				if(i>0){
					farmer_gs.setContact(contact);
					farmer_gs.setName(name);
					farmer_gs.setEmail(email);
					
					response.sendRedirect("View_Farmers11.jsp");
				}
				else{
					response.sendRedirect("error.html");
				}
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}

		
		
	}

}
