package com.eproject.parking_car.configs;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class CloudinaryConfig {
    private final String CLOUD_NAME = "dpnkkp6rl";
    private final String API_KEY = "543196873967968";
    private final String API_SECRET = "LQDdUJNg6yYQ07DE7AwUZ1OtiEI";


    @Bean
    public Cloudinary configCloudinary() {
        return new Cloudinary(ObjectUtils.asMap(
                "cloud_name", CLOUD_NAME,
                "api_key", API_KEY,
                "api_secret", API_SECRET,
                "secure", true
        ));
    }
}
