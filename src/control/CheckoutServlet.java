package control;

import com.stripe.Stripe;
import com.stripe.exception.*;
import com.stripe.model.Charge;
import model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Check if Cart object and User object in session
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		Cart cart = (Cart) session.getAttribute("cart");
		if (user == null || cart == null || cart.getGames().size() <= 0) {
			response.sendRedirect("login.jsp?login=expired");
			return;
		}

		// Process checkout
		Stripe.apiKey = "sk_test_X1MvCFOebCoHQFc6lrn2yR5K";

		// Get the credit card details submitted by the form
		String token = request.getParameter("stripeToken");

		// Create the charge on Stripe's servers - this will charge the user's card
		try {
			Map<String, Object> chargeParams = new HashMap<String, Object>();
			chargeParams.put("amount", cart.getTotalPriceInCents()); // amount in cents, again
			chargeParams.put("currency", "sgd");
			chargeParams.put("source", token);
			chargeParams.put("description", "Games charge");

			// Charge member for games
			Charge charge = Charge.create(chargeParams);

			// Insert transaction details into db
			TransactionManager transactionManager = new TransactionManager(request);
			transactionManager.insertTransaction(new Transaction(user.getEmail(), cart.getGames()));

			// Deduct stock
			GameManager gameManager = new GameManager(request);
			gameManager.deductStock(cart.getGames());

			// Clear cart in session
			session.removeAttribute("cart");

			response.sendRedirect("profile.jsp");
		} catch (CardException e) {
			// Since it's a decline, CardException will be caught
			e.printStackTrace();
			response.sendRedirect("cart.jsp?checkout=decline");
		} catch (RateLimitException e) {
			// Too many requests made to the API too quickly
			e.printStackTrace();
			response.sendRedirect("cart.jsp?checkout=invalid");
		} catch (InvalidRequestException e) {
			// Invalid parameters were supplied to Stripe's API
			e.printStackTrace();
			response.sendRedirect("cart.jsp?checkout=invalid");
		} catch (AuthenticationException e) {
			// Authentication with Stripe's API failed
			// (maybe you changed API keys recently)
			e.printStackTrace();
			response.sendRedirect("cart.jsp?checkout=invalid");
		} catch (APIConnectionException e) {
			// Network communication with Stripe failed
			e.printStackTrace();
			response.sendRedirect("cart.jsp?checkout=stripeerror");
		} catch (StripeException e) {
			// Display a very generic error to the user, and maybe send
			// yourself an email
			e.printStackTrace();
			response.sendRedirect("cart.jsp?checkout=stripeerror");
		} catch (Exception e) {
			// Something else happened, completely unrelated to Stripe
			e.printStackTrace();
			response.sendRedirect("cart.jsp?checkout=error");
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("cart.jsp");
	}
}
