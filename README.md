# RadioStationAPI
A Swift Vapor project for a generic internet radio station API.

Based on the RAML API spec located [here](https://github.com/tylermilner/RadioStationAPISpec).

**🚧 This is a work in progress. 🚧**
* The general structure of the API has been defined and can be viewed in `Public/docs/index.html`.
* The endpoints have been stubbed out with static responses for now.
* A Postman collection is available in the `Postman` directory.

### Hosted on [vapor.cloud](
Base URL: https://radiostationapi-dev.vapor.cloud

### Endpoints
GET /config
POST /login
GET /nowPlaying
PUT /nowPlaying
GET /shows
POST /shows
GET /djs
POST /djs
