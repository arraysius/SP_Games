package model;

import java.util.ArrayList;

public class Cart {

	private ArrayList<Game> games = new ArrayList<Game>();
	private int totalPriceInCents;

	public Cart() {
		super();
	}

	public ArrayList<Game> getGames() {
		return games;
	}

	public boolean hasGame(int gameId) {
		for (Game g : games) {
			if (g.getGameId() == gameId) {
				return true;
			}
		}
		return false;
	}

	public Game getGame(int gameId) {
		for (Game g : games) {
			if (g.getGameId() == gameId) {
				return g;
			}
		}
		return null;
	}

	public void addGame(Game game) {
		games.add(game);
		updateTotalPrice();
	}

	public void removeGame(int gameId) {
		for (Game g : games) {
			if (g.getGameId() == gameId) {
				games.remove(g);
				break;
			}
		}
		updateTotalPrice();
	}

	public int getTotalPriceInCents() {
		return totalPriceInCents;
	}

	public void updateTotalPrice() {
		int overallPrice = 0;
		for (Game g : games) {
			overallPrice += Math.round(g.getPrice() * 100) * g.getQuantityToBuy();
		}
		totalPriceInCents = overallPrice;
	}

	public void updateQuantityToBuy(int gameId, int quantityToBuy) {
		for (Game g : games) {
			if (g.getGameId() == gameId) {
				g.setQuantityToBuy(quantityToBuy);
				break;
			}
		}
		updateTotalPrice();
	}

}
