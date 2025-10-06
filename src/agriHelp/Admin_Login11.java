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
 * Servlet implementation class Admin_Login11
 */
public class Admin_Login11 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Admin_Login11() {
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
		
		String email = request.getParameter("aemail");
		String pass = request.getParameter("apass");
		
		try{
			Connection con = DbConnection.connect();
			PreparedStatement pt1 = con.prepareStatement("SELECT * FROM admin WHERE aemail=? AND apass=?");
			pt1.setString(1, email);
			pt1.setString(2, pass);
			ResultSet rs1 = pt1.executeQuery();
			if(rs1.next()){
				HttpSession session = request.getSession();
				session.setAttribute("aemail", email);
				session.setAttribute("apass", pass);
				response.sendRedirect("Admin_Dashboard11.jsp");
			}else{
				response.sendRedirect("Admin_Dashboard11.jsp");
			}
			
			
		}catch(Exception e){
			e.getMessage();
		}
	}

}
