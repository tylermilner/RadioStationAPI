# RadioStationAPI
A Swift Vapor project for a generic internet radio station API.

Based on the RAML API spec located [here](https://github.com/tylermilner/RadioStationAPISpec).

**🚧 This is a work in progress. 🚧**
* The general structure of the API has been defined, but is subject to change at any point.
* The endpoints have been stubbed out with static responses for now.
* A Postman collection is available in the `Postman` directory.

### Proudly hosted on [vapor.cloud](https://vapor.cloud)
**Base URL**

`https://radiostationapi-dev.vapor.cloud`
*Please note that no root route exists so don't expect to see anything if you copy/paste the link into your web browser.*

**Docs**

Documentation is available in `Public/docs/index.html` or can be viewed [online](https://radiostationapi-dev.vapor.cloud/docs/index.html).

### Endpoints

GET /config
POST /login
GET /nowPlaying
PUT /nowPlaying
GET /shows
POST /shows
GET /djs
POST /djs
