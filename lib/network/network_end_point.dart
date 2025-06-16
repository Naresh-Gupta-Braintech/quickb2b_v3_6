enum Endpoints { login, register }

const Map<Endpoints, String> endpointRawValues = {
  // AUTHENTICATION
  Endpoints.login: "apis/ac/loginNew",
  Endpoints.register: "apis/ac/customer/registration",
};
