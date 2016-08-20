package control;

import model.Cart;
import model.Game;
import model.GameManager;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/CartManageServlet")
public class CartManageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CartManageServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("index.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// Get game ID and quantity of game user wants to buy
			int gameId = Integer.parseInt(request.getParameter("gameId"));
			int buyQuantity = Integer.parseInt(request.getParameter("quantity"));

			// Get session
			HttpSession session = request.getSession();

			// Check for user and cart in session
			User user = (User) session.getAttribute("user");
			Cart cart = (Cart) session.getAttribute("cart");
			if (user != null) {
				if (cart == null) {
					cart = new Cart();
				}
			} else {
				response.sendRedirect("login.jsp?login=expired");
			}

			// Create game object
			GameManager gameManager = new GameManager(request);
			Game game = gameManager.getGameInfo(gameId);

			// Remove game from cart if it exists
			// Otherwise add game to cart
			if (buyQuantity > 0 && buyQuantity <= game.getQuantity()) {
				if (cart.hasGame(gameId)) {
					cart.updateQuantityToBuy(gameId, buyQuantity);
				} else {
					game.setQuantityToBuy(buyQuantity);
					cart.addGame(game);
				}
			} else {
				cart.removeGame(gameId);
			}

			// Add cart to session
			session.setAttribute("cart", cart);

			// Redirect to previous page
			response.sendRedirect(request.getHeader("Referer"));
		} catch (Exception e) {
			e.printStackTrace();
			// response.sendRedirect("error.jsp");
		}
	}

}
