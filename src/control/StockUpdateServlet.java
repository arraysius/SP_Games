package control;

import model.GameManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/StockUpdateServlet")
public class StockUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	public StockUpdateServlet() {
		super();
	}


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// Get new quantity info
		int newQty = Integer.parseInt(request.getParameter("qty"));
		int gameID = Integer.parseInt(request.getParameter("gameID"));
		GameManager gameManager = new GameManager(request);

		// Check value of qty
		boolean updateStatus;
		if (newQty >= 0) {
			updateStatus = gameManager.updateStock(gameID, newQty);
			if (updateStatus) {
				response.sendRedirect("stockQtyReport.jsp?status=success");
			}
		} else {
			response.sendRedirect("stockQtyReport.jsp?status=fail");
		}
	}

}
