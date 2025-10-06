
package agriHelp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Farmer_Login33
 */
public class Farmer_Login33 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Farmer_Login33() {
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
		
		String contact = request.getParameter("fcontact");
		String pass = request.getParameter("fpass");
		
		try{
			Connection con = DbConnection.connect();
			
			PreparedStatement pt1 = con.prepareStatement("SELECT * FROM farmer WHERE fcontact=? AND fpass=?");
			pt1.setString(1, contact);
			pt1.setString(2, pass);
			ResultSet rs1 = pt1.executeQuery();
			if(rs1.next()){
				String name = rs1.getString("fname");
				
				HttpSession session = request.getSession();
				session.setAttribute("fcontact", contact);
				session.setAttribute("fname", name);
//				farmer_gs.setName(name);
//				farmer_gs.setContact(contact);
				response.sendRedirect("Farmer_Dashboard33.jsp");
			}else{
				response.sendRedirect("Farmer_Regester33.html");
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}

}