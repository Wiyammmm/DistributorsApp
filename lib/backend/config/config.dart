class Config {
  static const bearerToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjoiZnVuY3Rpb24gbm93KCkgeyBbbmF0aXZlIGNvZGVdIH0iLCJpYXQiOjE3MDk0NTI5MTF9._p0bLyqoqRjQ5asnx04FlTN4bpK3l_6op3pf-gQlKqA";
  static const loginUrl = "http://172.232.77.205:3003/api/v1/distributor/auth/";
  static const getTokenUrl =
      "http://172.232.77.205:3003/api/v1/distributor/token";

  static const getUserInfoUrl =
      "http://172.232.77.205:3003/api/v1/distributor/wallet/balance";

  static const updateFilipayCardBalanceUrl =
      "http://172.232.77.205:3003/api/v1/distributor/wallet/";

  static const getBalanceUrl =
      "http://172.232.77.205:3003/api/v1/distributor/wallet/riderwallet";

  static const getTransactionHistoryUrl =
      "http://172.232.77.205:3003/api/v1/distributor/transactionhistory/";

  static const sandboxUrl = "https://direct.sandbox.bnk.to/v1/checkout";

  static const sanboxApiToken =
      "SANDBOX-iEmLfcixhhnOPRdduBA0i0egl2u2K3HwiAyxhsS8kjJyLdfCfaS5Ne6SERgQ2DiX";
  static const username = "filipay123";
  static const password = "q@2X&bP#9L!sD5*";
}
