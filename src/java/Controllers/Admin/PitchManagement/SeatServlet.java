/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.Admin.PitchManagement;

import Models.Seat;
import DAO.SeatDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import static org.apache.poi.ss.usermodel.CellType.BOOLEAN;
import static org.apache.poi.ss.usermodel.CellType.NUMERIC;
import static org.apache.poi.ss.usermodel.CellType.STRING;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

@MultipartConfig(maxFileSize = 16177215)
public class SeatServlet extends HttpServlet {

    private static final SeatDAO seatDAO = new SeatDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //get all seats
        List<Seat> listSeats = seatDAO.findAll();
        //set to request
        request.setAttribute("listSeats", listSeats);
        String action = request.getParameter("action") == null
                ? "default"
                : request.getParameter("action");
        switch (action) {
            case "add":
                addSeat(request);
                response.sendRedirect("pitchManagement?option=update");
                break;
            case "edit":
                int seatId = Integer.parseInt(request.getParameter("seatId"));
                Seat seat = seatDAO.findAllById(seatId);
                request.setAttribute("seatEdit", seat);
                request.setAttribute("pitchId", request.getParameter("pitchId"));
                request.getRequestDispatcher("./Views/Admin/Pitch/UpdateSeat.jsp").forward(request, response);
                break;
            case "import":
                request.setAttribute("areaId", request.getParameter("areaId"));
                request.setAttribute("pitchId", request.getParameter("pitchId"));
                request.getRequestDispatcher("./Views/Admin/Pitch/importSeat.jsp").forward(request, response);
                break;
            case "deleteAll":
                int areaIdDelete = Integer.parseInt(request.getParameter("areaId"));
                 seatDAO.deleteSeatByArea(areaIdDelete);
                String pitchIdToBack = request.getParameter("pitchId");
                response.sendRedirect("pitchManagementServlet?option=update&pitchId=" +pitchIdToBack + "&areaId=" +areaIdDelete);
                break;
            case "delete":
                int seatIdDelete = Integer.parseInt(request.getParameter("seatId"));
                seatDAO.deleteSeat(seatIdDelete);
                String pitchId = request.getParameter("pitchId");
                String areaId = request.getParameter("areaId");
                response.sendRedirect("pitchManagementServlet?option=update&pitchId=" +pitchId + "&areaId=" +areaId);
                break;
            default:
                throw new AssertionError();
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // get action
        String action = request.getParameter("action") == null
                ? "default"
                : request.getParameter("action");
        switch (action) {
            case "add":
                addSeat(request);
                String pitchId = request.getParameter("pitchId");
                String areaId = request.getParameter("areaId");
                response.sendRedirect("pitchManagementServlet?option=update&pitchId=" +pitchId + "&areaId=" +areaId);
                break;
            case "edit":
                editSeat(request);
                String pitchIdEdit = request.getParameter("pitchId");
                response.sendRedirect("pitchManagementServlet?option=update&pitchId="+pitchIdEdit+"&areaId=" + request.getParameter("areaId"));
                break;
            case "import":
                importFileEx(request, response);
                String pitchIdBack = request.getParameter("pitchId");
                String areaIdBack = request.getParameter("areaId");
                response.sendRedirect("pitchManagementServlet?option=update&pitchId=" +pitchIdBack + "&areaId=" +areaIdBack);
                break;
            default:
                throw new AssertionError();
        }
    }

    private void importFileEx(HttpServletRequest request, HttpServletResponse response) {
        try {
            Part filePart = request.getPart("file");
            try ( InputStream fileContent = filePart.getInputStream()) {
                Workbook workbook = null;
                String fileName = filePart.getSubmittedFileName();
                if (fileName.endsWith(".xlsx")) {
                    workbook = new XSSFWorkbook(fileContent);
                } else if (fileName.endsWith(".xls")) {
                    workbook = new HSSFWorkbook(fileContent);
                } else {
                    throw new IllegalArgumentException("The file format is not supported.");
                }
                Sheet sheet = workbook.getSheetAt(0);
                for (Row row : sheet) {
                    Seat seat = new Seat();
                    int index = 0;
                    for (Cell cell : row) {
                        switch (cell.getCellType()) {
                            case STRING:
                                break;
                            case NUMERIC:
                                if (index == 1) {
                                    int seatNumber = (int) cell.getNumericCellValue();
                                    seat.setSeatNumber(seatNumber);
                                } else if (index == 2) {
                                    int price = (int) cell.getNumericCellValue();
                                    seat.setPrice(price);
                                } else if (index == 3) {
                                    int areaId = (int) cell.getNumericCellValue();
                                    seat.setAreaId(areaId);
                                } else {
                                     int seatStatusId = (int)cell.getNumericCellValue();
                                     seat.setSeatStatusId(seatStatusId);
                                }
                                break;
                            case BOOLEAN:
                                break;
                            default:
                                break;
                        }
                        index++;
                    }
                    seatDAO.insert(seat);
                }
                System.out.println("Import done");
                workbook.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            System.out.println("e");
        }
    }

    private void addSeat(HttpServletRequest request) {
        //get information seatNumber, price, areaId, seatStatusId
        try {
            int seatNumber = Integer.parseInt(request.getParameter("seatNumber"));
            int price = Integer.parseInt(request.getParameter("price"));
            int areaId = Integer.parseInt(request.getParameter("areaId"));
            int seatStatusId = Integer.parseInt(request.getParameter("seatStatusId"));
            Seat seat = new Seat();
            seat.setSeatNumber(seatNumber);
            seat.setPrice(price);
            seat.setAreaId(areaId);
            seat.setSeatStatusId(seatStatusId);
            //add to database
            seatDAO.insert(seat);
        } catch (Exception e) {

        }
    }

    private void editSeat(HttpServletRequest request) {
        try {
            int seatId = Integer.parseInt(request.getParameter("seatId"));
            int seatNumber = Integer.parseInt(request.getParameter("seatNumber"));
            int price = Integer.parseInt(request.getParameter("price"));
            int areaId = Integer.parseInt(request.getParameter("areaId"));
            int seatStatusId = Integer.parseInt(request.getParameter("seatStatusId"));
            Seat seat = new Seat();
            seat.setSeatId(seatId);
            seat.setSeatNumber(seatNumber);
            seat.setPrice(price);
            seat.setAreaId(areaId);
            seat.setSeatStatusId(seatStatusId);
            //edit database
            seatDAO.edit(seat);
        } catch (Exception e) {
        }
    }

}
