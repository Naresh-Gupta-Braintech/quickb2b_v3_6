enum Endpoints { login, register, getHomeItems }

const Map<Endpoints, String> endpointRawValues = {
  // AUTHENTICATION
  Endpoints.login: "/apis/ac/loginNew",
  Endpoints.register: "/apis/ac/customer/registration",
  Endpoints.getHomeItems: "/apis/get_home_items_v6",
};
