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

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.InvalidAlgorithmParameterException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Map;

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
    public String saveMakePayment(@PathVariable("memid") String memId, @PathVariable("invoice_id") long invoiceId, @RequestParam Map<String, String> params, @RequestParam("slip") MultipartFile file, HttpSession session) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        Invoice invoice = paymentService.getInvoiceById(invoiceId);
        if (invoice != null) {
            invoice.setPay_status(true);
            paymentService.updateInvoice(invoice);
        }

        Receipt receipt = new Receipt();

        /*********Convert Slip**********/
        try {
            receipt.setReceipt_id(0);
            receipt.setPay_date(dateFormat.parse(params.get("receipt_paydate")));
            receipt.setPay_time(params.get("receipt_paytime"));
            receipt.setBanking(params.get("receipt_banking"));
            receipt.setLast_four_digits(Integer.parseInt(params.get("last_four_digits")));
            receipt.setInvoice(paymentService.getInvoiceById(invoiceId));


            // กำหนด path ที่จะบันทึกไฟล์
            String uploadPath = ImgPath.pathImg + "/slip/";

            // ตรวจสอบและสร้างโฟลเดอร์ถ้าไม่มี
            Path directoryPath = Paths.get(uploadPath);
            Files.createDirectories(directoryPath);

            // ดึงนามสกุลไฟล์จากชื่อไฟล์
            String originalFileName = file.getOriginalFilename();
            String fileExtension = getFileExtension(originalFileName);


            int latestFileCount = paymentService.getLatestFileCount(); // แทนที่ด้วยเมธอดหรือวิธีที่คุณใช้ในการดึงข้อมูลล่าสุด

            // สร้างรหัสไฟล์ใหม่ในรูปแบบ "IMG_0001", "IMG_0002", ...
            String newFileName = String.format("SLIP_%04d%s", ++latestFileCount, fileExtension);

            // บันทึกไฟล์ลงในโฟลเดอร์ที่ใช้เพื่อแสดงผลในเว็บ
            // บันทึกไฟล์ PDF ลงในโฟลเดอร์ที่ใช้เพื่อแสดงผลในเว็บ
            Path filePath = Paths.get(uploadPath, newFileName);
            Files.write(filePath, file.getBytes());

            // บันทึกเส้นทางไฟล์ในฐานข้อมูล
            receipt.setSlip(newFileName);
            paymentService.saveReceipt(receipt);
        } catch (IOException e) {
            e.printStackTrace();
        }

        session.setAttribute("updateSuccess",true);
        return "redirect:/member/" + memId + "/listcourse/";
    }

    @GetMapping("/{memid}/receipt/{invoice_id}")
    public String printReceipt(@PathVariable("memid") String memId, @PathVariable("invoice_id") long invoiceId, Model model) {
        model.addAttribute("receipt",paymentService.getReceiptByInvoiceId(invoiceId));
        return "member/print_receipt";
    }

    private String getFileExtension(String fileName) {
        int dotIndex = fileName.lastIndexOf('.');
        if (dotIndex > 0 && dotIndex < fileName.length() - 1) {
            return fileName.substring(dotIndex);
        }
        return "";
    }

    @GetMapping("/{memid}/update_payment_fill_detail/{invoice_id}")
    public String updateMakePaymentDetail(@PathVariable("memid") String memId, @PathVariable("invoice_id") long invoiceId, Model model) {
        model.addAttribute("payment", paymentService.getInvoiceById(invoiceId));
        model.addAttribute("receipt", paymentService.getReceiptByInvoiceId(invoiceId));
        return "member/update_payment_fill_detail";
    }

    @PostMapping("/{memid}/update_payment_fill_detail/{invoice_id}/update")
    public String updateMakePayment(@PathVariable("memid") String memId, Model model, @PathVariable("invoice_id") long invoiceId, @RequestParam Map<String, String> params, @RequestParam("slip") MultipartFile file, HttpSession session) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        Receipt receipt = paymentService.getReceiptByInvoiceId(invoiceId);

        if (receipt != null){
            /*********Convert Slip**********/
            try {
                receipt.setPay_date(dateFormat.parse(params.get("receipt_paydate")));
                receipt.setPay_time(params.get("receipt_paytime"));
                receipt.setBanking(params.get("receipt_banking"));
                receipt.setLast_four_digits(Integer.parseInt(params.get("last_four_digits")));



                // กำหนด path ที่จะบันทึกไฟล์
                String uploadPath = ImgPath.pathImg + "/slip/";

                // ตรวจสอบและสร้างโฟลเดอร์ถ้าไม่มี
                Path directoryPath = Paths.get(uploadPath);
                Files.createDirectories(directoryPath);

                // ดึงนามสกุลไฟล์จากชื่อไฟล์
                String originalFileName = file.getOriginalFilename();
                String fileExtension = getFileExtension(originalFileName);


                int latestFileCount = paymentService.getLatestFileCount(); // แทนที่ด้วยเมธอดหรือวิธีที่คุณใช้ในการดึงข้อมูลล่าสุด

                // สร้างรหัสไฟล์ใหม่ในรูปแบบ "IMG_0001", "IMG_0002", ...
                String newFileName = String.format("SLIP_%04d%s", ++latestFileCount, fileExtension);

                // บันทึกไฟล์ลงในโฟลเดอร์ที่ใช้เพื่อแสดงผลในเว็บ
                // บันทึกไฟล์ PDF ลงในโฟลเดอร์ที่ใช้เพื่อแสดงผลในเว็บ
                Path filePath = Paths.get(uploadPath, newFileName);
                Files.write(filePath, file.getBytes());

                // บันทึกเส้นทางไฟล์ในฐานข้อมูล
                receipt.setSlip(newFileName);

                paymentService.saveReceipt(receipt);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        Invoice invoice = paymentService.getInvoiceById(invoiceId);
        invoice.setApprove_status("รอดำเนินการ");
        paymentService.updateInvoice(invoice);

        session.setAttribute("update","success");

        return "redirect:/member/" + memId + "/listcourse";
    }



}
