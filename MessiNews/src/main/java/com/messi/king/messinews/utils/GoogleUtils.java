package com.messi.king.messinews.utils;

import com.github.scribejava.apis.GoogleApi20;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

public class GoogleUtils {
    private static final String PROTECTED_RESOURCE_URL = "https://www.googleapis.com/oauth2/v3/userinfo";
    private static final String clientId = "561751142391-ts8f0jegn3alsreh10g2k2t9veuet7on.apps.googleusercontent.com";
    private static final String clientSecret = "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";

    private static final OAuth20Service service = new ServiceBuilder(clientId)
            .apiSecret(clientSecret)
            .defaultScope("https://www.googleapis.com/auth/userinfo.email")
            .callback("hhttp://34.124.178.223.nip.io:8080/MessiNews/Account/GLogin")
            .build(GoogleApi20.instance());
    public static String getAuthURL() {
        final Map<String, String> additionalParams = new HashMap<>();
        additionalParams.put("prompt", "consent");
        final String authorizationUrl = service.createAuthorizationUrlBuilder()
                .additionalParams(additionalParams)
                .build();
        return authorizationUrl;
    }
    public static List<String> getInfo(String code) throws IOException, ExecutionException, InterruptedException {
        OAuth2AccessToken accessToken = service.getAccessToken(code);
//        accessToken = service.refreshAccessToken(accessToken.getRefreshToken());
        final String requestUrl = PROTECTED_RESOURCE_URL;
        final OAuthRequest request = new OAuthRequest(Verb.GET, requestUrl);
        service.signRequest(accessToken, request);
        List <String> responseData = new ArrayList<>();
        try (Response response = service.execute(request)) {
            final JSONObject obj = new JSONObject(response.getBody());
            responseData.add(Integer.toString(response.getCode()));
            responseData.add((String)obj.get("email"));
            return responseData;
        }
    }
}
