enum Endpoints { login, register, getHomeItems, getCompanyDetails, getCartList, getCustomerList, getOutLet }

const Map<Endpoints, String> endpointRawValues = {
  // AUTHENTICATION
  Endpoints.login: "/apis/ac/loginNew",
  Endpoints.register: "/apis/ac/customer/registration",
  Endpoints.getHomeItems: "/apis/get_home_items_v6",
  Endpoints.getCompanyDetails: "/apis/getCompanydetails",
  Endpoints.getCartList: "/apis/cart_list_v6",
  Endpoints.getCustomerList: "/apis/ac/customerList",
  Endpoints.getOutLet: "/apis/get_outlets",
};
