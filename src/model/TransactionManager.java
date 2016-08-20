package model;

import spgames.dbConnection;

import javax.servlet.http.HttpServletRequest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class TransactionManager {

	private dbConnection db;
	private Connection conn;
	GameManager gameManager;

	public TransactionManager() {
		super();
	}

	public TransactionManager(HttpServletRequest request) {
		try {
			db = new dbConnection(request);
			conn = db.getConnection();
			gameManager = new GameManager(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ArrayList<Transaction> getTransactions(String email) {
		// ArrayList to store Transaction objects
		ArrayList<Transaction> transactions = new ArrayList<Transaction>();

		try {
			// Get transaction info
			String transactionSQL = "SELECT transaction.Transaction_ID AS Transaction_ID, Email, DATE_FORMAT(Transaction_Date, '%d %b %y %h:%i %p') AS Transaction_Date, Game_ID, Quantity_Bought FROM transaction, transaction_details WHERE transaction.Transaction_ID = transaction_details.Transaction_ID AND Email = ?";
			PreparedStatement transactionPstmt = conn.prepareStatement(transactionSQL);
			transactionPstmt.setString(1, email);
			ResultSet transactionRs = transactionPstmt.executeQuery();

			int tID = 0;
			Transaction transact = new Transaction();
			while (transactionRs.next()) {
				int transactionId = transactionRs.getInt("Transaction_ID");
				if (tID != transactionId) {

					transact = new Transaction();

					tID = transactionId;
					transact.setTransactionID(tID);
					transact.setTransactionDate(transactionRs.getString("Transaction_Date"));
					transactions.add(transact);
				}

				Game game = gameManager.getGameInfo(transactionRs.getInt("Game_ID"));
				game.setQuantityToBuy(transactionRs.getInt("Quantity_Bought"));
				transact.addGame(game);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return transactions;
	}

	public void insertTransaction(Transaction transaction) {
		try {
			// Insert into transaction table
			String insertTransactionSQL = "INSERT INTO transaction (Email, Transaction_Date) VALUES (?, NOW())";
			PreparedStatement insertTransactionPstmt = conn.prepareStatement(insertTransactionSQL);
			insertTransactionPstmt.setString(1, transaction.getEmail());
			insertTransactionPstmt.executeUpdate();

			// Get transaction ID of transaction made by user
			String tIdSQL = "SELECT Transaction_ID FROM transaction WHERE Email = ? ORDER BY Transaction_ID DESC LIMIT 1";
			PreparedStatement tIdPstmt = conn.prepareStatement(tIdSQL);
			tIdPstmt.setString(1, transaction.getEmail());
			ResultSet tIdRs = tIdPstmt.executeQuery();
			if (tIdRs.next()) {
				transaction.setTransactionID(tIdRs.getInt("Transaction_ID"));
			}

			// Insert into transaction_details table
			String insertTransactionDetailsSQL = "INSERT INTO transaction_details (Transaction_ID, Game_ID, Quantity_Bought) VALUES (?, ?, ?)";
			PreparedStatement insertTransactionDetailsPstmt = conn.prepareStatement(insertTransactionDetailsSQL);
			insertTransactionDetailsPstmt.setInt(1, transaction.getTransactionID());
			for (Game g : transaction.getGames()) {
				insertTransactionDetailsPstmt.setInt(2, g.getGameId());
				insertTransactionDetailsPstmt.setInt(3, g.getQuantityToBuy());
				insertTransactionDetailsPstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}