package com.messi.king.messinews.utils;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;
import javax.net.ssl.HttpsURLConnection;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;

public class CaptchaUtils {
    final static String SECRET_KEY = "6LcyK9gjAAAAAPxptcTXuJf_rXl2uZ3LmRHm8ObX";
    final static String SITE_VERIFY_URL = //
            "https://www.google.com/recaptcha/api/siteverify";
    public static boolean checkCaptcha(String captcha) {
        boolean check = false;

        try {
            URL verifyUrl = new URL(SITE_VERIFY_URL);
            HttpsURLConnection conn = (HttpsURLConnection) verifyUrl.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("User-Agent", "Mozilla/5.0");
            conn.setRequestProperty("Accept-Language", "en-US,en;q=0.5");

            String postParams = "secret=" + SECRET_KEY + "&response=" + captcha;
            conn.setDoOutput(true);

            OutputStream outStream = conn.getOutputStream();
            outStream.write(postParams.getBytes());

            outStream.flush();
            outStream.close();

            InputStream is = conn.getInputStream();
            JsonReader jsonReader = Json.createReader(is);
            JsonObject jsonObject = jsonReader.readObject();
            jsonReader.close();

            check =  jsonObject.getBoolean("success");


        }catch (Exception e) {
            e.printStackTrace();
        }
        return  check;
    }
}
