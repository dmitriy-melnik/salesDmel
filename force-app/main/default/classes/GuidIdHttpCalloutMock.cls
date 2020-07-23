@IsTest
public with sharing class GuidIdHttpCalloutMock implements HttpCalloutMock {

    public static final String guidId = 'd21a3046-bbc2-11ea-b3de-0242ac130004';

    public HttpResponse respond(HttpRequest param1) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'text');
        response.setBody(guidId);
        response.setStatusCode(200);
        return response;
    }
}