package model;

import java.util.ArrayList;

public class Transaction {

	private int transactionID;
	private String email;
	private String transactionDate;
	private ArrayList<Game> games = new ArrayList<Game>();

	public Transaction() {
		super();
	}

	public Transaction(String email, ArrayList<Game> games) {
		this.email = email;
		this.games = games;
	}

	public Transaction(int transactionID, String email, String transactionDate) {
		this.transactionID = transactionID;
		this.email = email;
		this.transactionDate = transactionDate;
	}

	public Transaction(int transactionID, String email, String transactionDate, ArrayList<Game> games) {
		this.transactionID = transactionID;
		this.email = email;
		this.transactionDate = transactionDate;
		this.games = games;
	}

	public int getTransactionID() {
		return transactionID;
	}

	public void setTransactionID(int transactionID) {
		this.transactionID = transactionID;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTransactionDate() {
		return transactionDate;
	}

	public void setTransactionDate(String transactionDate) {
		this.transactionDate = transactionDate;
	}

	public ArrayList<Game> getGames() {
		return games;
	}

	public void setGames(ArrayList<Game> games) {
		this.games = games;
	}

	public void addGame(Game game) {
		games.add(game);
	}

}
