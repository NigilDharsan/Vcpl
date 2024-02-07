enum Environment { DEV, STAGING, PROD }

class ConstantApi {
  static Map<String, dynamic> _config = _Config.debugConstants;

  static String loginUrl = SERVER_ONE + "login";
  static String siteInfoUrl = SERVER_ONE + "site_info";
  static String siteListUrl = SERVER_ONE + "site_list";
  static String vehicleListUrl = SERVER_ONE + "vehicle_list";
  static String getCementStocks = SERVER_ONE + "get_cement_stocks";
  static String addCementTransaction = SERVER_ONE + "add_cement_transaction";
  static String pendingApprovalCementTransactions =
      SERVER_ONE + "pending_approval_cement_transactions";
  static String acceptCementTransaction =
      SERVER_ONE + "accept_cement_transaction";
  static String declineCementTransaction =
      SERVER_ONE + "decline_cement_transaction";
  static String cementTransactionList = SERVER_ONE + "cement_transaction_list";
  static String laboursCategory = SERVER_ONE + "labours_category";

  static String assignLabour = SERVER_ONE + "assign_labour";
  static String centeringMaterials = SERVER_ONE + "centering_materials";
  static String getCenteringStocks = SERVER_ONE + "get_centering_stocks";
  static String addCenteringTransaction =
      SERVER_ONE + "add_centering_transaction";
  static String pendingApprovalCenteringTransactions =
      SERVER_ONE + "pending_approval_centering_transactions";
  static String acceptCenteringTransaction =
      SERVER_ONE + "accept_centering_transaction";
  static String declineCenteringTransaction =
      SERVER_ONE + "decline_centering_transaction";
  static String centeringTransactionList =
      SERVER_ONE + "centering_transaction_list";

  static String toolsandplantsMaterial = SERVER_ONE + "toolsandplants_material";
  static String getToolsandplantsStocks =
      SERVER_ONE + "get_toolsandplants_stocks";
  static String addToolsandplantsTransaction =
      SERVER_ONE + "add_toolsandplants_transaction";
  static String pending_approval_toolsandplants_transactions =
      SERVER_ONE + "pending_approval_toolsandplants_transactions";
  static String accept_toolsandplants_transaction =
      SERVER_ONE + "accept_toolsandplants_transaction";
  static String decline_toolsandplants_transaction =
      SERVER_ONE + "decline_toolsandplants_transaction";
  static String toolsandplants_transaction_list =
      SERVER_ONE + "toolsandplants_transaction_list";

  static String lorry_materials = SERVER_ONE + "lorry_materials";
  static String get_lorry_stocks = SERVER_ONE + "get_lorry_stocks";
  static String add_lorry_transaction = SERVER_ONE + "add_lorry_transaction";
  static String pending_approval_lorry_transactions =
      SERVER_ONE + "pending_approval_lorry_transactions";
  static String accept_lorry_transaction =
      SERVER_ONE + "accept_lorry_transaction";
  static String decline_lorry_transaction =
      SERVER_ONE + "decline_lorry_transaction";
  static String lorry_transaction_list = SERVER_ONE + "lorry_transaction_list";

  static String SOMETHING_WRONG = "Some thing wrong";
  static String NO_INTERNET = "No internet Connection";
  static String BAD_RESPONSE = "Bad Response";
  static String UNAUTHORIZED = "Un Athurized";

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        _config = _Config.debugConstants;
        break;
      case Environment.STAGING:
        _config = _Config.stagingConstants;
        break;
      case Environment.PROD:
        _config = _Config.prodConstants;
        break;
    }
  }

  static get SERVER_ONE {
    return _config[_Config.SERVER_ONE];
  }

  static get BUILD_VARIANTS {
    return _config[_Config.BUILD_VARIANTS];
  }
}

class _Config {
  static const SERVER_ONE = "";
  static const BUILD_VARIANTS = "vcpl-dev";

  static Map<String, dynamic> debugConstants = {
    SERVER_ONE: "https://vcpl1987.co.in/dev/api/",
    BUILD_VARIANTS: "vcpl-dev",
  };

  static Map<String, dynamic> stagingConstants = {
    SERVER_ONE: "https://vcpl1987.co.in/dev/api/",
    BUILD_VARIANTS: "vcpl-dev",
  };

  static Map<String, dynamic> prodConstants = {
    SERVER_ONE: "https://vcpl1987.co.in/dev/api/",
    BUILD_VARIANTS: "vcpl-dev",
  };
}
