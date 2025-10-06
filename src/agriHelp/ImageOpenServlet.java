package agriHelp;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ImageOpenServlet")
public class ImageOpenServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String reportId = request.getParameter("id");
        if (reportId == null || reportId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing report ID");
            return;
        }
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        InputStream inputStream = null;
        OutputStream outputStream = null;
        
        try {
            con = DbConnection.connect();
            ps = con.prepareStatement("SELECT rimage FROM reports WHERE reportId = ?");
            ps.setInt(1, Integer.parseInt(reportId));
            rs = ps.executeQuery();
            
            if (rs.next()) {
                Blob imageBlob = rs.getBlob("rimage");
                if (imageBlob != null) {
                    response.setContentType("image/jpeg");
                    response.setContentLength((int) imageBlob.length());
                    
                    inputStream = imageBlob.getBinaryStream();
                    outputStream = response.getOutputStream();
                    
                    byte[] buffer = new byte[4096];
                    int bytesRead;
                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }
                    return;
                }
            }
            
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving image");
        } finally {
            try { if (outputStream != null) outputStream.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (inputStream != null) inputStream.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (ps != null) ps.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (con != null) con.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}