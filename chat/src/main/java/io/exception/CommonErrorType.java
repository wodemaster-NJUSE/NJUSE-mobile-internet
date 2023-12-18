package io.exception;

public enum CommonErrorType implements ErrorType {
    ILLEGAL_ARGUMENTS(100001, "Illegal arguments", 400);
    // Add more error types as needed

    private final int code;
    private final String message;
    private final int httpCode;

    CommonErrorType(int code, String message, int httpCode) {
        this.code = code;
        this.message = message;
        this.httpCode = httpCode;
    }

    @Override
    public int getCode() {
        return code;
    }

    @Override
    public String getMessage() {
        return message;
    }

    @Override
    public int getHttpCode() {
        return httpCode;
    }
    }
