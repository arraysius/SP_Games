package model;

import java.util.ArrayList;

public class Game {

	private int gameId;
	private String title;
	private String developer;
	private String publisher;
	private ArrayList<String> genres;
	private String releaseDate;
	private String description;
	private double price;
	private String preowned;
	private int quantity;
	private String imagePath;

	private int quantityToBuy;

	public Game() {
		super();
	}

	public Game(int gameId, String title, String developer, String publisher, ArrayList<String> genres, String releaseDate, String description, double price, String preowned, int quantity, String imagePath) {
		this.gameId = gameId;
		this.title = title;
		this.developer = developer;
		this.publisher = publisher;
		this.genres = genres;
		this.releaseDate = releaseDate;
		this.description = description;
		this.price = price;
		this.preowned = preowned;
		this.quantity = quantity;
		this.imagePath = imagePath;
	}

	public int getGameId() {
		return gameId;
	}

	public String getTitle() {
		return title;
	}

	public String getDeveloper() {
		return developer;
	}

	public String getPublisher() {
		return publisher;
	}

	public ArrayList<String> getGenres() {
		return genres;
	}

	public String getReleaseDate() {
		return releaseDate;
	}

	public String getDescription() {
		return description;
	}

	public double getPrice() {
		return price;
	}

	public String getPreowned() {
		return preowned;
	}

	public int getQuantity() {
		return quantity;
	}

	public String getImagePath() {
		return imagePath;
	}

	public int getQuantityToBuy() {
		return quantityToBuy;
	}

	public void setQuantityToBuy(int quantityToBuy) {
		this.quantityToBuy = quantityToBuy;
	}
}
