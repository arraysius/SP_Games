package spgames;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Mailer {

	public static String sendMail(final String toEmail, final String secretkey) {

		final String fromEmail = "noreply.spgames@gmail.com";
		final String password = "**********";
		final String subject = "Reset your password";
		String bodyMessage = "Hi,\n\nPlease head to the following link to reset your password.\n\nhttps://shop-spgamesead.rhcloud.com/resetPassword.jsp?secret="
				+ secretkey + "\n\nCheers,\nSP Games";
		String sentStatus = "success";

		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");

		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(fromEmail, password);
			}
		});

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(fromEmail));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
			message.setSubject(subject);
			message.setText(bodyMessage);

			Transport.send(message);

		} catch (Exception e) {
			sentStatus = "fail";
		}

		return sentStatus;
	}

}
