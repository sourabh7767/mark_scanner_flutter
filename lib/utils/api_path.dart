class ApiPath{
  ApiPath._();
  static String BasePath="http://35.162.200.42/scanner_app/public/api/v1/user/";

 static String loginPath=BasePath+"login";
 static String logoutPath=BasePath+"logout";
 static String shopDetailPath=BasePath+"shop_detail";
 static String invoiceListPath=BasePath+"invoice_list";
 static String saveInvoicePath=BasePath+"save_invoice";
 static String changePasswordPath=BasePath+"changePassword";
 static String getCodeData(String code)=>"https://vpic.nhtsa.dot.gov/api/vehicles/decodevinextended/$code?format=json";

}