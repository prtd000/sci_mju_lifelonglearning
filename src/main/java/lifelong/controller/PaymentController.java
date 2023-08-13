package lifelong.controller;

import lifelong.model.Receipt;
import lifelong.service.PaymentService;
import lifelong.service.RegisterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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

    @GetMapping("/{memid}/payment_detail/{invoice_id}")
    public String paymentDetail(@PathVariable("memid") String memId, @PathVariable("invoice_id") long invoiceId, Model model) {
        model.addAttribute("payment", paymentService.getInvoiceById(invoiceId));
        return "member/payment_detail";
    }

    @GetMapping("/{memid}/payment_fill_detail/{invoice_id}")
    public String paymentFillDetail(@PathVariable("memid") String memId, @PathVariable("invoice_id") long invoiceId, Model model) {
        model.addAttribute("payment", paymentService.getInvoiceById(invoiceId));
        return "member/payment_fill_detail";
    }

    @PostMapping("/{memid}/payment_fill_detail/{invoice_id}/save")
    public String savePaymentFillDetail(@PathVariable("memid") String memId, @PathVariable("invoice_id") long invoiceId, Model model, @RequestParam Map<String, String> params) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd");

        Receipt receipt = new Receipt();
        receipt.setSlip(params.get("slip"));
        receipt.setPay_date(dateFormat.parse(params.get("receipt_paydate")));
        receipt.setPay_time(params.get("receipt_paytime"));
        receipt.setBanking(params.get("receipt_banking"));
        receipt.setTotal(Double.parseDouble(params.get("receipt_total")));
        receipt.setLast_four_digits(Integer.parseInt(params.get("last_four_digits")));
        receipt.setInvoice(paymentService.getInvoiceById(invoiceId));

        /*update pay status*/
        /*..................*/


        paymentService.saveReceipt(receipt);
        return "redirect:/member/" + memId + "/listcourse";
    }

}
