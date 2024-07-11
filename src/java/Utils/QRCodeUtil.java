package Utils;

import Models.Ticket;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

import javax.imageio.ImageIO;
import javax.mail.util.ByteArrayDataSource;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class QRCodeUtil {

    //Generate QRCode from text and return Part
    public ByteArrayDataSource generateQRCode(String data) throws WriterException, IOException {
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = qrCodeWriter.encode(data, BarcodeFormat.QR_CODE, 350, 350);

        BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix);
        ByteArrayOutputStream os = new ByteArrayOutputStream();
        ImageIO.write(bufferedImage, "png", os);
        byte[] imageInByte = os.toByteArray();
        os.close();
        ByteArrayDataSource dataSource = new ByteArrayDataSource(new ByteArrayInputStream(imageInByte), "image/png");
        return dataSource;
    }

    public List<File> QRCodeList(List<Ticket> tickets) {
        List<File> listFiles = new ArrayList<File>();
        byte[] buffer = new byte[4096];
        int bytesRead = -1;
            for (Ticket ticket : tickets) {
                File saveFile = new File( ticket.getSeat().getArea().areaName + "_" + ticket.getSeat().getRow() + ticket.getSeat().getSeatNumber()+ ".png");
                System.out.println("saveFile: " + saveFile.getAbsolutePath());
                try {
                    FileOutputStream outputStream = new FileOutputStream(saveFile);
                    // saves uploaded file
                    InputStream inputStream = generateQRCode(ticket.getCode()).getInputStream();
                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }
                    outputStream.close();
                    inputStream.close();
                    listFiles.add(saveFile);
                }catch (Exception e) {
                    e.printStackTrace();
                }
            }
        return listFiles;
    }

    private void deleteQRCodeList(List<File> listFiles) {
        if (listFiles != null && listFiles.size() > 0) {
            for (File aFile : listFiles) {
                aFile.delete();
            }
        }
    }

}
