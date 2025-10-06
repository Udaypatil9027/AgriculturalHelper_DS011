package agriHelp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Delete_Agro11
 */
public class Delete_Agro11 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Delete_Agro11() {
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
		
		int id = Integer.parseInt(request.getParameter("agroId"));
		
		
		try{
			Connection con = DbConnection.connect();
			
			PreparedStatement pt1 = con.prepareStatement("DELETE FROM agronomist WHERE agroId = ?");
			pt1.setInt(1, id);
			
			int i = pt1.executeUpdate();
			if(i>0){
				response.sendRedirect("View_Agronomist11.jsp");
			}else{
				response.sendRedirect("View_Agronomist11.jsp");
			}
			
			
			
		}catch(Exception e){
			e.getMessage();
		}
	}

}
