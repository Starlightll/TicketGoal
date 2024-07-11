/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.Admin.PitchManagement;

import DAO.SeatDAO;
import DAO.SeatStatusDAO;
import Models.Seat;
import Models.SeatStatus;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@MultipartConfig(maxFileSize = 16177215)
public class SeatServlet extends HttpServlet {

    private static final SeatDAO seatDAO = SeatDAO.INSTANCE;
    private static final SeatStatusDAO seatStatusDAO = SeatStatusDAO.INSTANCE;

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
                addSeat(request, response);
                break;
            case "edit":
                List<SeatStatus> listStatus = seatStatusDAO.getSeatStatusList();
                request.setAttribute("seatStatus", listStatus);
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
                int resultAll = seatDAO.deleteSeatByArea(areaIdDelete);
                String messageAll = "Delete all  successfully";
                if (resultAll < 1) messageAll = "Delete all fail.";
                String pitchIdToBack = request.getParameter("pitchId");
                response.sendRedirect("pitchManagementServlet?option=update&pitchId=" + pitchIdToBack + "&areaId=" + areaIdDelete + "&message=" + messageAll);
                break;
            case "delete":
                int seatIdDelete = Integer.parseInt(request.getParameter("seatId"));
                int result = seatDAO.deleteSeat(seatIdDelete);
                String message = "Delete successfully";
                if (result < 1) message = "Delete fail.";
                String pitchId = request.getParameter("pitchId");
                String areaId = request.getParameter("areaId");
                response.sendRedirect("pitchManagementServlet?option=update&pitchId=" + pitchId + "&areaId=" + areaId + "&message=" + message);
                break;
            default:
                throw new AssertionError();
        }
//check di bạn
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
                addSeat(request, response);
                break;
            case "edit":
                editSeat(request, response);
                String pitchIdEdit = request.getParameter("pitchId");
                break;
            case "import":
                importFileEx(request, response);
                break;
            default:
                throw new AssertionError();
        }
    }

    private void importFileEx(HttpServletRequest request, HttpServletResponse response) {
        try {
            Part filePart = request.getPart("file");
            try (InputStream fileContent = filePart.getInputStream()) {
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
                boolean isOk = false;
                boolean isFail = false;
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
                                    seat.setArea(new Models.Area(areaId, null));
                                } else {
                                    int seatStatusId = (int) cell.getNumericCellValue();
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
                    if (index == 5) {
                        Seat isExist = seatDAO.finSeatByIdNumber(seat.getArea().id, seat.getSeatNumber());
                        if (isExist == null) {
                            int result = seatDAO.insert(seat);
                            if (result > 0) {
                                isOk = true;
                            }
                        } else {
                            isFail = true;
                        }
                    } else {
                        isFail = true;
                    }
                }
                workbook.close();
                String message = "";
                if (isOk) {
                    message = "Import success" + (isFail ? ".Some row in correct or seat is exist and dont save this row in db" : "");
                } else {
                    message = "Import fail. Please check seatnumber, price";
                }
                String pitchId = request.getParameter("pitchId");
                String areaId = request.getParameter("areaId");
                response.sendRedirect("pitchManagementServlet?option=update&pitchId=" + pitchId + "&areaId=" + areaId + "&message=" + message);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (Exception e) {
            System.out.println("e");
        }
    }
//    test di ban

    private void addSeat(HttpServletRequest request, HttpServletResponse response) {
        //get information seatNumber, price, areaId, seatStatusId
        try {
            int seatNumber = Integer.parseInt(request.getParameter("seatNumber"));
            int price = Integer.parseInt(request.getParameter("price"));
            int areaId = Integer.parseInt(request.getParameter("areaId"));
            int seatStatusId = Integer.parseInt(request.getParameter("seatStatusId"));
            Seat seat = new Seat();
            seat.setSeatNumber(seatNumber);
            seat.setPrice(price);
            seat.setArea(new Models.Area(areaId, null));
            seat.setSeatStatusId(seatStatusId);
            Seat isExist = seatDAO.finSeatByIdNumber(areaId, seatNumber);
            //add to database
            if (isExist == null) {
                String message = "";
                int result = seatDAO.insert(seat);
                if (result > 0) {
                    message = "Add new success";
                } else {
                    message = "Add new fail. Please check seatnumber, price";
                }
                String pitchId = request.getParameter("pitchId");
                response.sendRedirect("pitchManagementServlet?option=update&pitchId=" + pitchId + "&areaId=" + areaId + "&message=" + message);
            } else {
                String pitchId = request.getParameter("pitchId");
                response.sendRedirect("pitchManagementServlet?option=update&pitchId=" + pitchId + "&areaId=" + areaId + "&message=" + "Seat is exist");
            }
        } catch (Exception e) {

        }
    }

    private void editSeat(HttpServletRequest request, HttpServletResponse response) {
        try {
            int seatId = Integer.parseInt(request.getParameter("seatId"));
            int seatNumber = Integer.parseInt(request.getParameter("seatNumber"));
            int oldSeat = Integer.parseInt(request.getParameter("oldSeat"));
            int price = Integer.parseInt(request.getParameter("price"));
            int areaId = Integer.parseInt(request.getParameter("areaId"));
            int seatStatusId = Integer.parseInt(request.getParameter("seatStatusId"));
            Seat seat = new Seat();
            seat.setSeatId(seatId);
            seat.setSeatNumber(seatNumber);
            seat.setPrice(price);
            seat.setArea(new Models.Area(areaId, null));
            seat.setSeatStatusId(seatStatusId);
            Seat isExist = seatDAO.finSeatByIdNumber(areaId, seatNumber);
            if (isExist == null || (isExist != null && isExist.getSeatNumber() == oldSeat)) {
                //edit database
                int result = seatDAO.edit(seat);
                String message = "";
                if (result > 0) {
                    message = "Update success";
                } else {
                    message = "Update fail. Please check seatnumber, price";
                }
                String pitchId = request.getParameter("pitchId");
                response.sendRedirect("pitchManagementServlet?option=update&pitchId=" + pitchId + "&areaId=" + areaId + "&message=" + message);
            } else {
                String pitchId = request.getParameter("pitchId");
                response.sendRedirect("pitchManagementServlet?option=update&pitchId=" + pitchId + "&areaId=" + areaId + "&message=Seat is exist");
            }
        } catch (Exception e) {
        }
    }

}
