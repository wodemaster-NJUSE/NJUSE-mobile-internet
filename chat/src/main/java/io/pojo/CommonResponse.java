package io.pojo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class CommonResponse<T> {
    private int code;
    private String message;
    private T data;

    public static <T> CommonResponse<T> success() {
        return new CommonResponse<T>();
    }

    public static <T> CommonResponse<T> success(T data) {
        CommonResponse<T> response = new CommonResponse<>();
        response.setData(data);
        return response;
    }

    public static <T> CommonResponse<T> success(int code) {
        CommonResponse<T> response = new CommonResponse<>();
        response.setCode(code);
        return response;
    }

    // Add other constructors, getters, and setters as needed
    public static <T> CommonResponse<T> failure() {
        return new CommonResponse<T>();
    }

    public static <T> CommonResponse<T> failure(T data) {
        CommonResponse<T> response = new CommonResponse<>();
        response.setData(data);
        return response;
    }

    public static <T> CommonResponse<T> failure(int code) {
        CommonResponse<T> response = new CommonResponse<>();
        response.setCode(code);
        return response;
    }
}
