package control;

import model.MemberManager;
import model.User;
import spgames.format;
import spgames.hasher;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.regex.Pattern;

/**
 * Servlet implementation class MemberAddServlet
 */
@WebServlet("/MemberAddServlet")
public class MemberAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MemberAddServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("login.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get email
		String email = request.getParameter("email");
		if (email == null || !email.trim().matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$")) {
			response.sendRedirect("register.jsp?status=fail");
			return;
		} else {
			email = email.toLowerCase().trim();
		}

		// Get password
		String password = request.getParameter("password");

		if (password == null || password.contains(" ") || password.length() < 8 || password.length() > 16 || !format.hasLetterHasDigit(password)) {
			response.sendRedirect("login.jsp?login=fail");
			return;
		}

		// Confirm password
		String password2 = request.getParameter("password2");
		if (!password.equals(password2)) {
			response.sendRedirect("register.jsp?status=fail");
			return;
		}
		String hashedPassword = hasher.hash256(email + hasher.hash256(password));

		// Get name
		String name = request.getParameter("name");
		if (name == null || !(name.matches("^[a-zA-Z ]+$"))) {
			response.sendRedirect("register.jsp?status=fail");
			return;
		}
		name = name.trim();

		// Get phone number
		String phone = request.getParameter("phone");
		if (!(phone.matches("^[689][0-9]{7}$"))) {
			response.sendRedirect("register.jsp?status=fail");
			return;
		}
		int phoneNumber = Integer.parseInt(phone);

		// Get address 1
		String address1 = request.getParameter("address1");
		if (!(Pattern.compile("[a-zA-Z ]+").matcher(address1.trim()).find() && Pattern.compile("[0-9]*").matcher(address1.trim()).find()) || Pattern.compile("[<>\\\\]+").matcher(address1.trim()).find()) {
			response.sendRedirect("register.jsp?status=fail");
			return;
		}
		address1 = address1.trim();

		// Get address 2
		String address2 = request.getParameter("address2");
		if (address2 == null || !(Pattern.compile("[a-zA-Z ]*").matcher(address2.trim()).find() && Pattern.compile("[0-9]*").matcher(address2.trim()).find()) || Pattern.compile("[<>\\\\]+").matcher(address2.trim()).find()) {
			response.sendRedirect("register.jsp?status=fail");
			return;
		}
		address2 = address2.trim();

		// Get postal code
		String postal = request.getParameter("postalcode");
		if (postal == null || !(postal.matches("^[0-9]{6}$"))) {
			response.sendRedirect("register.jsp?status=fail");
			return;
		}
		int postalCode = Integer.parseInt(postal);

		// Generate secret key
		String secretKey = hasher.hash256(email + name);

		// Insert member into db
		MemberManager manager = new MemberManager(request);
		User newUser = new User(email, name, hashedPassword, secretKey, "N", phoneNumber, address1, address2, postalCode);
		if (!manager.insertMember(newUser)) {
			response.sendRedirect("register.jsp?status=fail");
		}

		response.sendRedirect("login.jsp?register=success");
	}

}
