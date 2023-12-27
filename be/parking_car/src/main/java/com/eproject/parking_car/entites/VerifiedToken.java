package com.eproject.parking_car.entites;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.*;
import org.apache.commons.lang.RandomStringUtils;

import java.util.Calendar;
import java.util.Date;
import java.util.Random;

@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "verified_token")
public class VerifiedToken {
    @Id
    @Column(name = "email", unique = true)
    private String email;

    @Column(name = "token")
    private String token;

    @Column(name = "expired_at")
    private Date expiredAt;

    public VerifiedToken(String email) {
        super();
        this.email = email;
        this.token = this.generateVerifiedToken();
        this.expiredAt = this.getTokenExpirationTime();
    }

    public Date getTokenExpirationTime() {
        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(new Date().getTime());
        calendar.add(Calendar.MINUTE,10);
        return new Date(calendar.getTime().getTime());
    }

    public String generateVerifiedToken() {
        Random random = new Random();
        StringBuilder stringBuilder = new StringBuilder();

        for (int i = 0; i < 6; i++) {
            int digit = random.nextInt(10); // Sinh số nguyên từ 0 đến 9
            stringBuilder.append(digit);
        }

        return stringBuilder.toString();
    }
}
