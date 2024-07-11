package Utils;


public class Common {

    public static void addToCommandIfNotNull(StringBuilder commandBuilder, String field, Object value) {
        if (value != null) {
            commandBuilder.append(field).append(" = '").append(value).append("', ");
        }
    }

    public static void addToCommandIfNotDefault(StringBuilder commandBuilder, String field, int value, int defaultValue) {
        if (value != defaultValue) {
            commandBuilder.append(field).append(" = ").append(value).append(", ");
        }
    }

    public static class JsonResponse {

        private final boolean isSuccess;
        private final String message;
        private Object data = null;
        private String redirectUrl = "TicketGoal";

        public JsonResponse(boolean isSuccess, String message) {
            this.isSuccess = isSuccess;
            this.message = message;
        }

        public JsonResponse(boolean isSuccess, String message, Object data) {
            this.isSuccess = isSuccess;
            this.message = message;
            this.data = data;
        }

        public JsonResponse(boolean isSuccess, String message, String redirectUrl) {
            this.isSuccess = isSuccess;
            this.message = message;
            this.redirectUrl = redirectUrl;
        }


        public boolean isSuccess() {
            return isSuccess;
        }

        public String getMessage() {
            return message;
        }

        public String getRedirectUrl() {
            return redirectUrl;
        }
    }

}
