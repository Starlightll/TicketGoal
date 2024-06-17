/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import java.util.Base64;
import java.util.Date;
import javax.crypto.SecretKey;

/**
 *
 * @author MSI VN
 */
public class JwtUtil {
    private static final String SECRET = "8zbX8FN1yh_tR3TH3_EkbPTEF7SbCECueHaXj6fCx9I"; 

    private static SecretKey getSecretKey() {
        byte[] decodedKey = Base64.getUrlDecoder().decode(SECRET);
        return Keys.hmacShaKeyFor(decodedKey);
    }

    public static String generateToken(String userId) {
        return Jwts.builder()
                .setSubject(userId)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + 60000))
                .signWith(getSecretKey(), SignatureAlgorithm.HS256)
                .compact();
    }

    public static String getUserIdFromToken(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(getSecretKey())
                .build()
                .parseClaimsJws(token)
                .getBody()
                .getSubject();
    }
}
