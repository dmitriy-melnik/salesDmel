public with sharing class GuidHttpCallout {

    public static HttpResponse getGuidId() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://www.uuidgenerator.net/api/version1');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        return response;
    }

}