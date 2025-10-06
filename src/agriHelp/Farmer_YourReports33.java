package agriHelp;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class Farmer_YourReports33 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("fcontact") == null) {
            response.sendRedirect("Farmer_Login33.html");
            return;
        }
        String faname = (String)session.getAttribute("fname");
        String fcontact = (String) session.getAttribute("fcontact");
        String crop = request.getParameter("crop");
        String symptom = request.getParameter("sym");
        String status = "Pending";
        String reportDate = LocalDate.now().toString();
        
        Part filePart = request.getPart("image");
        InputStream inputStream = null;
        
        if (filePart != null && filePart.getSize() > 0) {
            inputStream = filePart.getInputStream();
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = DbConnection.connect();
            
            // First get farmerId
            ps = con.prepareStatement("SELECT farmerId FROM farmer WHERE fcontact=?");
            ps.setString(1, fcontact);
            rs = ps.executeQuery();
            
            if (!rs.next()) {
                session.setAttribute("error", "Farmer not found");
                response.sendRedirect("Farmer_YourReports33.jsp");
                return;
            }
            
            int farmerId = rs.getInt("farmerId");
            
            // Close previous resources
            rs.close();
            ps.close();
            
            // Insert report with image
            ps = con.prepareStatement(
                "INSERT INTO reports (farmerId, fname, cropName, symptoms, dateReported, status, rimage) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)");
            
            ps.setInt(1, farmerId);
            ps.setString(2, faname);
            ps.setString(3, crop);
            ps.setString(4, symptom);
            ps.setString(5, reportDate);
            ps.setString(6, status);
            
            if (inputStream != null) {
                ps.setBinaryStream(7, inputStream);
            } else {
                ps.setNull(7, java.sql.Types.BLOB);
            }
            
            int rows = ps.executeUpdate();
            
            if (rows > 0) {
                session.setAttribute("success", "Report submitted successfully");
                response.sendRedirect("View_YourReports33.jsp");
            } else {
                session.setAttribute("error", "Failed to submit report");
                response.sendRedirect("Farmer_YourReports33.jsp");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error: " + e.getMessage());
            response.sendRedirect("Farmer_YourReports33.jsp");
        } finally {
            // Close resources
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (ps != null) ps.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (con != null) con.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (inputStream != null) inputStream.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("Farmer_YourReports33.jsp");
    }
}