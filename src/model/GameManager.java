package model;

import spgames.dbConnection;

import javax.servlet.http.HttpServletRequest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class GameManager {

	private dbConnection db;
	private Connection conn;

	public GameManager() {
		super();
	}

	public GameManager(HttpServletRequest request) {
		try {
			db = new dbConnection(request);
			conn = db.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public Game getGameInfo(int gameId) {
		try {
			String getGameInfoSQL = "SELECT Title, Developer_Name, Publisher_Name, DATE_FORMAT(Release_Date, '%d %M %Y') AS Release_Date, Description, Price, CASE WHEN Preowned = 'Y' THEN 'Yes' ELSE 'No' END AS Preowned, Quantity, CASE WHEN Image_Path = '' THEN 'images/game/default.jpg' ELSE Image_Path END AS Image_Path FROM game, developer, publisher WHERE game.Game_ID = ? AND game.Developer_ID = developer.Developer_ID AND game.Publisher_ID = publisher.Publisher_ID";
			PreparedStatement getGameInfoPstmt = conn.prepareStatement(getGameInfoSQL);
			getGameInfoPstmt.setInt(1, gameId);
			ResultSet getGameInfoRs = getGameInfoPstmt.executeQuery();
			if (getGameInfoRs.next()) {
				String gameTitle = getGameInfoRs.getString("Title");
				String gameDev = getGameInfoRs.getString("Developer_Name");
				String gamePub = getGameInfoRs.getString("Publisher_Name");
				String gameReleaseDate = getGameInfoRs.getString("Release_Date");
				String gameDescription = getGameInfoRs.getString("Description");
				double gamePrice = getGameInfoRs.getDouble("Price");
				String gamePreowned = getGameInfoRs.getString("Preowned");
				int gameQuantity = getGameInfoRs.getInt("Quantity");
				String gameImagePath = getGameInfoRs.getString("Image_Path");

				String getGameGenresSQL = "SELECT Genre_Name FROM genre WHERE Genre_ID IN (SELECT Genre_ID FROM game_genre WHERE Game_ID = ?) ORDER BY Genre_Name";
				PreparedStatement getGameGenresPstmt = conn.prepareStatement(getGameGenresSQL);
				getGameGenresPstmt.setInt(1, gameId);
				ResultSet getGameGenresRs = getGameGenresPstmt.executeQuery();
				ArrayList<String> gameGenres = new ArrayList<String>();
				while (getGameGenresRs.next()) {
					gameGenres.add(getGameGenresRs.getString("Genre_Name"));
				}

				return new Game(gameId, gameTitle, gameDev, gamePub, gameGenres, gameReleaseDate, gameDescription, gamePrice, gamePreowned, gameQuantity, gameImagePath);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	public ArrayList<Game> getSelectedGames(int maxQty) {
		ArrayList<Game> games = new ArrayList<Game>();
		try {
			// Get all game ID
			String getSelectedGames = "SELECT Game_ID FROM game WHERE Quantity < ? ORDER BY Title";
			PreparedStatement getSelectedGamesPstmt = conn.prepareStatement(getSelectedGames);
            getSelectedGamesPstmt.setInt(1, maxQty);
			ResultSet getSelectedGamesRs = getSelectedGamesPstmt.executeQuery();

			// Add game object into arraylist
			while (getSelectedGamesRs.next()) {
				games.add(getGameInfo(getSelectedGamesRs.getInt("Game_ID")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return games;
	}

	public ArrayList<Game> getAllGames() {
		ArrayList<Game> games = new ArrayList<Game>();
		try {
			// Get all game ID
			String getAllGames = "SELECT Game_ID FROM game ORDER BY Title";
			PreparedStatement getAllGamesPstmt = conn.prepareStatement(getAllGames);
			ResultSet getAllGamesRs = getAllGamesPstmt.executeQuery();

			// Add game object into arraylist
			while (getAllGamesRs.next()) {
				games.add(getGameInfo(getAllGamesRs.getInt("Game_ID")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return games;
	}

	public boolean updateStock(int gID, int newQty) {
		try {
			String updateStockSQL = "UPDATE game SET Quantity = ? WHERE Game_ID = ?";
			PreparedStatement updateStockpstmt = conn.prepareStatement(updateStockSQL);
			updateStockpstmt.setInt(1, newQty);
			updateStockpstmt.setInt(2, gID);
			updateStockpstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	public void deductStock(ArrayList<Game> games) {
		try {
			String deductStockSQL = "UPDATE game SET Quantity = Quantity - ? WHERE Game_ID = ?";
			PreparedStatement deductStockPstmt = conn.prepareStatement(deductStockSQL);
			for (Game g : games) {
				deductStockPstmt.setInt(1, g.getQuantityToBuy());
				deductStockPstmt.setInt(2, g.getGameId());
				deductStockPstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
