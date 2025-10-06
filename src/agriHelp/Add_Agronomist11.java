package agriHelp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Add_Agronomist11
 */
public class Add_Agronomist11 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Add_Agronomist11() {
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
	
		String name = request.getParameter("aname");
		String email = request.getParameter("email");
		String expertise = request.getParameter("expertise");
		String contact = request.getParameter("contact");
		String pass = request.getParameter("pass");
		
		try{
			Connection con = DbConnection.connect();
			
			PreparedStatement pt = con.prepareStatement("SELECT * FROM agronomist WHERE aemail=? OR acontact=?");
			pt.setString(1, email);
			pt.setString(2, contact);
			
			ResultSet rs = pt.executeQuery();
			if(rs.next()){
				response.sendRedirect("error.html");
				return;
			}else{
				int id=0;
				PreparedStatement pt1 = con.prepareStatement("INSERT INTO agronomist VALUES(?,?,?,?,?,?)");
				pt1.setInt(1, id);
				pt1.setString(2,name);
				pt1.setString(3, expertise);
				pt1.setString(4, email);
				pt1.setString(5, contact);
				pt1.setString(6, pass);
				
				int i = pt1.executeUpdate();
				if(i>0){
					response.sendRedirect("View_Agronomist11.jsp");
				}
				else{
					response.sendRedirect("error.html");
				}
			}
			
		}catch(Exception e){
			e.getMessage();
		}
	
	}

}


















