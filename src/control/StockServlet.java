package control;

import model.Game;
import model.GameManager;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;


@WebServlet("/StockServlet")
public class StockServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GameManager gameManager = new GameManager(request);
		String qtyInput = request.getParameter("quantitySelected");
		ArrayList<Game> games;
		int maxQty;
		if (qtyInput != null) {
			maxQty = Integer.parseInt(qtyInput);
			games = gameManager.getSelectedGames(maxQty);
		} else {
			games = gameManager.getAllGames();
		}
		request.setAttribute("games", games);
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("stockQtyReport.jsp");
		requestDispatcher.forward(request, response);
	}
}
