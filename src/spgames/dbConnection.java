package spgames;

import javax.servlet.http.HttpServletRequest;
import java.sql.*;

public class dbConnection {

	Connection conn;

	public dbConnection(HttpServletRequest request) throws ClassNotFoundException, SQLException {
		super();
		// Step 1: Load JDBC Driver
		Class.forName("com.mysql.jdbc.Driver");
		// Step 2: Define Connection URL
		String connURL = request.getServletContext().getInitParameter("jdbcURL");
		String connUser = request.getServletContext().getInitParameter("mysqlUser");
		String connPassword = request.getServletContext().getInitParameter("mysqlPassword");
		// Step 3: Establish connection to URL
		conn = DriverManager.getConnection(connURL + "?user=" + connUser + "&password=" + connPassword);
	}

	public Connection getConnection() {
		return conn;
	}

	public void addNewGame(String gameTitle, int devID, int pubID, Date releaseDate, String description,
			double price, String preowned, String imagePath, int[] genres) throws ClassNotFoundException, SQLException {

		// Insert into Game
		String addGameSQL = "INSERT INTO game (Title, Developer_ID, Publisher_ID, Release_Date, Description, Price, Preowned, Image_Path) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement addGame_pstmt = conn.prepareStatement(addGameSQL);
		addGame_pstmt.setString(1, gameTitle);
		addGame_pstmt.setInt(2, devID);
		addGame_pstmt.setInt(3, pubID);
		addGame_pstmt.setDate(4, releaseDate);
		addGame_pstmt.setString(5, description);
		addGame_pstmt.setDouble(6, price);
		addGame_pstmt.setString(7, preowned);
		addGame_pstmt.setString(8, imagePath);
		addGame_pstmt.executeUpdate();

		// Get new game's gameID
		String getGameIDSQL = "SELECT Game_ID FROM game WHERE Title = ? AND Developer_ID = ? AND Publisher_ID = ? AND Release_Date = ?";
		PreparedStatement getGameID_pstmt = conn.prepareStatement(getGameIDSQL);
		getGameID_pstmt.setString(1, gameTitle);
		getGameID_pstmt.setInt(2, devID);
		getGameID_pstmt.setInt(3, pubID);
		getGameID_pstmt.setDate(4, releaseDate);
		ResultSet getGameID_rs = getGameID_pstmt.executeQuery();
		getGameID_rs.next();
		int gameID = getGameID_rs.getInt(1);

		// Insert into Game_Genre
		PreparedStatement addGameGenre_pstmt = insertGameGenre(conn, gameID, genres);
		addGameGenre_pstmt.executeUpdate();
	}

	public void updateGame(int gameID, String gameTitle, int devID, int pubID, Date releaseDate,
			String description, double price, String preowned, String imagePath, int[] genres)
			throws ClassNotFoundException, SQLException {

		// Update Game
		String addGameSQL = "UPDATE game SET Title = ?, Developer_ID = ?, Publisher_ID = ?, Release_Date = ?, Description = ?, Price = ?, Preowned = ?, Image_Path = ? WHERE Game_ID = ?";
		PreparedStatement addGame_pstmt = conn.prepareStatement(addGameSQL);
		addGame_pstmt.setString(1, gameTitle);
		addGame_pstmt.setInt(2, devID);
		addGame_pstmt.setInt(3, pubID);
		addGame_pstmt.setDate(4, releaseDate);
		addGame_pstmt.setString(5, description);
		addGame_pstmt.setDouble(6, price);
		addGame_pstmt.setString(7, preowned);
		addGame_pstmt.setString(8, imagePath);
		addGame_pstmt.setInt(9, gameID);
		addGame_pstmt.executeUpdate();

		// Delete then Insert into Game_Genre
		String deleteGameGenreSQL = "DELETE FROM game_genre WHERE Game_ID = ?";
		PreparedStatement deleteGameGenre_pstmt = conn.prepareStatement(deleteGameGenreSQL);
		deleteGameGenre_pstmt.setInt(1, gameID);
		deleteGameGenre_pstmt.executeUpdate();

		PreparedStatement addGameGenre_pstmt = insertGameGenre(conn, gameID, genres);
		addGameGenre_pstmt.executeUpdate();
	}

	public PreparedStatement insertGameGenre(Connection conn, int gameID, int[] genres) throws SQLException {
		String insertGameGenreSQL = "INSERT INTO game_genre (Game_ID, Genre_ID) VALUES";
		for (int i = 0; i < genres.length; i++) {
			insertGameGenreSQL += " (?, ?)";
			if (i < genres.length - 1) {
				insertGameGenreSQL += ",";
			}
		}

		PreparedStatement insertGameGenre_pstmt = conn.prepareStatement(insertGameGenreSQL);
		for (int i = 1; i <= genres.length * 2; i++) {
			if (i % 2 != 0) {
				insertGameGenre_pstmt.setInt(i, gameID);
			} else {
				insertGameGenre_pstmt.setInt(i, genres[(i / 2) - 1]);
			}
		}

		return insertGameGenre_pstmt;
	}
}
