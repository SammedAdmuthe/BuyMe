package emailNotification;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class emailNotification {
    private String host = "smtp.office365.com"; // Outlook SMTP server
    private String port = "587"; // Outlook SMTP port
    private String username = "buymeshoppingapp@outlook.com"; // your Outlook email address
    private String password = "Buyme123"; // your Outlook password

    public void sendEmail(String toEmail, String subject, String message) {
        Properties props = new Properties();
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                return new javax.mail.PasswordAuthentication(username, password);
            }
        });

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(username));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            msg.setSubject(subject);
            msg.setText(message);
            Transport.send(msg);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
