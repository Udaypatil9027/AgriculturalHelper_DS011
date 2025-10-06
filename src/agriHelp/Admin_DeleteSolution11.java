package agriHelp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Admin_DeleteSolution11
 */
public class Admin_DeleteSolution11 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Admin_DeleteSolution11() {
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
		int sid = Integer.parseInt(request.getParameter("sid"));
		Connection con = DbConnection.connect();
		try{
			PreparedStatement pt = con.prepareStatement("DELETE FROM solutions WHERE solutionId=?");
			pt.setInt(1, sid);
			int i=pt.executeUpdate();
			if(i>0){
				response.sendRedirect("View_Solution_Admin11.jsp");
			}else{
				response.sendRedirect("error.html");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}

}
