package lifelong.controller;

import lifelong.model.Invoice;
import lifelong.model.Member;
import lifelong.model.Receipt;
import lifelong.service.PaymentService;
import lifelong.service.RegisterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import utils.ImgPath;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.InvalidAlgorithmParameterException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("member")
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private RegisterService registerService;

    @GetMapping("/{memid}/payment_fill_detail/{invoice_id}")
    public String makePayment(@PathVariable("memid") String memId, @PathVariable("invoice_id") long invoiceId, Model model) {
        model.addAttribute("payment", paymentService.getInvoiceById(invoiceId));
        return "member/payment_fill_detail";
    }

    @PostMapping("/{memid}/payment_fill_detail/{invoice_id}/save")
    public String saveMakePayment(@PathVariable("memid") String memId,
                                  @PathVariable("invoice_id") long invoiceId,
                                  @RequestParam Map<String, String> params,
                                  @RequestParam("slip") MultipartFile slip_payment,
                                  HttpSession session) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        Invoice invoice = paymentService.getInvoiceById(invoiceId);
        if (invoice != null) {
            invoice.setPay_status(true);
            paymentService.updateInvoice(invoice);
        }

        Receipt receipt = new Receipt();

        /*********Convert Slip**********/
        try {
//            // Format ReceiptId
//            String invoiceToReceiptId = "Receipt " + invoiceId;
//
//            // ใช้ hashCode() และ Math.abs() เพื่อทำให้ค่าเป็นบวกเสมอ
//            long hashCode = Math.abs(invoiceToReceiptId.hashCode());
//
//            // นำ hashCode มาเป็นรหัส 10 หลัก (หรือตามที่คุณต้องการ)
//            String receiptCodeString = String.format("%010d", hashCode);
//
//            // แปลงเป็น long
//            long receiptCode = Long.parseLong(receiptCodeString);

            String yearString = String.valueOf(LocalDate.now().getYear());
            String receiptCode = yearString + String.format("%06d", invoiceId);

            receipt.setReceipt_id(Long.parseLong(receiptCode));
            receipt.setPay_date(dateFormat.parse(params.get("receipt_paydate")));
            receipt.setPay_time(params.get("receipt_paytime"));
            receipt.setBanking(params.get("receipt_banking"));
            receipt.setLast_four_digits(Integer.parseInt(params.get("last_four_digits")));
            receipt.setInvoice(paymentService.getInvoiceById(invoiceId));


            /**************** Image *******************/
            String slipPath = ImgPath.pathUploads + "/make_payment/slip/";

            /*** กำหนดเส้นทางสำหรับการบันทึกไฟล์รูปภาพ ***/
            Path directoryPathIMG = Paths.get(slipPath);
            Files.createDirectories(directoryPathIMG);

            /*** ดึงชื่อรูปจากไฟล์ที่อัพโหลดเข้ามา ***/
            String originalFileName = slip_payment.getOriginalFilename();

            /*** ดึงนามสกุลรูปภาพ ***/
            String fileExtension = getFileExtension(originalFileName);

            String newFileName = String.format("SLIP_%s%s", receiptCode, fileExtension);

            Path imgFilePath = Paths.get(slipPath, newFileName);
            Files.write(imgFilePath, slip_payment.getBytes());

            receipt.setSlip(newFileName);
            paymentService.saveReceipt(receipt);
        } catch (IOException e) {
            e.printStackTrace();
        }

        session.setAttribute("updateSuccess", true);
        return "redirect:/member/" + memId + "/listcourse/";
    }

    @GetMapping("/{memid}/receipt/{invoice_id}")
    public String printReceipt(@PathVariable("memid") String memId, @PathVariable("invoice_id") long invoiceId, Model model) {
        model.addAttribute("receipt", paymentService.getReceiptByInvoiceId(invoiceId));
        return "member/print_receipt";
    }



    @GetMapping("/{memid}/update_payment_fill_detail/{invoice_id}")
    public String updateMakePaymentDetail(@PathVariable("memid") String memId, @PathVariable("invoice_id") long invoiceId, Model model) {
        model.addAttribute("payment", paymentService.getInvoiceById(invoiceId));
        model.addAttribute("receipt", paymentService.getReceiptByInvoiceId(invoiceId));
        return "member/update_payment_fill_detail";
    }

    @PostMapping("/{memid}/update_payment_fill_detail/{invoice_id}/update")
    public String updateMakePayment(@PathVariable("memid") String memId, Model model,
                                    @PathVariable("invoice_id") long invoiceId,
                                    @RequestParam Map<String, String> params,
                                    @RequestParam(value = "original_slip", required = false) String original_slip,
                                    @RequestParam("slip") MultipartFile slip_payment,
                                    HttpSession session) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        Receipt receipt = paymentService.getReceiptByInvoiceId(invoiceId);

        if (receipt != null) {
            /*********Convert Slip**********/
            try {
                receipt.setPay_date(dateFormat.parse(params.get("receipt_paydate")));
                receipt.setPay_time(params.get("receipt_paytime"));
                receipt.setBanking(params.get("receipt_banking"));
                receipt.setLast_four_digits(Integer.parseInt(params.get("last_four_digits")));


                /**************** Image *******************/
                String slipPath = ImgPath.pathUploads + "/make_payment/slip/";

                Path path1 = Paths.get(slipPath, original_slip);
                if (original_slip != null) {
                    if (Files.exists(path1)) {
                        Files.delete(path1);
                    }
                }

                Files.write(path1, slip_payment.getBytes());

                receipt.setSlip(original_slip);
                paymentService.saveReceipt(receipt);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        Invoice invoice = paymentService.getInvoiceById(invoiceId);
        invoice.setApprove_status("รอดำเนินการ");
        paymentService.updateInvoice(invoice);

        session.setAttribute("update", "success");

        return "redirect:/member/" + memId + "/listcourse";
    }

    /********* Get นามสกุลไฟล์รูปภาพ **********/
    private String getFileExtension(String fileName) {
        int dotIndex = fileName.lastIndexOf('.');
        if (dotIndex > 0 && dotIndex < fileName.length() - 1) {
            return fileName.substring(dotIndex);
        }
        return "";
    }



//    @PostMapping("/upload_file/save")
//    public String saveMakePayment(@RequestParam("slip") MultipartFile slip_payment, HttpServletRequest request) throws IOException {
//        String fileName = request.getParameter("name");
//
//        /**************** Image *******************/
//        String slipPath = "C:/uploads/make_payment/slip/";
//
//        /*** กำหนดเส้นทางสำหรับการบันทึกไฟล์รูปภาพ ***/
//        Path directoryPathIMG = Paths.get(slipPath);
//        Files.createDirectories(directoryPathIMG);
//
//        /*** ดึงชื่อรูปจากไฟล์ที่อัพโหลดเข้ามา ***/
//        String originalFileName = slip_payment.getOriginalFilename();
//
//        /*** ดึงนามสกุลรูปภาพ ***/
//        String fileExtension = getFileExtension(originalFileName);
//
//        /******* File name *******/
//
//        String newFileName = String.format("SLIP_%s%s", fileName, fileExtension);
//
//        /******* แปลงข้อมูลไฟล์รูปให้เป็น Path ก่อนลง Directory *******/
//        Path imgFilePath = Paths.get(slipPath, newFileName);
//
//        /******* Save File to Directory *******/
//        Files.write(imgFilePath, slip_payment.getBytes());
//
//        return "redirect:/";
//    }





}
