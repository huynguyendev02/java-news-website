package com.messi.king.messinews.utils;

import com.github.scribejava.apis.GitHubApi;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;
import org.json.JSONArray;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

public class GithubUtils {
    private static final String NETWORK_NAME = "GitHub";
    private static final String PROTECTED_RESOURCE_URL = "https://api.github.com/user/emails";
    private static final String clientId = "e576a6aea86a61bbd9f8";
    private static final String clientSecret = "4785cc26d8a901a12ef8213857b23356c1a82266";

    private static final OAuth20Service service = new ServiceBuilder(clientId)
            .apiSecret(clientSecret)
            .callback("http://localhost:8080/MessiNews/Account/GitLogin")
            .build(GitHubApi.instance());
    public static String getAuthURL() {
        final String authorizationUrl = service.getAuthorizationUrl();
        return authorizationUrl;
    }
    public static List<String> getInfo(String code) throws IOException, ExecutionException, InterruptedException {
        final OAuth2AccessToken accessToken = service.getAccessToken(code);
        final OAuthRequest request = new OAuthRequest(Verb.GET, PROTECTED_RESOURCE_URL);
        service.signRequest(accessToken, request);
        List <String> responseData = new ArrayList<>();
        try (Response response = service.execute(request)) {
            responseData.add(Integer.toString(response.getCode()));
            final JSONArray data = new JSONArray(response.getBody());
            responseData.add((String) data.getJSONObject(0).get("email"));
            return responseData;
        }
    }
}
