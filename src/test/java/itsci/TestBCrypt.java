package itsci;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.time.LocalDate;
import java.util.Date;

public class TestBCrypt {
    public static void main(String[] args) {
//        BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
//        String encrypted = bCryptPasswordEncoder.encode("1234");
//        System.out.println("Encrypt: " + encrypted);

        for (int i = 0; i< 1 ; i++){
            System.out.printf(LocalDate.now().getYear() + "%06d",i);
        }
    }
}
