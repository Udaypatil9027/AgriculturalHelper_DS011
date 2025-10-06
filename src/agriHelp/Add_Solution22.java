package agriHelp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Date;
import java.time.LocalDate;


/**
 * Servlet implementation class Add_Solution22
 */
public class Add_Solution22 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Add_Solution22() {
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
		int aid=0;
		LocalDate today = LocalDate.now(); // Today's date
		Date sqlDate = Date.valueOf(today); // Convert to SQL Date

		String solution = request.getParameter("solution");
		int rid = Integer.parseInt(request.getParameter("rid"));
		String aname="";
		HttpSession session = request.getSession();
		String acontact = (String) session.getAttribute("acontact");

		int fid=0;
		String fname="";
		Connection con = DbConnection.connect();
		try {
			PreparedStatement ptt = con.prepareStatement("SELECT * FROM reports WHERE reportId=?");
			ptt.setInt(1, rid);
			ResultSet rss = ptt.executeQuery();
			if(rss.next()){
				fid = rss.getInt("farmerId");
				fname = rss.getString("fname");
			}
			PreparedStatement pt1 = con.prepareStatement("SELECT * FROM agronomist WHERE acontact=?");
			pt1.setString(1, acontact);
			ResultSet rs1 = pt1.executeQuery();
			if(rs1.next()){
				aid=rs1.getInt("agroId");
				aname=rs1.getString("aname");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String status = "Accepted";
		
		try {
			int sid=0;
			PreparedStatement pt2 = con.prepareStatement("INSERT INTO solutions (solutionId, reportId, agroId,agname,farmerId, fname, suggestion, dateProvided) VALUES(?,?,?,?,?,?,?,?)");
			pt2.setInt(1, sid);
			pt2.setInt(2, rid);
			pt2.setInt(3, aid);
			pt2.setString(4, aname);
			pt2.setInt(5, fid);
			pt2.setString(6, fname);
			pt2.setString(7, solution);
			pt2.setDate(8,sqlDate);
			
			int i = pt2.executeUpdate();
			if(i>0){
				PreparedStatement pt3 = con.prepareStatement("UPDATE reports SET status = ? WHERE reportId=?");
				pt3.setString(1, status);
				pt3.setInt(2, rid);
				int j = pt3.executeUpdate();
				response.sendRedirect("Agronomist_Solutions22.jsp");
			}else{
				response.sendRedirect("View_FarmerReports22.jsp");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	}

}
