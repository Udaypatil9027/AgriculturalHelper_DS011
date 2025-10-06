package agriHelp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Delete_Report33
 */
public class Delete_Report33 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Delete_Report33() {
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
		
		int rid = Integer.parseInt(request.getParameter("rid"));
		
		try{
			Connection con = DbConnection.connect();
			
			PreparedStatement pt1 = con.prepareStatement("DELETE FROM reports WHERE reportId=?");
			pt1.setInt(1, rid);
			int i = pt1.executeUpdate();
			if(i>0){
				response.sendRedirect("View_YourReports33.jsp");
			}
			else{
				response.sendRedirect("error.html");
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
	}

}
