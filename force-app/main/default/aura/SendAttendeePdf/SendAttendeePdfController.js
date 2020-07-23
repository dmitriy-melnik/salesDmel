({
    sendPDF: function(cmp, event, helper) {

        var inputText = cmp.find("inputEmail").get("v.emailAddress");
        if (inputText != null) {
            cmp.set('v.isButtonActive', false);
        }

        var successLabel = $A.get("$Label.c.SUCCESS");
        var sendLabel = $A.get("$Label.c.PDF_is_send");

        var action = cmp.get("c.sendPDFByEmail");
        action.setParams({
            lessonId: cmp.get("v.recordId"),
            email: cmp.get("v.emailAddress")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "type": "SUCCESS",
                    "title": successLabel,
                    "message": sendLabel
                });
                toastEvent.fire();
                
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors && errors[0] && errors[0].message) {
                    console.log("Error message: " +  errors[0].message);
                } else {
                    console.log("Something went wrong");
                }
            }
        });
        $A.enqueueAction(action);
    }
})