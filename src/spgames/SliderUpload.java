package spgames;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(maxFileSize = 10485760)
public class SliderUpload extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String uploadStatus = "success";

		try {
			// Get all the required fields from uploadFile.jsp
			String imageName = "slider" + request.getParameter("sliderid") + ".jpg";
			Part filePart = request.getPart("sliderimage");

			// Gets save location
			String savePath = getServletContext().getInitParameter("slider-location");

			filePart.write(savePath + File.separator + imageName);
		} catch (Exception e) {
			uploadStatus = "fail";
			e.printStackTrace();
		}

		response.sendRedirect("manageslider.jsp");
		// getServletContext().getRequestDispatcher("/manageslider.jsp").forward(request, response);
	}

}
