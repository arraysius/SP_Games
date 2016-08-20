package spgames;

import java.io.File;
import java.io.IOException;
import java.sql.*;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.lang3.StringEscapeUtils;

@MultipartConfig(maxFileSize = 10485760)
public class GameProcessor extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String uploadStatus = "success";

		try {
			// Gets save location
			String savePath = getServletContext().getInitParameter("gameimage-location");

			// Get fields from manageGameAdd.jsp or manageGameEdit.jsp
			String gametitle = StringEscapeUtils.escapeHtml4(request.getParameter("gametitle"));
			Part filePart = request.getPart("gameimage");
			double price = Double.parseDouble(request.getParameter("price"));
			int developerID = Integer.parseInt(request.getParameter("developer"));
			int publisherID = Integer.parseInt(request.getParameter("publisher"));

			String releaseDateString = request.getParameter("releaseDate");
			java.util.Date releaseDateJava = new SimpleDateFormat("yyyy-MM-dd").parse(releaseDateString);
			Date releasedate = new Date(releaseDateJava.getTime());

			String preowned = StringEscapeUtils.escapeHtml4(request.getParameter("preowned"));
			String description = format.nl2br(StringEscapeUtils.escapeHtml4(request.getParameter("description")));
			String[] genreStrings = request.getParameterValues("genreCheckbox");
			int[] genres = new int[genreStrings.length];
			for (int i = 0; i < genres.length; i++) {
				genres[i] = Integer.parseInt(genreStrings[i]);
			}
			String action = request.getParameter("action");

			
			String imagePath = "";
			if (filePart.getSize() > 0L) {
				// Write image file
				String imageName = filePart.getName();
				filePart.write(savePath + File.separator + imageName);
				imagePath = "images/game/" + imageName;
			}

			// Create db connection
			dbConnection db = new dbConnection(request);
			Connection conn = db.getConnection();

			// Insert / Update Game
			if (action.equals("insert")) {
				db.addNewGame(gametitle, developerID, publisherID, releasedate, description, price, preowned, imagePath,
						genres);
			} else if (action.equals("update")) {
				int gameID = Integer.parseInt(request.getParameter("gameid"));

				if (imagePath.equals("")) {
					// Get current Image_Path
					String getImgPathSQL = "SELECT Image_Path FROM game WHERE Game_ID = ?";
					PreparedStatement getImgPath_pstmt = conn.prepareStatement(getImgPathSQL);
					getImgPath_pstmt.setInt(1, gameID);
					ResultSet getImgPath_rs = getImgPath_pstmt.executeQuery();
					getImgPath_rs.next();
					imagePath = getImgPath_rs.getString(1);
				}

				db.updateGame(gameID, gametitle, developerID, publisherID, releasedate, description, price, preowned,
						imagePath, genres);
			}
		} catch (Exception e) {
			uploadStatus = "fail";
			e.printStackTrace();
		}

		response.sendRedirect("managegame.jsp?uploadStatus=" + uploadStatus);
		//getServletContext().getRequestDispatcher("/managegame.jsp?uploadStatus=" + uploadStatus).forward(request, response);
	}

}
