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
 * Servlet implementation class Agronomist_Login22
 */
public class Agronomist_Login22 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Agronomist_Login22() {
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
		
		String contact = request.getParameter("acontact");
		String pass = request.getParameter("apass");
		try{
		Connection con = DbConnection.connect();
		
		PreparedStatement pt1 = con.prepareStatement("SELECT * FROM agronomist WHERE acontact=? AND apass=?");
		pt1.setString(1, contact);
		pt1.setString(2, pass);
		
		ResultSet rs1 = pt1.executeQuery();
		if(rs1.next()){
			String name = rs1.getString("aname");
			
			HttpSession session = request.getSession();
			session.setAttribute("acontact",contact);
			session.setAttribute("aname", name);
			
//			agronomist_gs.setName(name);
//			agronomist_gs.setContact(contact);
			
			response.sendRedirect("Agronomist_Dashboard22.jsp");
		}else{
			response.sendRedirect("Agronomist_Login22.html");
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}

}
